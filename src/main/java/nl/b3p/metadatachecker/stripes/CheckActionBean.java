package nl.b3p.metadatachecker.stripes;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.SimpleError;
import net.sourceforge.stripes.validation.Validate;
import net.sourceforge.stripes.validation.ValidationMethod;
import nl.b3p.schematron.SchematronProcessor;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.message.BasicNameValuePair;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author Matthijs Laan
 */
@StrictBinding
@UrlBinding("/action/check")
public class CheckActionBean implements ActionBean {
    private static final Log log = LogFactory.getLog(CheckActionBean.class);
    
    private static final String NAMESPACE_CSW = "http://www.opengis.net/cat/csw/2.0.2";
    
    private static final String DEFAULT_SCH_OPTGROUP = "Validaties NL metadata profiel";
    private static final String DEFAULT_SCH_DIR = "/WEB-INF/sch";
    
    private ActionBeanContext context;
    
    @Validate
    private String documentLocation;
    
    @Validate
    private String cswQuery;
    
    @Validate
    private int cswMaxRecords = 10;
    
    @Validate
    private Integer cswMaxRecordsTotal;
    
    @Validate
    private FileBean document;
    
    private String results;
    
    private List<Pair<String,List<String>>> schematrons = new ArrayList();
    
    private List<Pair<String,List<String>>> stylesheets = new ArrayList();
    
    @Validate
    private String disposition = "inline";
    
    @Validate
    private List<String> selectedSchematrons = new ArrayList();

    //<editor-fold defaultstate="collapsed" desc="getters and setters">
    @Override
    public ActionBeanContext getContext() {
        return context;
    }
    
