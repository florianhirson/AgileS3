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


<header
	style="background-color: #3b5998; margin-top: 2%; margin-bottom: 2%; padding: 1%;">
	<H1
		style="color: white; font-size: 600%; font-weight: bold; margin-left: 1%; display: inline-block;">
		<a style="color: white" href=./accueil.jsp>HENDEK</a>
	</H1>
</header>

<style>
/* make sidebar nav vertical */ 
@media (min-width: 768px){
  .affix-content .container {
    width: 700px;
  }   

  html,body{
    background-color: #f8f8f8;
    height: 100%;
    overflow: hidden;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }
  .sidebar-nav{
        position:fixed; 
        width:100%;
  }
  .affix-sidebar{
    padding-right:0; 
    font-size:small;
    padding-left: 0;
  }  
  .affix-row, .affix-container, .affix-content{
  	
    height: 100%;
    margin-left: 0;
    margin-right: 0;    
  } 
  .affix-content{
    background-color:white; 
  } 
  .sidebar-nav .navbar .navbar-collapse {
    padding: 0;
    max-height: none;
  }
  .sidebar-nav .navbar{
    border-radius:0; 
    margin-bottom:0; 
    border:0;
  }
  .sidebar-nav .navbar ul {
    float: none;
    display: block;
  }
  .sidebar-nav .navbar li {
    float: none;
    display: block;
  }
  .sidebar-nav .navbar li a {
    padding-top: 12px;
    padding-bottom: 12px;
  }  
}

@media (min-width: 769px){
  .affix-content .container {
    width: 600px;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }  
}

@media (min-width: 992px){
  .affix-content .container {
  width: 900px;
  }
    .affix-content .container .page-header{
    margin-top: 0;
  }
}

@media (min-width: 1220px){
  .affix-row{
    overflow: hidden;
  }

  .affix-content{
    overflow: auto;
  }

  .affix-content .container {
    width: 1000px;
  }

  .affix-content .container .page-header{
    margin-top: 0;
  }
  .affix-content{
    padding-right: 30px;
    padding-left: 30px;
  }  
  .affix-title{
    border-bottom: 1px solid #ecf0f1; 
    padding-bottom:10px;
  }
  .navbar-nav {
    margin: 0;
  }
  
  .navbar-collapse{
    padding: 0;
  }
  .sidebar-nav .navbar li a:hover {
    background-color: #428bca;
    color: white;
  }
  .sidebar-nav .navbar li a > .caret {
    margin-top: 8px;
  }  
}
</style>

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
	<a class="btn btn-default" href="./edit_account.jsp" role="button"
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

<div class="row affix-row" style="margin-top: 50px; margin-left: 3%;">
    <div class="col-sm-3 col-md-2 affix-sidebar">
		<div class="sidebar-nav">
  <div class="navbar navbar-default" role="navigation">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-navbar-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      </button>
      <span class="visible-xs navbar-brand">Sidebar menu</span>
    </div>
    <div class="navbar-collapse collapse sidebar-navbar-collapse" >
      <ul class="nav navbar-nav" id="sidenav01" style="">
        <li class="active">
          <a style="background-color: #dfe3ee;" data-toggle="collapse" data-target="#toggleDemo0" data-parent="#sidenav01" class="collapsed">
          <h4>Panneau de contrôle</h4>
          </a>
        </li>
        <li><a href="javascript:" onclick="changeCat(0)"><span class="glyphicon glyphicon-lock"></span> Utilisateur</a></li>
        <li><a href="javascript:" onclick="changeCat(1)"><span class="glyphicon glyphicon-cog"></span> Article</a></li>
        <li><a href="javascript:" onclick="changeCat(2)"><span class="glyphicon glyphicon-calendar"></span> Tickets<span style="margin-left: 10px;" class="badge">42</span></a></li>
      </ul>
      </div><!--/.nav-collapse -->
    </div>
	</div>
		</div>
	<div class="col-sm-9 col-md-10 affix-content">
		<div class="container">
			
				<div class="page-header">
	<h3 id="Titre"><span class="glyphicon glyphicon-th-list"></span> 
	<%
		int user = (request.getParameter("idUser") != null ? Integer.parseInt(request.getParameter("idUser")) : -1);
		int article = (request.getParameter("idArticle") != null ? Integer.parseInt(request.getParameter("idArticle")) : -1);
	%>Bienvenu sur le panneau de controle d'administrateur !</h3>
	</div>
	<div class="cat-content" style="display: none;" title="Utilisateur">
	
	<label for="user">ID utilisateur : </label>
	<input type="text" id="user"/>
	<input type="submit" value="Go"/>
	
	</div>
	<div class="cat-content" style="display:none;" title="Article">
	
	<label for="article">ID article : </label>
	<input type="text" id="article"/>
	<input type="submit" value="Go"/>
	
	</div>
	<div class="cat-content" style="display:none;" title="Ticket">
	
	Ticket !
	
	</div>
	</div>
	</div>
</div>

<script>
	var cat = document.getElementsByClassName("cat-content");
	var title = document.getElementById("Titre");
	var actual = 0;
	function changeCat(categorie){
		console.log(cat);
		cat[actual].style.display="none";
		cat[categorie].style.display="block";
		title.innerHTML = "<span class=\"glyphicon glyphicon-th-list\"></span> "+cat[categorie].getAttribute("title");
		actual = categorie;
	}
</script>

</body>
</html>