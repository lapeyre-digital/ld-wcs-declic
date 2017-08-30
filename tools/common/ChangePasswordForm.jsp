<%--
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation.
 *     2016
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *
 *-------------------------------------------------------------------
 */
--%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="javax.servlet.*" %>
<%@page import="com.ibm.commerce.command.*" %>
<%@page import="com.ibm.commerce.server.*" %>
<%@page import="com.ibm.commerce.beans.*" %>
<%@page import="com.ibm.commerce.user.beans.*" %>
<%@page import="com.ibm.commerce.user.objects.*" %>
<%@page import="com.ibm.commerce.datatype.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@include file="common.jsp" %>
<%
try {
	// Get the resource bundle with all the NLS strings
	CommandContext cmdContextLocale = (CommandContext)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_COMMANDCONTEXT);
	Locale locale = cmdContextLocale.getLocale();
	Hashtable resourceBundle = (Hashtable)ResourceDirectory.lookup("common.logonNLS", locale);

	JSPHelper jspHelper = new JSPHelper(request);
	String errorType = jspHelper.getParameter("ErrorType");
	String title = "";
	String errorMsg = "";
	String redirecturl = "";

	if (title == "") {
		title = (String)resourceBundle.get("expiredmessageStorePreviewTitle");
	}

	if (errorMsg == "") {
		errorMsg = (String)resourceBundle.get("expiredmessageStorePreview");
	}

	errorType = (errorType != null)?(errorType):("");
	redirecturl = (redirecturl != null)?(redirecturl):("");
%>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title><%= title %></title>
	<link rel="stylesheet" type="text/css" href="<%= UIUtil.getCSSFile(locale) %>" />
	<script src="/wcs/javascript/tools/common/Util.js"></script>
	<script>
		var errorType = "<%= errorType %>";
		var redirecturl = "<%= redirecturl %>";

	</script>
</head>
<body class="button">
<script>

	if (top.mccmain) {
		alertDialog('<%= UIUtil.toJavaScript(errorMsg) %>');

		if (errorType == "LogOff") {
			top.logout_page = '';
			top.close();
		}
		else {
			if (redirecturl != "") {
				document.location = redirecturl;
			}
			else {
				if (top.goBack) {
					top.goBack();
				}
				else {
					window.history.back();
				}
			}
		}
	}
	else {
		document.writeln('<div align="center">');
		document.writeln('<b><%= UIUtil.toJavaScript(title) %></b><br/>');
		document.writeln('<i><%= UIUtil.toJavaScript(errorMsg) %></i>');
		document.writeln('</div>');
	}
</script>
<%
}
catch (Exception e) {
	out.println("<hr/>");
	out.println("<b>Stack Trace:</b><br/>");
	out.println("<pre>");
	e.printStackTrace();
	out.println("</pre>");
}
%>
</body>
</html>
