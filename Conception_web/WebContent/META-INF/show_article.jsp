<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, business.Bridge, business.Article, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>Articles</title>
</head>
<body>

		<%
			Article a = new Article("rateau", "Un rateau efficace", "http://lol.fr/lol.png", "jardinor", "jardin",
					12.99);
			Article b = new Article("Super Rateau", "Un rateau encore plus efficace", "http://lol.fr/lol.png",
					"jardinor", "jardin", 102.99);
			if (application.getAttribute("articles") == null) {
				application.setAttribute("articles", Bridge.getAllArticles());
			}
			Article[] articles = (Article[]) application.getAttribute("articles");
			if (articles!=null && articles.length > 0){
				%><table class="table table-hover">
				<tr>
					<th>Nom</th>
					<th>Description</th>
					<th>vendeur</th>
					<th>categorie</th>
					<th>prix</th>
				</tr><%
				for (Article art : articles) {%>
		<tr>
			<td><%=art.getName()%></td>
			<td><%=art.getDescription()%></td>
			<td><%=art.getBrand()%></td>
			<td><%=art.getCategory()%></td>
			<td><%=art.getPrice()%></td>
		</tr>
		<%
				}
			} else { %>
				<h3> ERREUR : <small> aucuns produits disponibles </small> </h3>
			<% }
		%>

	</table>
</body>
</html>