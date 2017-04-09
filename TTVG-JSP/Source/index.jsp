<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="includes/resources.jsp" %>

<html>
	<head>
		<link rel = "stylesheet" type = "text/css" href = "style.css">
		<script>
			function init_menu(item, status) {
				var div = document.getElementById(item);
				div.style.display = status;
			}	
			
			function close_menu(item) {
				var div = document.getElementById(item);
//				alert("" + div.style.display);
				if(div.style.display == "none") {
					div.style.display = "block";
				} else {
					div.style.display = "none";
				}
			}	
			
			function load_page(page) {
				document.getElementById("page-content").innerHTML='<object type="text/html" data="' + page + '"></object>';
			}
			
			function toggle_language() {
				var btnLanguage = document.getElementById("btnLanguage")

				if (btnLanguage.value == 'cn')
					btnLanguage.value = 'en';
				else
					btnLanguage.value = 'cn';
				
			}
		</script>
		<!-- Chinese character set -->
		<meta charset="utf-8">
	</head>
	<body onload='load_page("home.html")'>
		<div id = "header">
			<div id = "site-title">
				<h1>TTVG</h1>
				<p><%=p.getProperty("title")%></p>
			</div>
			<div id = "site-menu">
				<form action="index.jsp" method="POST">
					<button type="submit" id="btnLanguage" name="btnLanguage" value="<%=newLocaleStr%>" onclick='toggle_language()'><%=p.getProperty("button.language")%></button>
				</form>
			</div>
		</div>
		<div id="body-container">
			<div id = "sidebar">
				<ul>
<%
    String[] menuList = p.getProperty("menu.submenu").split("\\|");
	for (String menu : menuList){
		String menuName	= "menu." + menu;
		String menuUrl 	= p.getProperty(menuName + ".url");
%>
					<a href="">
<%
		if ( menuUrl != null && menuUrl.length() >= 0 ){
%>
					<li onclick='load_page("<%=menuUrl%>"); return false;' id="<%=menuName%>.li" class="parent-list link">
<%
		} else {
%>
					<li onclick='close_menu("<%=menuName%>.div"); return false;' id="<%=menuName%>.li" class="parent-list folder">
<%
		}
%>
					<%=p.getProperty(menuName + ".title")%></li></href>
		
<%
		String submenu 	= p.getProperty(menuName + ".submenu");
		if ( submenu != null && submenu.length() > 0 ){
%>
						<div id="<%=menuName%>.div">

<%
			String[] submenuList = submenu.split("\\|");
			for (String submenuItem : submenuList){
				String submenuName	= menuName + "." + submenuItem;
				String submenuUrl 	= p.getProperty(submenuName + ".url");
%>
						<a href="">
<%
				if ( submenuUrl != null && submenuUrl.length() > 0 ){
%>
							<li onclick='load_page("<%=submenuUrl%>"); return false;' class="child-list link">
<%
				} else {
%>
							<li onclick='close_menu("<%=submenuName%>.div"); return false;' class="child-list folder">
<%
				}
%>
							<%=p.getProperty(submenuName + ".title")%></li></href>
		
<%
				String subsubmenu 	= p.getProperty(submenuName + ".submenu");
				if ( subsubmenu != null && subsubmenu.length() > 0 ){
%>
							<div id="<%=submenuName%>.div">
		<script>
			init_menu("<%=submenuName%>.div", "none");
		</script>

<%
					String[] subsubmenuList = subsubmenu.split("\\|");
					for (String subsubmenuItem : subsubmenuList){
						String subsubmenuName	= submenuName + "." + subsubmenuItem;
						String subsubmenuUrl 	= p.getProperty(subsubmenuName + ".url");
%>
						<a href=""><li onclick='load_page("<%=subsubmenuUrl%>"); return false;' class="child-list indent-2 link"></href>
						<%=p.getProperty(subsubmenuName + ".title")%></li>
<%
					}
%>
							</div>
<%
				}
			}
%>
						</div>
<%
		}
	}
%>

				</ul>
			</div>
			<div id = "page-content">
			</div>
		</div>
		<div id="footer">
			<p>&#169;2017 • <%=p.getProperty("copyright")%></p>
		</div>
	</body>
</html>