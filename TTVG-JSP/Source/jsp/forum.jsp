<%@page import="java.util.Date" %>
<%@page import="java.util.List" %>
<%@page import="org.hibernate.Session" %>
<%@page import="org.hibernate.Transaction" %>
<%@page import="com.ttvg.shared.engine.database.MyDatabaseFeactory" %>
<%@page import="com.ttvg.shared.engine.database.TableRecordOperation" %>
<%@page import="com.ttvg.shared.engine.database.table.Forum" %>
<%@page import="com.ttvg.shared.engine.database.table.Person" %>

<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="../includes/resources.jsp" %>

<%
    Session dbSession = null;
	List<Object> forumList = null;
	Person user = null;
	String forumId = null;
	Forum forum = null;
	
    try{
		//Get current user
		Object obj = session.getAttribute("person");
		if ( obj != null && obj instanceof Person ){
			user = (Person)obj;
		}
		
		// This step will read hibernate.cfg.xml and prepare hibernate for use
    	dbSession = MyDatabaseFeactory.getSession();
        
		//Get Post data
		forumId = request.getParameter("forumId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		if ( forumId != null && forumId.length() > 0 ) {
			forum = TableRecordOperation.getRecord(Integer.parseInt(forumId), Forum.class);
		}
		
		if ( (title != null && title.length() > 0) || (content != null && content.length() > 0) ) {
			Transaction transaction = dbSession.beginTransaction();
			Forum item = new Forum();
			if ( user != null )
				item.setPerson(user);
			if ( forum != null )
				item.setForum(forum);
			item.setDateTime(new Date());
			item.setTitle(title);
			item.setContent(content);
			dbSession.save(item);
			transaction.commit();
		}
        
    }catch(Exception e){
		System.out.println(e.getMessage());
    }finally{
      // Close the session after work
    	if (dbSession != null) {
    		dbSession.flush();
    		dbSession.close();
    	}
	}
		
    try{
		// This step will read hibernate.cfg.xml and prepare hibernate for use
    	dbSession = MyDatabaseFeactory.getSession();
		
		//Search for current list of items
		String condition = forumId != null && forumId.length() > 0 ? "= '" + forumId + "'" : "is null";
        forumList = TableRecordOperation.findAllRecord("from Forum where ForumId " + condition + " order by DateTime desc");
        
    }catch(Exception e){
		System.out.println(e.getMessage());
    }finally{
      // Close the session after work
    	if (dbSession != null) {
    		dbSession.flush();
    		dbSession.close();
    	}
	}
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
	if ( forumList != null ){
		for ( Object obj : forumList ){
			Forum item = ((Forum)obj);
			Person person = item.getPerson();
%>
			<div class="forum-item-container">
				<div class="title">
					<img src="../images/<%=person.getImage()%>" class="user-photo">
					<span><a href="forum.jsp?forumId=<%=item.getId()%>&btnLanguage=<%=newLocaleStr%>"><%=item.getTitle()%></a>&nbsp;&nbsp;<small>(<%=item.getContent().length()%> <%=p.getProperty("forum.bytes")%>)&nbsp;&nbsp;<em>--<%=person.getLastName()%>, <%=person.getGivenName()%>--</em>&nbsp;&nbsp;<%=item.getDateTime()%></small></span>
				</div>
				<div class="forum-text">
					<p><%=item.getContent()%> 
					</p>
					<p class="comment-count"><a href=""><%=item.getFollowingForums().size()%> <%=p.getProperty("forum.comments")%></a></p>
				</div>
			</div>
<%
		}
	} else {
%>
<%=p.getProperty("search.noresult")%>
<%
	}
%>
		</div>
<%
	if ( user != null ){
%>
		<hr/>
		<div id = "page-form">
			<fieldset>
				<form action="forum.jsp" method="POST">
<%
		if ( forumId != null && forumId.length() > 0 ) {
%>
					<input type="hidden" name="forumId" value="<%=forumId%>">
<%
		}
%>
					<input type="hidden" name="btnLanguage" value="<%=newLocaleStr%>">
					<table style="width:100%">
						<tr><td align="right"><%=p.getProperty("forum.title")%>:</td><td><input type="text" name="title"></td></tr>
						<tr><td align="right"><%=p.getProperty("forum.content")%>:</td><td><textarea cols="60" rows="5" name="content"></textarea></td></tr>
						<tr><td colspan="2" align="center"><input type="submit" value="<%=p.getProperty("forum.followup")%>"></td></tr>
					</table> 
				</form>
			</fieldset>
		</div>
<%
	}
%>
	</body>
</html>