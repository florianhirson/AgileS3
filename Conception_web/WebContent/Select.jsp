<!DOCTYPE html>
<html>
<%@ page import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<title>Hendek</title>
</head>

	<body style="background-color:#f7f7f7;">
	
			<%if (session.getAttribute("login") == null)
			response.sendRedirect("Login.jsp");%>
	
       <header style="background-color:#3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
    <H1 style="color:white; font-size: 600%; font-weight:bold; margin-left:1%; display: inline-block;"><a style="color:white" href=./accueil.jsp>HENDEK</a></H1>
      </header>
	  
	<div style="margin-left: 3%; margin-right: 3%;">
	   		<%if(session.getAttribute("panier")==null){ %>
	    <a class="btn btn-default" href="./MonPanier.jsp" role="button" style="width: 18%; margin-right:1%; background-color:#dfe3ee">Mon Panier (Vide)</a>
		<%}else{%>
		<a class="btn btn-default" href="./MonPanier.jsp" role="button" style="width: 18%; margin-right:1%; background-color:#dfe3ee">Mon Panier (<%=(((Panier)session.getAttribute("panier")).getNbContent())%>)</a>
		<%}%>
		<a class="btn btn-default" href="./edit_account.jsp" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mon Compte</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Mes Commandes</a>
		<a class="btn btn-default" href="#" role="button" style="width: 18%; margin-left:1%; margin-right:1%; background-color:#dfe3ee">Promotions</a>
			<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button" style="width: 18%; margin-left:1%; background-color:#dfe3ee">Deconnexion</a>
		<%}%>
	</div>
	  
	<div style="background-color:#dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	
		<div style="background-color:#ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form action="./Select.jsp? method="GET">
  				<div class="form-group">
   					 <label for="Search">Rechercher :</label>
   					 <input style="width=80%" type="text" class="form-control" id="search" name="search" placeholder="ex : Cocktails au white spirit">
 				</div>
			</form>
		</div>
		
		
		<% Article articles = Article.getInstance(); %>
		<% for(Integer i: articles.getAllLibelle().keySet()){%>
		<% 		if(request.getParameter("search")==null || articles.getLibelle(i).contains(request.getParameter("search"))){ %>
			<div style="margin: 1%; border-radius: 10px;">
				<img src="<%=articles.getImage(i)%>" alt="<%=articles.getLibelle(i)%>" style="width:10%;height:10%;display: inline-block;">
				<div style="display: inline-block;">
				<h3 style="margin-bottom:1%"><a href=#><%=articles.getLibelle(i)%><small style="margin-left:5%;"><%=articles.getPrix(i)%>&euro;</small></a></h3>
				<p><%=articles.getDescription(i)%></p>
				</div>
				<a class="btn btn-default" href="./AjouterPanier.jsp?page=Select.jsp&id=<%=i%>" role="button" style="width: 10%;background-color:#dfe3ee; position: Absolute; right: 5%;">Ajouter au panier</a>
			</div>
		<% }} %>
		</div>
		
	</div>
  </body>