<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/jsp/taglibs.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Beheer Schematrons</title>
        <%@include file="/WEB-INF/jsp/style.jsp"%>
    </head>
    <body>
        <h1>Beheer Schematrons</h1>
        <p><a href="${contextPath}">Terug</a></p>
        <stripes:messages/>
        <stripes:errors/>
        <table border="1" style="border-collapse: collapse">
            <tr>
                <th>Directory</th>
                <th>Schematron</th>
            </tr>
            <c:forEach var="schGroup" items="${actionBean.schematrons}">
                <c:forEach var="sch" items="${schGroup.right}">
                    <tr>
                        <td><c:out value="${schGroup.left}"/></td>
                        <td><stripes:link beanclass="nl.b3p.metadatachecker.stripes.SchEditActionBean" event="download">
                                <stripes:param name="schematron" value="${schGroup.left}/${sch}"/>
                                <c:out value="${sch}"/>
                            </stripes:link>
                        </td>
                        <td><a href="#" onclick="remove('${schGroup.left}/${sch}')">Verwijderen</a></td>
                    </tr>
                </c:forEach>
            </c:forEach>
        </table>
        
<script type="text/javascript">
    function remove(sch) {
        if(confirm("Weet u zeker dat u \"" + sch + "\" wilt verwijderen?")) {
            var f = document.forms["f"];
            f.schematron.value = sch;
            el = document.createElement("input");
            el.type = "hidden";
            el.name = "remove";
            el.value = "y";
            f.appendChild(el);
            f.submit();
        }
    }
</script>
            
        <p/>
        <stripes:form beanclass="nl.b3p.metadatachecker.stripes.SchEditActionBean" name="f">
            <stripes:hidden name="schematron"/>
            <fieldset>
                <legend>Schematron toevoegen / updaten</legend>
                Directory: 
                <stripes:select name="directory">
                    <stripes:option/>
                    <stripes:options-collection collection="${actionBean.directories}"/>
                </stripes:select><p/>
                Bestand: <stripes:file name="file"/>
                <p>
                <stripes:submit name="add" value="Toevoegen"/>
            </fieldset>
        </stripes:form>
        
    </body>
</html>
