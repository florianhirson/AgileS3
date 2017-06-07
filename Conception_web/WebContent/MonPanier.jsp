<!DOCTYPE html>
<html>
<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<title>Hendek</title>
</head>

<body style="background-color: #f7f7f7;">

	<%if (session.getAttribute("login") == null){
			response.sendRedirect("Login.jsp");}%>

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>

	<div style="margin-left: 3%; margin-right: 3%;">
		<%if(session.getAttribute("panier")==null){ %>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (Vide)</a>
		<%}else{%>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier (<%=(((Panier)session.getAttribute("panier")).getNbContent())%>)
		</a>
		<%}%>
		<a class="btn btn-default" href="./edit_account.jsp" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mon Compte</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mes Commandes</a>
				
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Promotions</a>
			<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee; float: right;">Deconnexion</a>
		<%}%>
	</div>

	<div style="background-color:#dddddd; margin: 2%; border-radius: 10px; padding: 1%;">

<<<<<<< HEAD
	<% if(session.getAttribute("panier")!=null) {%>
		<table class="table table-striped">
			<%= session.getAttribute("panier").toString() %>
		</table>
	<% }else{ %>
		<%response.sendRedirect("./Login.jsp");%>
	<% }%>
=======
	<% if((Panier mypan = session.getAttribute("panier"))!=null) {%>
		<table class="table table-striped">
			<%= mypan.toString() %>

	<% }else{ %>
		<%response.sendRedirect("./Login.jsp"); %>
	<% } %>
	
	</div>
>>>>>>> 1e5a91e1f6f00eff0e3d2226c34994a63956f4f6
</body>