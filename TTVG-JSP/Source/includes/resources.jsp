<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.File" %>
<%@page import="java.util.Properties" %>
<%=getServletContext().getRealPath("/resources_cn.properties")%>

<%
	String localeStr = "cn";

	Cookie[] cookies = request.getCookies();

	for(Cookie c : cookies) { 
		if (c.getName().equals("locale")) {
			localeStr = c.getValue();
			break;
		}
	}  

	localeStr = localeStr.equalsIgnoreCase("cn") ? "en" : "cn";
	
	// Create cookies for locale.      
	Cookie locale = new Cookie("locale", localeStr);

	// Set expiry date after 24 Hrs for the cookies.
	locale.setMaxAge(60*60*24); 
   
	// Add the cookie in the response header.
	response.addCookie( locale );
%>

<%

	String propFile = "/resources_" + localeStr + ".properties";
	//Load property file
	FileInputStream fis = new FileInputStream(new File(getServletContext().getRealPath("/resources.properties")));

	Properties p = new Properties();
	p.load(fis);

//    InputStream stream = application.getResourceAsStream(new File("/resources.properties"));
//    Properties props = new Properties();
//    props.load(stream);
%>
<br/>
<%=p.getProperty("something")%>
<br/>
<%=propFile%>