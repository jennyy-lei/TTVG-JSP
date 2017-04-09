<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="includes/resources.jsp" %>

<html>
	<head>
		<link rel = "stylesheet" type = "text/css" href = "style.css">
		<script>
			var display = true

			function close_menu(item) {
				alert("");
				var div = document.getElementById('div1');
				if(display) {
					div.style.display = "none";
					display = false;
				} else {
					div.style.display = "block";
					display = true;
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
			<form>
				<button type="submit" id="btnLanguage" name="btnLanguage" value="<%=newLocaleStr%>" onclick='toggle_language()'><%=p.getProperty("button.language")%></button>
			</form>
		</div>
		<div id="body-container">
			<div id = "sidebar">
				<ul>
					<li onclick='load_page("home.html"); return false;'><%=p.getProperty("home")%></li>
					<li onclick="close_menu(this); return false;" class="parent-list">中文学校</li>
						<div id="div1">

							<a href=""><li class="child-list">教学</li></a>
<%
    String[] childList = new String[]{"千字比赛", "小学", "初中", "高中"};
	for (String child : childList){
%>
								<a href=""><li class="child-list indent-2"><%=child%></li></a>
<%
}
%>
							<a href=""><li class="child-list">兴趣课</li></a>
								<a href=""><li class="child-list indent-2">画画</li></a>
								<a href=""><li class="child-list indent-2">羽毛球</li></a>
								<a href=""><li class="child-list indent-2">篮球</li></a>
								<a href=""><li class="child-list indent-2">排球</li></a>
								<a href=""><li class="child-list indent-2">跳舞</li></a>
								<a href=""><li class="child-list indent-2">桥牌</li></a>
								<a href=""><li class="child-list indent-2">机器人</li></a>
						</div>
					<a href=""><li class="">成人</li></a>
						<a href=""><li class="child-list">羽毛球</li></a>
						<a href=""><li class="child-list">篮球</li></a>
						<a href=""><li class="child-list">排球</li></a>
						<a href=""><li class="child-list">跳舞</li></a>

				</ul>
			</div>
			<div id = "page-content">
			</div>
		</div>
		<div id="footer">
			<p>&#169;2017 • Created by Jenny Lei</p>
		</div>
	</body>
</html>