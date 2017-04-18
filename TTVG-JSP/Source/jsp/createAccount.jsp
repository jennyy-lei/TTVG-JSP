<!DOCTYPE html>

<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="../includes/resources.jsp" %>

<html>
	<body>
		<div id = "html-content">
			<h1><%=p.getProperty("createAccount.title")%></h1>
			<fieldset>
				<form>
					<table style="width:100%">
						<tr><td align="right"><%=p.getProperty("createAccount.sn")%>:</td><td><input type="text" name="firstName"></td></tr>
						<tr><td align="right"><%=p.getProperty("createAccount.gn")%>:</td><td><input type="text" name="lastName"></td></tr>
						<tr><td align="right"><%=p.getProperty("createAccount.tel")%>:</td><td><input type="telephone" name="phoneNumber"></td></tr>
						<tr><td align="right"><%=p.getProperty("createAccount.email")%>:</td><td><input type="email" name="email"></td></tr>
						<tr><td align="right"><%=p.getProperty("createAccount.pwd")%>:</td><td><input type="password" name="password"></td></tr>
						<tr><td align="right"><%=p.getProperty("createAccount.pwd2")%>:</td><td><input type="password" name="confirmPassword"></td></tr>
						<tr><td colspan="2" align="center"><input type="submit" value="<%=p.getProperty("createAccount.button.submit")%>"></td></tr>
					</table> 
				</form>
			</fieldset>
		</div>
	</body>
</html>