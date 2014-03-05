
package nl.b3p.schematron;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Node;

/**
 *
 * @author Matthijs Laan
 */
public class SchematronProcessor {
    private static final Log log = LogFactory.getLog(SchematronProcessor.class);

    private static final Object monitor = new Object();
    private static TransformerFactory transformerFactory;
    private static Templates includeTemplates, abstractExpandTemplates, svrlTemplates;
    
    /**
     * Cache of XSL stylesheets created from Schematrons. Map of Schematron 
     * file path to a pair of the last modified date of the file and the Templates
     * object.
     */
    private static final Map<String,Pair<Long,Templates>> schTemplatesCache = new HashMap();

    public static void schematron(Source document, String sch, Result messages) throws Exception {
        synchronized(monitor) {
            if(transformerFactory == null) {
                transformerFactory = TransformerFactory.newInstance();

                transformerFactory.setURIResolver(new URIResolver() {
                    @Override
                    public Source resolve(String href, String base) throws TransformerException {
                        try {
                            // Included by iso_svrl_for_xslt2.xsl, other includes
                            // are from .sch
                            if(href.equals("iso_schematron_skeleton_for_saxon.xsl")) {
                                InputStream is = SchematronProcessor.class.getResourceAsStream(href);
                                if(is == null) {
                                    throw new FileNotFoundException("XSL not found in classpath: " + href);
                                }
                                return new StreamSource(is);
                            } else {
                                return new StreamSource(new FileInputStream(href));
                            }
                        } catch(FileNotFoundException e) {
                            throw new TransformerException("Error loading resource " + href, e);
                        }
                    }
                });

                includeTemplates = transformerFactory.newTemplates(new StreamSource(SchematronProcessor.class.getResourceAsStream("iso_dsdl_include.xsl")));
                abstractExpandTemplates = transformerFactory.newTemplates(new StreamSource(SchematronProcessor.class.getResourceAsStream("iso_abstract_expand.xsl")));
                svrlTemplates = transformerFactory.newTemplates(new StreamSource(SchematronProcessor.class.getResourceAsStream("iso_svrl_for_xslt2.xsl")));
            }
        }
        
        Templates schTemplates;
        synchronized(schTemplatesCache) {
            Pair<Long,Templates> schCached = schTemplatesCache.get(sch);
            File schFile = new File(sch);
            
            if(schCached != null && schFile.lastModified() == schCached.getLeft().longValue()) {
                schTemplates = schCached.getRight();
            } else {
                
                DOMResult included = new DOMResult();
                Transformer t = includeTemplates.newTransformer();
                t.transform(new StreamSource(sch), included); 

                t = abstractExpandTemplates.newTransformer();
                DOMResult abstractExpanded = new DOMResult();
                t.transform(new DOMSource(included.getNode()), abstractExpanded);

                t = svrlTemplates.newTransformer();
                DOMResult schXsl = new DOMResult();
                t.transform(new DOMSource(abstractExpanded.getNode()), schXsl);
                
                schTemplates = transformerFactory.newTemplates(new DOMSource(schXsl.getNode()));
                schTemplatesCache.put(sch, Pair.of(schFile.lastModified(), schTemplates));
            }
        }
        
        Transformer t = schTemplates.newTransformer();
        t.transform(document, messages);
    }
    
    public static String xmlToString(Node n) throws Exception {
        TransformerFactory f = TransformerFactory.newInstance();
        Transformer t = f.newTransformer();
        t.setOutputProperty(OutputKeys.INDENT, "yes");
        
        StringWriter sw = new StringWriter();
        t.transform(new DOMSource(n), new StreamResult(sw));
        return sw.toString();
    }
    
    public static byte[] xmlToBytes(Node n) throws Exception {
        TransformerFactory f = TransformerFactory.newInstance();
        Transformer t = f.newTransformer();
        t.setOutputProperty(OutputKeys.INDENT, "yes");
        
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        t.transform(new DOMSource(n), new StreamResult(bos));
        return bos.toByteArray();
    }    
}
