<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home page</title>
</head>
<body>

<h1>Menu</h1>

<p>You have received a user page at <%= new java.util.Date() %></p>
<P>${message}</P>
<br>
<form action="${pageContext.request.contextPath}/user/adduserpage" method="get">
<input type="submit" value="<spring:message text="Add User"/>" />
</form>
<br>
<form action="${pageContext.request.contextPath}/user/page" method="get">
<input type="submit" value="<spring:message text="All Users"/>" />
</form>
</body>
</html>