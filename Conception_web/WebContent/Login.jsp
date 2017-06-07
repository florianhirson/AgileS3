<%@ page pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<!DOCTYPE html>


<html lang="fr">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css' rel='stylesheet'>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>Page de login</title>

	<!-- Bootstrap core CSS -->
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	
	</head>
	<body>
		<div class="container">
			<div class="page-header">
		    	<h1 style ="text-align: center;">Connexion à notre site de commerce en ligne HENDEK</h1>
		    </div>
	    	<div class="row">
	        	<div class="col-xs-6 col-xs-offset-3">
					<form id="loginForm" method="POST" action="">
						<div class="form-group">
							<label for="login" class="control-label">Mail</label>
							<input type="text" class="form-control" id="login" name="login" value="">
						</div>
						<div class="form-group">
							<label for="password" class="control-label">Mot de passe</label>
							<input type="password" class="form-control" id="password" name="mdp" value="">
						</div>

						<button type="submit" class="btn btn-success btn-block">Envoyer</button>
						<%
						/* Class.forName("org.postgresql.Driver");
						Connection con = DriverManager.getConnection("jdbc:postgresql://217.182.171.28:5432/hendek","hendek", "hendek");
						Statement stmt= con.createStatement(); */
						
						Connection con=null;
						
						    
						    // enregistrement du driver
						    Class.forName("org.postgresql.Driver");
						    
						    // connexion a la base
						    con = DriverManager.getConnection("jdbc:postgresql://217.182.171.28:5432/hendek","hendek","hendek");
						    String login = request.getParameter("login");
						    // execution de la requete
							PreparedStatement ps = con.prepareStatement("select * from users where login=? and mdp=?");
							ps.setString(1, request.getParameter("login"));
							ps.setString(2, request.getParameter("mdp"));
						    ResultSet rs = ps.executeQuery();
						    
						    if(rs.next()) {
								 session = request.getSession(true);
								// les autres pages devront tester la presence de login pour savoir si on a bien ete authentifie
								
								session.setAttribute("login", login);
								con.close();
								response.sendRedirect("show_articles.jsp");
						    } else { 
						    	out.println("<div class='container'>");
							    	out.println("<div class='page-header'>");
										out.println("<h1>Authentification</h1>");
									out.println("</div>");
							    	
									out.println("<div class='row'>");
										out.println("<div class='col-xs-12'>");
											out.println("<div class='alert alert-danger' role='alert'>Login ou mot de passe incorrect.</div>");
										    con.close();
										    out.println("<a href='../login.html'><button type='button' class='btn btn-default btn-lg'>Retour</button></a>");
									    out.println("</div>");
								    out.println("</div>");
							    out.println("</div>");
						    }
						    
						    out.println("</center>");
					
						
						%>
						<!-- <a href="servlet/New" class="btn btn-default btn-block">Créer un compte !</a> -->
					</form>
				</div>
			</div>
		</div>
	</body>
</html>