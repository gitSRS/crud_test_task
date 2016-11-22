<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add user page</title>
</head>

<body>

<a href="<c:url value='/' />" >To Home Page</a>

<h1>
	Add a User
</h1>

<c:url var="addUser" value="/user/adduser" ></c:url>
<form:form NAME="form1" action="${addUser}" commandName="user" onsubmit="alert('Use button!');return false">
<table id="table">
	
	<tr>
		<td>
			<form:label path="name">
				<spring:message text="Name"/>
			</form:label>
		</td>
		<td>
			<form:input path="name" />
		</td> 
	</tr>
	<tr>
		<td>
			<form:label path="age">
				<spring:message text="Age"/>
			</form:label>
		</td>
		<td>
			<form:input path="age" id="age" />
		</td>
	</tr>
	<tr>
		<td>
			<form:label path="admin">
				<spring:message text="IsAdmin"/>
			</form:label>
		</td>
		<td>
			<c:set var="admin" value="yes,no" scope="application" />
			<select name="admin" class="form-control">
                        <c:forEach items="${fn:split(admin, ',')}" var="admin">
                            <option value="${admin}">${admin}</option>
                        </c:forEach>
            </select>
		</td>
	</tr>
	<tr>
		<td>
			<INPUT TYPE="BUTTON" VALUE="Add" ONCLICK="editfunc()">
		</td>
	</tr>
</table>	
</form:form>

	<SCRIPT LANGUAGE="JavaScript">
            <!--
               function editfunc()
               {
               		var flg = 0;
               		//window.alert("start");
					var f_name = document.getElementById("name").value;
					var f_age = document.getElementById("age").value;
					var patt_age = /^\d+$/;
					var patt_name = /^([a-zа-яё0-9\.,]+)$/i;
										
					if(f_name != null && f_name != "" && patt_name.test(f_name)) {
						//window.alert("name OK");
						flg = flg + 1;
					} else {
						window.alert("Wrong data for field: name = "+f_name);
					}
					
					if(patt_age.test(f_age)) {
						//window.alert("age OK");
						flg = flg + 1;
					} else {
						window.alert("Wrong data for field: age = "+f_age);
					}
					
					if(flg == 2) {
						form1.submit();
					}
					
               } 
            // -->   
    </SCRIPT>

</body>
</html>