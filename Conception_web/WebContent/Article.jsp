<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.*, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<title>Hendek</title>
</head>
<body style="background-color: #f7f7f7;">

	<header
		style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
		<H1
			style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
			<a style="color: white" href=./accueil.jsp>HENDEK</a>
		</H1>
	</header>
	<h2 class="text-center"><%="Bonjour "+session.getAttribute("login")%></h2>
	<div style="margin-left: 3%; margin-right: 3%;">
		<a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
			Commandes</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Promotions</a>
		<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Deconnexion</a>
		<%}%>
	</div>

	<div
		style="background-color: #dddddd; margin: 2%; border-radius: 10px; padding: 1%;">

		<div
			style="background-color: #ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form action="./Select.jsp? method="GET">
				<div class="form-group">
					<label for="Search">Rechercher :</label> <input style=""
						type="text" class="form-control" id="search" name="search"
						placeholder="ex : Cocktails au white spirit">
				</div>
			</form>
		</div>
		<div>
			<h1>
				<%
					if (request.getParameter("id") == null) {
						response.sendRedirect("accueil.jsp");
					} else {
						Integer id = Integer.valueOf(request.getParameter("id"));
						Article article = Article.getInstance();
				%>
				<%=article.getLibelle(id)%></h1>
				<h4>Ref : <%= id%></h4>

		</div>
		<div class="row">
			<div class="col-sm-4">


				<img class="img-responsive" src="<%=article.getImage(id)%>"
					alt="Image Article">


			</div>

			<div class="col-sm-4">
				<div>
					<h1>Prix : <%=article.getPrix(id)%>&euro;
					</h1>
				</div>
				<div>
					<h1>Quantit&eacute; : <%=article.getStock(id)%>
					</h1>
				</div>
			</div>
			<button type="button" class="btn btn-primary">Ajouter au panier</button>

		</div>
		<h3>Description du produit : <%=article.getDescription(id) %></h3>

	</div>
	<%} %>
	</div>
</body>