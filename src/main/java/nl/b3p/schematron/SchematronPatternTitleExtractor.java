
package nl.b3p.schematron;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;

/**
 *
 * @author Matthijs Laan
 */
public class SchematronPatternTitleExtractor {
    private static final Log log = LogFactory.getLog(SchematronPatternTitleExtractor.class);
    
    private static final Map<String,Pair<Long,String>> schPatternTitleCache = new HashMap();
    
    public static String getSchPatternTitle(String sch) {
        
        File schFile = new File(sch);
        
        try {
            synchronized(schPatternTitleCache) {
                Pair<Long,String> cachedTitle = schPatternTitleCache.get(sch);

                if(cachedTitle != null && schFile.lastModified() == cachedTitle.getLeft().longValue()) {
                    return cachedTitle.getRight();
                } else {
                    DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                    dbf.setNamespaceAware(true);
                    DocumentBuilder db = dbf.newDocumentBuilder();
                    Document doc = db.parse(new FileInputStream(sch));

                    XPathFactory xpf = XPathFactory.newInstance();
                    XPath xpath = xpf.newXPath();
                    String title = (String)xpath.evaluate("/*[local-name()='schema']/*[local-name()='pattern']/*[local-name() = 'title']", doc,  XPathConstants.STRING);

                    schPatternTitleCache.put(sch, Pair.of(schFile.lastModified(), title));            
                    return title;
                }
            }
        } catch(Exception e) {
            log.warn("Cannot extract pattern title from Schematron \"" + sch + "\"", e);
            return "";
        }
    }    
}
