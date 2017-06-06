<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="business.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>Articles</title>
</head>
<body>

<table class="table table-hover">
<tr>
<th>Nom</th><th>Description</th><th>vendeur</th><th>categorie</th><th>prix</th>
</tr>

<%
	Article a = new Article("rateau", "Un rateau efficace", "http://lol.fr/lol.png", "jardinor", "jardin", 12.99);
	Article b = new Article("Super Rateau", "Un rateau encore plus efficace", "http://lol.fr/lol.png", "jardinor", "jardin", 102.99);
%>
<tr>
<td><%= a.getName() %></td><td><%= a.getDescription() %></td><td><%= a.getBrand() %></td><td><%= a.getCategory() %></td><td><%= a.getPrice() %></td>
</tr>

<tr>
<td><%= b.getName() %></td><td><%= b.getDescription() %></td><td><%= b.getBrand() %></td><td><%= b.getCategory() %></td><td><%= b.getPrice() %></td>
</tr>

</table>
</body>
</html>