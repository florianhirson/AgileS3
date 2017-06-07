<%@ page pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

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
		<H1 style="color:white; font-size: 600%; font-weight:bold; margin-left:1%; display: inline-block;"><a style="color:white" href=./accueil.jsp>HENDEK</a></H1>
      </header>

	<div style="margin-left: 3%; margin-right: 3%;">
		<a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-right: 1%; background-color: #dfe3ee">Mon
			Panier</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
			Commandes</a> <a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Promotions</a>
		<a class="btn btn-default" href="#" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Connexion</a>
	</div>


	

	

	<%
		Class.forName("org.postgresql.Driver");
		Connection con = null;
		con = DriverManager.getConnection("jdbc:postgresql://217.182.171.28:5432/hendek", "hendek", "hendek");

		session = request.getSession(true);
		String login = (String) session.getAttribute("login");

		PreparedStatement ps = con.prepareStatement("select * from users where login=" + login);
		ResultSet rs = ps.executeQuery();

		String mail = rs.getString("mail");
		String password = rs.getString("password");
		String default_address = rs.getString("default_address");
		String phone = rs.getString("phone");
		
		con.close();
	%>






	<div
		style="background-color: #dddddd; margin: 2% 22% 0 22%; border-radius: 10px; padding: 1%;">

		<div
			style="background-color: #ffffff; margin: 1%; border-radius: 10px; padding: 1%">
			<form>
				<div class="form-group">
					<h2>
						Modifier le compte
						<h2>
							<h3>
								<label for="mail">Mail :</label>
								<h3>
									<input type="text" class="form-control" id="mail" text=<%=mail%>>
									<h3>
										<label for="password">Mot de passe :</label>
										<h3>
											<input type="password" class="form-control" id="password" text=<%=password%>>
											<h3>
												<label for="default_address">Addresse par default :</label>
												<h3>
													<textarea class="form-control" id="default_address"
														rows="3" text=<%=default_address%>></textarea>
													<h3>
														<label for="phone">Telephone :</label>
														<h3>
															<input type="text" class="form-control" id="phone" text=<%=phone%>>
															<br> <input type="submit" class="form-control"
																id="submit" value="Valider">
				</div>
			</form>
		</div>
	</div>
</body>