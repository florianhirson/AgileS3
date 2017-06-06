<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="business.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Articles</title>
</head>
<body>
<%
	Article a = new Article("rateau", "Un rateau efficace", "http://lol.fr/lol.png", "jardinor", "jardin", 12.99);
%>

<%= a %>

</body>
</html>