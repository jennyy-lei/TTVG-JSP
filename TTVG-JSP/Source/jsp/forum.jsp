<%@page import="com.ttvg.forum.ForumCollection" %>
<%@page import="com.ttvg.forum.ForumItem" %>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="../includes/resources.jsp" %>

<%
	ForumCollection items = new ForumCollection();
	ForumItem item1 = new ForumItem();
	item1.setUser("User Name One");
	item1.setPhoto("folder_home.png");
	item1.setTitle("Forum Title One");
	item1.setTime("04/17/2017 06:58:16");
	item1.setContent("Content One: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a dui faucibus, feugiat quam vel, interdum tortor Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a dui faucibus, feugiat quam vel, interdum tortor.");
	items.addChild(item1);
	ForumItem item2 = new ForumItem();
	item2.setUser("User Name Two");
	item2.setPhoto("www.png");
	item2.setTitle("Forum Title Two");
	item2.setTime("04/17/2017 06:58:16");
	item2.setContent(p.getProperty("title") + " Content Two: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a dui faucibus, feugiat quam vel, interdum tortor.");
	items.addChild(item2);
%>

<html>
	<body>
		<link rel = "stylesheet" type = "text/css" href = "../html/forum.css">
		<div id = "page-content">
			<div style="border-bottom: solid 1px lightgrey;">
				<div style="float:right; margin-right: 100px;">
					<span class="page-index">1</span>
					<span class="page-index">2</span>
					<span class="page-index">3</span>
				</div>
				<button type="button" id="btn-new-forum">Forum Title</button>
			</div>
<%
	for (ForumItem item : items.getChildren()){
%>
			<div class="forum-item-container">
				<div class="title">
					<img src="../images/<%=item.getPhoto()%>" class="user-photo">
					<span><a href=""><%=item.getTitle()%></a>&nbsp;&nbsp;<small>(<%=item.getContent().length()%> <%=p.getProperty("forum.bytes")%>)&nbsp;&nbsp;<em>--<%=item.getUser()%>--</em>&nbsp;&nbsp;<%=item.getTime()%></small></span>
				</div>
				<div class="forum-text">
					<p><%=item.getContent()%> 
					</p>
					<p class="comment-count"><a href=""><%=item.getChildren().size()%> <%=p.getProperty("forum.comments")%></a></p>
				</div>
			</div>
<%
	}
%>
		</div>
	</body>
</html>