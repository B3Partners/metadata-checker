<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@taglib prefix="stripes-dynattr" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%@page import="java.net.URL"%>
<c:set var="absoluteURIPrefix"><%

boolean needPort = "http".equals(request.getScheme()) && request.getServerPort() != 80
                || "https".equals(request.getScheme()) && request.getServerPort() != 443;

URL u;
if(needPort) {
    u = new URL(request.getScheme(), request.getServerName(), request.getServerPort(), "");
} else {
    u = new URL(request.getScheme(), request.getServerName(), "");
}

out.print(u.toString());
%></c:set>

