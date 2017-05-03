<%@page import="java.util.List" %>
<%@page import="org.hibernate.Session" %>
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

    try{
      // This step will read hibernate.cfg.xml and prepare hibernate for use
    	dbSession = MyDatabaseFeactory.getSession();
        
        forumList = TableRecordOperation.findAllRecord("from Forum where ForumId is null order by DateTime desc");
        
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
					<span><a href=""><%=item.getTitle()%></a>&nbsp;&nbsp;<small>(<%=item.getContent().length()%> <%=p.getProperty("forum.bytes")%>)&nbsp;&nbsp;<em>--<%=person.getLastName()%>, <%=person.getGivenName()%>--</em>&nbsp;&nbsp;<%=item.getDateTime()%></small></span>
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
Nothing found
<%
	}
%>
		</div>
	</body>
</html>