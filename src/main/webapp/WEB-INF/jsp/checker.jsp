<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/jsp/taglibs.jsp"%>

<!DOCTYPE html>

    <head>
        <title>Metadata checker</title>
    </head>
    <body>

        
        <h1>Metadata checker</h1>
        
        <p>Deze tool kan op een metadata XML document aantal Schematron regels toepassen
            en de resultaten rapporteren.</p>
        
            <stripes:form beanclass="nl.b3p.metadatachecker.stripes.CheckActionBean">
                <stripes:errors/>
                <stripes:messages/>
                
                <fieldset>
                    <legend>Metadata document om te checken</legend>
                    URL: <stripes:text name="documentLocation" size="100"/><p>
                        of<p>
                        CSW query: <stripes:text name="cswQuery" size="100"/><br>
                        CSW maxRecords: <stripes:text name="cswMaxRecords" size="10"/><p>
                        of<p>
                    Bestand: <stripes:file name="document"/>
                </fieldset>
                
                <fieldset>
                    <legend>Schematrons</legend>
                    
                    <stripes:select name="selectedSchematrons" multiple="true" size="6">
                        <c:forEach var="schGroup" items="${actionBean.schematrons}">
                            <optgroup label="<c:out value="${schGroup.left}"/>">
                                <c:forEach var="sch" items="${schGroup.right}">
                                    <stripes:option value="${schGroup.left}/${sch}"><c:out value="${sch}"/></stripes:option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </stripes:select>
                </fieldset>

                <fieldset>
                    <legend>Uitvoer</legend>                
                    <stripes:select name="disposition">
                        <stripes:option value="inline">Inline</stripes:option>
                        <stripes:option value="download">Download</stripes:option>
                    </stripes:select>
                        XSL stylesheet:<p>
                    <stripes:select name="selectedStylesheet" size="4">
                        <c:forEach var="xslGroup" items="${actionBean.stylesheets}">
                            <optgroup label="<c:out value="${xslGroup.left}"/>">
                                <c:forEach var="xsl" items="${xslGroup.right}">
                                    <stripes:option value="${xslGroup.left}/${xsl}"><c:out value="${xsl}"/></stripes:option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </stripes:select>
                </fieldset>
                <p/>
                <stripes:submit name="check" value="Check"/>
            </stripes:form>
                
                <pre>
${actionBean.results}
                </pre>                
    </body>
</html>
