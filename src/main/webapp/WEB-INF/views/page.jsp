<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Users page</title>
	<style type="text/css">
		.tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
		.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
		.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
		.tg .tg-4eph{background-color:#f9f9f9}
	</style>
</head>
<body>

<a href="<c:url value='/' />" >To Home Page</a>

<h1>
	Users Page
</h1>

<c:url var="userAction" value="/user/action" ></c:url>
<form:form NAME="form2" action="${userAction}" commandName="user" onsubmit="alert('Use button!');return false">
<table>
	<tr>
		<td>
			<form:label path="id">
				<spring:message text="ID"/>
			</form:label>
		</td>
		<td>
			<form:input path="id" readonly="true" size="8"  disabled="true" />
			<form:hidden path="id" />
		</td>
	</tr>
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
			<c:choose>
				<c:when test="${!empty user.name}">
	            	<form:input path="age" />
            	</c:when>
            	<c:otherwise>
                	<form:input path="age" disabled="true" />
            	</c:otherwise>
         	</c:choose>   
		</td>
	</tr>
	<tr>
		<td>
			<form:label path="admin">
				<spring:message text="IsAdmin"/>
			</form:label>
		</td>
		<td>
		  <c:choose>
		   <c:when test="${!empty user.name}">
			<c:set var="admin" value="yes,no" scope="application" />
			<select name="admin" class="form-control">
                        <c:forEach items="${fn:split(admin, ',')}" var="admin">
                            <option value="${admin}">${admin}</option>
                        </c:forEach>
            </select>
            </c:when>
            	<c:otherwise>
            		<form:input path="admin" disabled="true" />
            	</c:otherwise>
			</c:choose>
			
		</td>
	</tr>
	<tr>
		<td>
			<form:label path="createdDate">
				<spring:message text="Created Date"/>
			</form:label>
		</td>
		<td>
			<form:input path="createdDate" readonly="true" disabled="true" />
			<form:hidden path="createdDate" />
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<c:if test="${!empty user.name}">
				<INPUT TYPE="BUTTON" VALUE="Edit" ONCLICK="editfunc2()">
			</c:if>
			<c:if test="${empty user.name}">
				<INPUT TYPE="BUTTON" VALUE="Find" ONCLICK="findfunc()">
			</c:if>
			<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK=" location.href='${pageContext.request.contextPath}/user/page'  " >
		</td>
	</tr>
</table>	
</form:form>

<h3>Users List</h3>
	
<c:if test="${!empty listUsers}">
	<table class="tg">
	<tr>
		<th width="80">User ID</th>
		<th width="100">User Name</th>
		<th width="10">User Age</th>
		<th width="10">Is User Admin</th>
		<th width="100">Created Date</th>
		<th width="60">Edit</th>
		<th width="60">Delete</th>
	</tr>

<div id="pagination">
    <c:url value="/user/page" var="prev">
        <c:param name="page" value="${page-1}"/>
    </c:url>
    <c:if test="${page > 1}">
        <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
    </c:if>

    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
        <c:choose>
            <c:when test="${page == i.index}">
                <span>${i.index}</span>
            </c:when>
            <c:otherwise>
                <c:url value="/user/page" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href='<c:out value="${url}" />'>${i.index}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:url value="/user/page" var="next">
        <c:param name="page" value="${page + 1}"/>
    </c:url>
    <c:if test="${page + 1 <= maxPages}">
        <a href='<c:out value="${next}" />' class="pn next">Next</a>
    </c:if>
</div>
	<c:forEach items="${listUsers}" var="user">
		<tr>
			<td>${user.id}</td>
			<td>${user.name}</td>
			<td>${user.age}</td>
			<td>${user.admin}</td>
			<td>${user.createdDate}</td>
			<td><a href="<c:url value='/edit/${user.id}' />" >Edit</a></td>
			<td><a href="<c:url value='/remove/${user.id}' />" >Delete</a></td>
		</tr>
	</c:forEach>
	</table>
</c:if>

<SCRIPT LANGUAGE="JavaScript">
            <!--
               function editfunc2()
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
						form2.submit();
					}
					
               } 
            // -->   
    </SCRIPT>
    <SCRIPT LANGUAGE="JavaScript">
            <!--
               function findfunc()
               {
               		var f_name = document.getElementById("name").value;
					var patt_name = /^([a-zа-яё0-9\.,]+)$/i;
										
					if(f_name != null && f_name != "" && patt_name.test(f_name)) {
						//window.alert("name OK");
						form2.submit();
					} else {
						window.alert("Wrong data for field: name = "+f_name);
					}

               } 
            // -->   
    </SCRIPT>
</body>
</html>