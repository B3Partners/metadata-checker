
package nl.b3p.metadatachecker.stripes;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletResponse;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.controller.LifecycleStage;
import net.sourceforge.stripes.validation.Validate;
import static nl.b3p.metadatachecker.stripes.CheckActionBean.DEFAULT_SCH_DIR;
import static nl.b3p.metadatachecker.stripes.CheckActionBean.DEFAULT_SCH_OPTGROUP;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author Matthijs Laan
 */
@UrlBinding("/action/admin/sch")
public class SchEditActionBean implements ActionBean {
    private static final String JSP = "/WEB-INF/jsp/schedit.jsp";
    
    private ActionBeanContext context;

    private List<Pair<String,List<String>>> schematrons = new ArrayList();
    
    private List<String> directories = new ArrayList();
    
    @Validate(required=true, on={"download","remove"})
    private String schematron;
    
    @Validate(required=true, on="add")
    private String directory;
    
    @Validate(required=true, on="add")
    private FileBean file;
    
    //<editor-fold defaultstate="collapsed" desc="getters and setters">
    @Override
    public ActionBeanContext getContext() {
        return context;
    }
    
    @Override
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }
    
    public List<Pair<String, List<String>>> getSchematrons() {
        return schematrons;
    }
    
    public void setSchematrons(List<Pair<String, List<String>>> schematrons) {
        this.schematrons = schematrons;
    }

    public List<String> getDirectories() {
        return directories;
    }

    public void setDirectories(List<String> directories) {
        this.directories = directories;
    }

    public String getSchematron() {
        return schematron;
    }

    public void setSchematron(String schematron) {
        this.schematron = schematron;
    }

    public String getDirectory() {
        return directory;
    }

    public void setDirectory(String directory) {
        this.directory = directory;
    }

    public FileBean getFile() {
        return file;
    }

    public void setFile(FileBean file) {
        this.file = file;
    }
    //</editor-fold>
    
    @Before(stages=LifecycleStage.BindingAndValidation)
    public void loadSch() {
        schematrons.clear();
        CheckActionBean.loadSch(getContext(), schematrons);
    }    

    @Before(stages=LifecycleStage.BindingAndValidation)
    public void loadDirectories() {
        directories.add(CheckActionBean.DEFAULT_SCH_OPTGROUP);
        
        String additionalDirs = context.getServletContext().getInitParameter("schematronDirs");
        if(additionalDirs != null) {
            directories.addAll(Arrays.asList(additionalDirs.split(";")));
        }
    }

    @DefaultHandler
    @DontValidate
    public Resolution list() {
        return new ForwardResolution(JSP);
    }
    
    @After(stages=LifecycleStage.BindingAndValidation)
    public void useRealDefaultSchDir() {
        String realSchPath = getContext().getServletContext().getRealPath(DEFAULT_SCH_DIR);
        if(schematron != null && schematron.startsWith(DEFAULT_SCH_OPTGROUP)) {
            schematron = realSchPath + schematron.substring(DEFAULT_SCH_OPTGROUP.length());
        }
        if(DEFAULT_SCH_OPTGROUP.equals(directory)) {
            directory = realSchPath;
        }
    }
    
    public Resolution download() throws IOException {
        final FileInputStream is = new FileInputStream(schematron);
        
        String[] parts = schematron.split("/");
        final String filename = parts[parts.length-1];
        
        return new StreamingResolution("text/xml") {
            @Override
            public void stream(HttpServletResponse response) throws Exception {
                OutputStream os = response.getOutputStream();
                IOUtils.copy(is, os);
                os.flush();
            }            
        }.setFilename(filename)
        .setAttachment(true);
    }
    
    public Resolution remove() {
        new File(schematron).delete();
        loadSch();
        getContext().getMessages().add(new SimpleMessage("Bestand \"" + schematron + "\" is verwijderd"));
        return new RedirectResolution(SchEditActionBean.class).flash(this);
    }
    
    public Resolution add() throws IOException {
        file.save(new File(directory + "/" + file.getFileName()));
        loadSch();
        return list();
    }
}
