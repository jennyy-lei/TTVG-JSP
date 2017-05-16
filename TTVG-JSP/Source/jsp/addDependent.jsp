<%@page import="java.util.List" %>
<%@page import="org.hibernate.Session" %>
<%@page import="org.hibernate.Transaction" %>
<%@page import="com.ttvg.shared.engine.base.Constant" %>
<%@page import="com.ttvg.shared.engine.database.MyDatabaseFeactory" %>
<%@page import="com.ttvg.shared.engine.database.TableRecordOperation" %>
<%@page import="com.ttvg.shared.engine.database.table.Account" %>
<%@page import="com.ttvg.shared.engine.database.table.Person" %>

<!DOCTYPE html>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="../includes/resources.jsp" %>

<%
    Session dbSession = null;
	Transaction transaction = null;
	List<Object> childrenList = null;
	String personId = null;
	String firstName = null;
	String lastName = null;
	String chineseName = null;
	String phone = null;
	String mobile = null;
	String relation = null;
	
	Person user = null;
	Person child = null;
	
	boolean isSuccess = false;
	
    try{
		//Get current user
		Object obj = session.getAttribute("person");
		if ( obj != null && obj instanceof Person ){
			user = (Person)obj;
		}
		
		if ( user != null ) {
			// This step will read hibernate.cfg.xml and prepare hibernate for use
			dbSession = MyDatabaseFeactory.getSession();
			transaction = dbSession.beginTransaction();
			
			//Get Get data
			personId = request.getParameter("personId");
			if ( personId != null && firstName.length() > 0 ) {
			
				child = TableRecordOperation.getRecord(Integer.parseInt(personId), Person.class);
				if ( child != null )
					dbSession.delete(child);			
			
			} else {
				//Get Post data
				request.setCharacterEncoding("UTF-8");
				firstName = request.getParameter("firstName");
				lastName = request.getParameter("lastName");
				chineseName = request.getParameter("chineseName");
				phone = request.getParameter("phone");
				mobile = request.getParameter("mobile");
				relation = request.getParameter("relation");
				if ( chineseName != null && chineseName.length() > 0 )
					chineseName = new String(chineseName.getBytes("ISO8859_1"), "UTF-8");
				
				//Save the posted account item if not empty
				if ( (firstName != null && firstName.length() > 0) && (lastName != null && lastName.length() > 0) ) {
					transaction = dbSession.beginTransaction();
					child = new Person();
					child.setGivenName(firstName);
					child.setLastName(lastName);
					child.setChineseName(chineseName);
					child.setPhone(phone);
					child.setMobile(mobile);
					if ( Constant.PARAM_RELATION_MOTHER.equalsIgnoreCase(relation) )
						child.setMother(user);
					else if ( Constant.PARAM_RELATION_FATHER.equalsIgnoreCase(relation) )
						child.setFather(user);
					else if ( Constant.PARAM_RELATION_GUARDIAN.equalsIgnoreCase(relation) )
						child.setGuardian(user);
					
					dbSession.save(child);			
					
					isSuccess = true;
				}
			}
			transaction.commit();
        }
    }catch(Exception e){
		if ( transaction != null ) transaction.rollback();
		System.out.println(e.getMessage());
    }finally{
      // Close the session after work
    	if (dbSession != null) {
		    try{
				dbSession.flush();
				dbSession.close();
			}catch(Exception ex1){
			}				
    	}
	}
		
	if ( user != null ) {
		try{
			// This step will read hibernate.cfg.xml and prepare hibernate for use
			dbSession = MyDatabaseFeactory.getSession();
			
			//Search for current list of event items
			childrenList = TableRecordOperation.findAllRecord("from Person where mother='" + user.getId() + "' Or father='" + user.getId() + "' Or guardian='" + user.getId() + "' order by givenName");
			
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
		  // Close the session after work
			if (dbSession != null) {
				dbSession.flush();
				dbSession.close();
			}
		}
	}
%>

<html>
	<body>
<%
	//Display the current event list
	if ( childrenList != null ){
%>
		<div id = "html-content">
			<div class="forum-item-container">
				<table border="1">
					<tr>
						<th><%=p.getProperty("addDependent.gn")%></th>
						<th><%=p.getProperty("addDependent.sn")%></th>
						<th><%=p.getProperty("addDependent.cn")%></th>
						<th><%=p.getProperty("addDependent.relation")%></th>
						<th><%=p.getProperty("addDependent.button.remove")%></th>
					</tr>
<%
		for ( Object obj : childrenList ){
			Person item = ((Person)obj);
%>
					<tr>
						<td><%=item.getGivenName()%></td>
						<td><%=item.getLastName()%></td>
						<td><%=item.getChineseName()%></td>
						<td>
<%
			if ( item.getMother() != null ){
%>
							<%=p.getProperty("addDependent.relation.mother.text")%>
<%
			} else if ( item.getFather() != null ){
%>
							<%=p.getProperty("addDependent.relation.father.text")%>
<%
			} else{
%>
							<%=p.getProperty("addDependent.relation.guardian.text")%>
<%
			}
%>
						</td>
						<td>
							<a href="addDependent.jsp?personId=<%=item.getId()%>"><%=p.getProperty("addDependent.button.remove")%></a>
						</td>
					</tr>
<%
		}
%>
				</table>
			</div>
		</div>
		<hr/>
<%
	} else {
%>
<%=p.getProperty("search.noresult")%>
<%
	}
%>
<%
	if ( user == null ) {
%>
		<%=p.getProperty("login.not")%>
<%
	} else if ( child == null ) {
%>
		<div id = "page-form">
			<h1><%=p.getProperty("addDependent.title")%></h1>
			<fieldset>
				<form action="addDependent.jsp" method="POST">
					<table style="width:100%">
						<tr><td align="right"><%=p.getProperty("addDependent.sn")%><font color="red">*</font>:</td><td><input type="text" name="firstName" required></td></tr>
						<tr><td align="right"><%=p.getProperty("addDependent.gn")%><font color="red">*</font>:</td><td><input type="text" name="lastName" required></td></tr>
						<tr><td align="right"><%=p.getProperty("addDependent.cn")%>:</td><td><input type="text" name="chineseName"></td></tr>
						<tr><td align="right"><%=p.getProperty("addDependent.tel")%>:</td><td><input type="text" name="phone"></td></tr>
						<tr><td align="right"><%=p.getProperty("addDependent.mobile")%>:</td><td><input type="text" name="mobile"></td></tr>
						<tr><td align="right"><%=p.getProperty("addDependent.relation")%><font color="red">*</font>:</td>
							<td>
								<select id="mySelect" name="relation" value="<%=p.getProperty("addDependent.relation.mother.value")%>">
									<option value="<%=p.getProperty("addDependent.relation.mother.value")%>"><%=p.getProperty("addDependent.relation.mother.text")%></option>
									<option value="<%=p.getProperty("addDependent.relation.father.value")%>"><%=p.getProperty("addDependent.relation.father.text")%></option>
									<option value="<%=p.getProperty("addDependent.relation.guardian.value")%>"><%=p.getProperty("addDependent.relation.guardian.text")%></option>
								</select>
							</td>
						</tr>
						<tr><td colspan="2" align="center"><input type="submit" value="<%=p.getProperty("addDependent.button.submit")%>"></td></tr>
					</table> 
				</form>
			</fieldset>
		</div>
<%
	} else{
%>
		<%=isSuccess ? p.getProperty("addDependent.success") : p.getProperty("addDependent.fail")%>
<%
	}
%>
	</body>
</html>