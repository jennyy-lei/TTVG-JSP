<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.File" %>
<%@page import="java.io.InputStreamReader" %>
<%@page import="java.util.Properties" %>
<%--=getServletContext().getRealPath("/includes/resources_cn.properties")--%>

<%
	String localeStr = "cn";

	Cookie[] cookies = request.getCookies();

	for(Cookie c : cookies) { 
		if (c.getName().equals("locale")) {
			if ( "cn".equalsIgnoreCase(c.getValue()) || "en".equalsIgnoreCase(c.getValue()))
				localeStr = c.getValue();
			break;
		}
	}  

	String newLocaleStr = localeStr;
    if(request.getParameter("btnLanguage")!=null)
	{
		newLocaleStr = request.getParameter("btnLanguage");
	}
	
	// Create cookies for locale.      
	Cookie locale = new Cookie("locale", newLocaleStr);

	// Set expiry date after 24 Hrs for the cookies.
	locale.setMaxAge(60*60*24); 
   
	// Add the cookie in the response header.
	response.addCookie( locale );
%>

<%

	String propFile = "/includes/resources_" + newLocaleStr + ".properties";
	//Load property file
	FileInputStream fis = new FileInputStream(new File(getServletContext().getRealPath(propFile)));
	InputStreamReader isr = new InputStreamReader(fis, "UTF-8");

	Properties p = new Properties();
	p.load(fis);

%>
<br/>
<%=localeStr%>/<%=p.getProperty("title")%>/<%=request.getParameter("btnLanguage")%>
<br/>
<%--=propFile--%>