    @Override
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }
    
    public String getDocumentLocation() {
        return documentLocation;
    }
    
    public void setDocumentLocation(String documentLocation) {
        this.documentLocation = documentLocation;
    }
    
    public String getResults() {
        return results;
    }
    
    public void setResults(String results) {
        this.results = results;
    }
    
    public FileBean getDocument() {
        return document;
    }
    
    public void setDocument(FileBean document) {
        this.document = document;
    }
    
    public String getDisposition() {
        return disposition;
    }
    
    public void setDisposition(String disposition) {
        this.disposition = disposition;
    }
    
    public List<Pair<String, List<String>>> getSchematrons() {
        return schematrons;
    }
    
    public void setSchematrons(List<Pair<String, List<String>>> schematrons) {
        this.schematrons = schematrons;
    }
    
    public List<Pair<String, List<String>>> getStylesheets() {
        return stylesheets;
    }
    
    public void setStylesheets(List<Pair<String, List<String>>> stylesheets) {
        this.stylesheets = stylesheets;
    }
    
    public List<String> getSelectedSchematrons() {
        return selectedSchematrons;
    }
    
    public void setSelectedSchematrons(List<String> selectedSchematrons) {
        this.selectedSchematrons = selectedSchematrons;
    }
    
    public String getCswQuery() {
        return cswQuery;
    }
    
    public void setCswQuery(String cswQuery) {
        this.cswQuery = cswQuery;
    }
    
    public int getCswMaxRecords() {
        return cswMaxRecords;
    }
    
    public void setCswMaxRecords(int cswMaxRecords) {
        this.cswMaxRecords = cswMaxRecords;
    }
    
    public Integer getCswMaxRecordsTotal() {
        return cswMaxRecordsTotal;
    }
    
    public void setCswMaxRecordsTotal(Integer cswMaxRecordsTotal) {
        this.cswMaxRecordsTotal = cswMaxRecordsTotal;
    }
    //</editor-fold>
    
    @Before(stages=LifecycleStage.BindingAndValidation)
    public void loadSch() {
        File f = new File(getContext().getServletContext().getRealPath(DEFAULT_SCH_DIR));
        schematrons.add(Pair.of(DEFAULT_SCH_OPTGROUP, Arrays.asList(f.list())));
        
        String additionalDirs = getContext().getServletContext().getInitParameter("schematronDirs");
        if(additionalDirs != null) {
            try {
                for(String dir: additionalDirs.split(";")) {
                    schematrons.add(Pair.of(dir, Arrays.asList(new File(dir).list())));
                }
            } catch(Exception e) {
                log.error("Exception loading Schematrons from directories " + additionalDirs, e);
            }
        }
    }
    
    @ValidationMethod(on = "check")
    public void checkInput() {
        if(documentLocation == null && cswQuery == null && document == null) {
            getContext().getValidationErrors().addGlobalError(new SimpleError("Document is verplicht"));
        }
        if(selectedSchematrons.isEmpty()) {
            getContext().getValidationErrors().addGlobalError(new SimpleError("Minimaal een schematron is verplicht"));
        }
    }
    
    @DefaultHandler
    public Resolution form() {
        return new ForwardResolution("/WEB-INF/jsp/checker.jsp");
    }
    
    private void applySchematrons(Document doc, DocumentBuilder db, Element output, byte[] document) throws Exception {
        for(String sch: selectedSchematrons) {
            String orgSch = sch;
            if(sch.startsWith(DEFAULT_SCH_OPTGROUP)) {
                sch = getContext().getServletContext().getRealPath(DEFAULT_SCH_DIR + sch.substring(DEFAULT_SCH_OPTGROUP.length()));
            }

            Source source = new StreamSource(new ByteArrayInputStream(document));

            DOMResult r = new DOMResult();
            SchematronProcessor.schematron(source, sch, r);

            // Workaround using XML serialization to bytes is required to avoid
            // org.w3c.dom.DOMException: NOT_SUPPORTED_ERR: The implementation does not support the requested type of object or operation. 
	        // at org.apache.xerces.dom.CoreDocumentImpl.adoptNode
            byte[] xml = SchematronProcessor.xmlToBytes(r.getNode());
            Document rDom = db.parse(new ByteArrayInputStream(xml));
            
            Element schematronOutput = (Element)doc.adoptNode(rDom.getDocumentElement());
            schematronOutput.setAttribute("schematron", orgSch);
            output.appendChild(schematronOutput);
        }
    }
    
    private void applySchematrons(Document doc, DocumentBuilder db, Element output, Node document) throws Exception {
        for(String sch: selectedSchematrons) {
            String orgSch = sch;
            if(sch.startsWith(DEFAULT_SCH_OPTGROUP)) {
                sch = getContext().getServletContext().getRealPath(DEFAULT_SCH_DIR + sch.substring(DEFAULT_SCH_OPTGROUP.length()));
            }

            Source source = new DOMSource(document);

            DOMResult r = new DOMResult();
            SchematronProcessor.schematron(source, sch, r);

            // Workaround using XML serialization to bytes is required to avoid
            // org.w3c.dom.DOMException: NOT_SUPPORTED_ERR: The implementation does not support the requested type of object or operation. 
	        // at org.apache.xerces.dom.CoreDocumentImpl.adoptNode
            byte[] xml = SchematronProcessor.xmlToBytes(r.getNode());
            Document rDom = db.parse(new ByteArrayInputStream(xml));
            
            Element schematronOutput = (Element)doc.adoptNode(rDom.getDocumentElement());
            schematronOutput.setAttribute("schematron", orgSch);
            output.appendChild(schematronOutput);
        }
    }
        
    
    private void handleCswQuery(Document doc, DocumentBuilder db, Element output) throws Exception {
        
        String cswPath = cswQuery.substring(0, cswQuery.indexOf("?")+1);
        
        // Parse CSW query string, remove maxRecords and startPosition
        
        List<NameValuePair> orgParams = URLEncodedUtils.parse(new URI(cswQuery), "UTF-8");
        List<NameValuePair> params = new ArrayList();
        
        for(NameValuePair p: orgParams) {
            if(!p.getName().toLowerCase().equals("maxrecords") && !p.getName().toLowerCase().equals("startposition")) {
                params.add(p);
            }
        }
        
        int startPosition = 1;
        int record = 1;
        do {
            List<NameValuePair> pageParams = new ArrayList(params);
            pageParams.add(new BasicNameValuePair("maxRecords", cswMaxRecords + ""));
            pageParams.add(new BasicNameValuePair("startPosition", startPosition + ""));
            
            URL u = new URL(cswPath + URLEncodedUtils.format(pageParams, "UTF-8"));
            
            System.out.println("CSW query: " + u);
            long time = System.currentTimeMillis();
            
            byte[] cswResponseBytes = IOUtils.toByteArray(u.openStream());
            Document cswResponse = db.parse(new ByteArrayInputStream(cswResponseBytes));
            
            NodeList nl = cswResponse.getElementsByTagNameNS(NAMESPACE_CSW, "SearchResults");
            Node searchResults = nl.item(0);
            
            startPosition = Integer.parseInt(searchResults.getAttributes().getNamedItem("nextRecord").getNodeValue());
          
            int numResults = searchResults.getChildNodes().getLength();
            if(numResults == 0) {
                break;
            }
            
            System.out.println("resultaten: " + numResults);
            
            for(int i = 0; i < numResults; i++) {
                Node searchResultDocument = searchResults.getChildNodes().item(i);
                
                System.out.println("Document: " + SchematronProcessor.xmlToString(searchResultDocument));
                byte[] documentBytes = SchematronProcessor.xmlToBytes(searchResultDocument);
                
                Element e = doc.createElement("output");
                e.setAttribute("record", record++ + "");                        
                output.appendChild(e);
                applySchematrons(doc, db, e, documentBytes);                
            }            
        } while(false);
    }
    
    public Resolution check() throws Exception {
    
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);
        DocumentBuilder db = dbf.newDocumentBuilder();
        Document doc = db.newDocument();
        
        Element root = doc.createElement("checked");

        try {
            long time = System.currentTimeMillis();

            byte[] documentBytes;
            if(document != null) {
                documentBytes = IOUtils.toByteArray(document.getInputStream());
                Element output = doc.createElement("output");
                output.setAttribute("file", document.getFileName());
                root.appendChild(output);
                applySchematrons(doc, db, output, documentBytes);
            } else if(documentLocation != null) {
                documentBytes = IOUtils.toByteArray(new URL(documentLocation).openStream());
                Element output = doc.createElement("output");
                output.setAttribute("location", documentLocation);
                root.appendChild(output);
                applySchematrons(doc, db, output, documentBytes);
            } else {
                handleCswQuery(doc, db, root);
            }

            results = "Time: " + String.format("%.1f", (System.currentTimeMillis() - time) / 1000.0) + "s\n";
        } finally {
            if(document != null) {
                document.delete();
            }
        }

        if("inline".equals(disposition)) {
            results += StringEscapeUtils.escapeHtml4(SchematronProcessor.xmlToString(root));
            return new ForwardResolution("/WEB-INF/jsp/checker.jsp");
        } else {
            return new StreamingResolution("text/xml", new ByteArrayInputStream(SchematronProcessor.xmlToBytes(root)));
        }
    }
    
}
