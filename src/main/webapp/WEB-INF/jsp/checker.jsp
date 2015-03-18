<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/jsp/taglibs.jsp"%>

<!DOCTYPE html>

    <head>
        <title>Metadata checker</title>
        <%@include file="/WEB-INF/jsp/style.jsp"%>
    </head>
    <body>

        
        <h1>Metadata checker</h1>
        
        <p>Deze tool kan op een metadata XML document aantal Schematron regels toepassen
            en de resultaten rapporteren.
        <p>Op <stripes:link beanclass="nl.b3p.metadatachecker.stripes.SchEditActionBean">deze pagina</stripes:link> kunnen de Schematrons worden beheerd. </p>
        <p>
            <stripes:form beanclass="nl.b3p.metadatachecker.stripes.CheckActionBean">
                <stripes:errors/>
                <stripes:messages/>
                
                <fieldset>
                    <legend>Metadata document om te checken</legend>
                    URL: <stripes:text name="documentLocation" size="100"/><p>
                        of<p>
                        CSW query: <stripes:text name="cswQuery" size="100"/><br>
                        CSW maxRecords per request: <stripes:text name="cswMaxRecords" size="10"/><br>
                        CSW totaal max: <stripes:text name="cswMaxRecordsTotal" size="10"/><p>
                        of<p>
                        Bestand: <stripes:file name="document"/>
                </fieldset>
                
<script>
    function useDefaultSchematronsClicked() {
        var useDefault = document.getElementById("useDefaultSchematrons").checked;
        
        document.getElementById("selectedSchematrons").disabled = useDefault;
    }
    
    window.onload = useDefaultSchematronsClicked;
    
</script>
            
                <fieldset>
                    <legend>Schematrons</legend>
                    <label><stripes:checkbox id="useDefaultSchematrons" name="useDefaultSchematrons" onclick="useDefaultSchematronsClicked();"/> Gebruik standaard Schematrons voor dataset/service en versie op basis van Schematron bestandsnamen</label>
                    <p>
                        Selecteer anders &eacute;&eacute;n of meerdere schematrons door de Control knop in te houden bij het aanklikken:<br>
                    <c:set var="size" value="${0}"/>
                    <c:forEach var="schGroup" items="${actionBean.schematrons}">
                        <c:set var="size" value="${size+1}"/>
                        <c:forEach var="sch" items="${schGroup.right}">
                            <c:set var="size" value="${size+1}"/>
                        </c:forEach>
                    </c:forEach>
                    <stripes:select id="selectedSchematrons" name="selectedSchematrons" multiple="true" size="${size}">
                        <c:forEach var="schGroup" items="${actionBean.schematrons}">
                            <optgroup label="<c:out value="${schGroup.left}"/>">
                                <c:forEach var="sch" items="${schGroup.right}">
                                    <c:set var="fullSchPath" value="${schGroup.left}/${sch}"/>
                                    <c:set var="schTitle"><%= ((nl.b3p.metadatachecker.stripes.CheckActionBean)pageContext.getRequest().getAttribute("actionBean")).schTitle((String)pageContext.getAttribute("fullSchPath")) %></c:set>
                                    <stripes:option value="${fullSchPath}"><c:out value="${sch}"/> <c:if test="${!empty schTitle}">(<c:out value="${schTitle}"/>)</c:if></stripes:option>
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
                        <p>
                            <label><stripes:radio name="outputType" value="schematron"/>Schematron XML uitvoer</label><br>
                            <label><stripes:radio name="outputType" value="report"/>Rapport, selecteer XSL stylesheet:</label><br>
                        <p>   XSL stylesheet:<br>
                    <c:set var="size" value="${0}"/>
                    <c:forEach var="xslGroup" items="${actionBean.stylesheets}">
                        <c:set var="size" value="${size+1}"/>
                        <c:forEach var="xsl" items="${xslGroup.right}">
                            <c:set var="size" value="${size+1}"/>
                        </c:forEach>
                    </c:forEach>
                    <stripes:select name="selectedStylesheet" size="${size}">
                        <c:forEach var="xslGroup" items="${actionBean.stylesheets}">
                            <optgroup label="<c:out value="${xslGroup.left}"/>">
                                <c:forEach var="xsl" items="${xslGroup.right}">
                                    <stripes:option value="${xslGroup.left}/${xsl}"><c:out value="${xsl}"/></stripes:option>
                                </c:forEach>
                            </optgroup>
                        </c:forEach>
                    </stripes:select>
                            <p>XSL stylesheet parameters (&eacute;&eacute;n parameter per regel, naam=waarde)</p>
                            <stripes:textarea name="reportParams" rows="2" cols="100"/>
                </fieldset>
                <p/>
                <stripes:submit name="check" value="Check"/>
            </stripes:form>
                
        <c:if test="${actionBean.outputType == 'schematron'}"><pre></c:if>
${actionBean.results}
        <c:if test="${actionBean.outputType == 'schematron'}"></pre></c:if>
        <p style="padding-bottom: 20px"/>
    </body>
</html>
