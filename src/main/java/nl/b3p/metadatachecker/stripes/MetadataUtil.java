
package nl.b3p.metadatachecker.stripes;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;

/**
 *
 * @author Matthijs Laan
 */
public class MetadataUtil {
    public static boolean isServiceMetadata(Document doc) {
        XPathFactory xpf = XPathFactory.newInstance();
        XPath xpath = xpf.newXPath();
        Object serviceIdentification = null;
        try {
            serviceIdentification = (Object)xpath.evaluate("/*[local-name()='MD_Metadata']/*[local-name()='identificationInfo']/*[local-name()='SV_ServiceIdentification']", doc,  XPathConstants.NODE);
        } catch (XPathExpressionException ex) {
        }
        return serviceIdentification != null;
    }

    public static String getMetadataStandardName(Document doc) {
        XPathFactory xpf = XPathFactory.newInstance();
        XPath xpath = xpf.newXPath();
        String s = null;
        try {
            s = (String)xpath.evaluate("/*[local-name()='MD_Metadata']/*[local-name()='metadataStandardVersion']/*[local-name()='CharacterString']", doc,  XPathConstants.STRING);
        } catch (XPathExpressionException ex) {
        }
        return s;
    }
}
