<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<%@ page import="java.io.*,
 javax.servlet.*,
 javax.servlet.http.*,
 javax.servlet.annotation.WebServlet,
 java.util.Properties,
 java.sql.PreparedStatement,
 java.sql.ResultSet,
 javax.mail.*,
 javax.mail.internet.*,
 java.sql.DriverManager,
 java.sql.Connection,
 java.util.Calendar,
 java.sql.Date,
 java.sql.Types" %>

<!DOCTYPE html>


<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">
<style>
                .successfull_message {
                   	 background-color: #fff;
                   	 color: #03d826;
                }

		.error_message {
   			color: #b90202;
    			background-color: #fff;
		}

		.ecritpetit {
   			 font-size: 10px;
   			 color:#000;
		}

</style>
<title>Hendek</title>
</head>

<body style="background-color: #f7f7f7;">

 <% session.invalidate();
	session=request.getSession(true);
	ArrayList<String> link = new ArrayList<String>();
	String lien="";
String table = "lignefact";
	
	String login=request.getParameter("login");
	
	String mdp=request.getParameter("mdp");
	
	String checkmdp=request.getParameter("checkmdp");
	
	String nom=request.getParameter("nom");
	
	String prenom=request.getParameter("prenom");
	
	String mail=request.getParameter("mail");
	
	String tel=request.getParameter("tel");
	
	String description=request.getParameter("address");



	Connection con = null;

	%> avant if <%

			try{
				%> try <% 
				Class.forName("org.postgresql.Driver");
				String url = "jdbc:postgresql://psqlserv/n2p1";
				String user = "barbetf";
				String mdpasse = "moi";
				con = DriverManager.getConnection(url,user,mdpasse);
				String query="INSERT INTO";
				query+=table+"() VALUES ";

				PreparedStatement ps = con.prepareStatement(query+"(?,?,?,?,?,?,?);");

				ps.executeUpdate();
				
				new Mail().selectCheck(login,link);

				String content="<h1>HENDEK prend en charge votre livraison</h1>\n";
				content+="<p>Bonjour "+prenom+" "+nom+",<p>";
				content+="\n<p>Nous prenons bien en charge votre livraison<p>";
				
				
				content+="\n<a href=\"localhost:8080/Conception_web/verify.jsp?"+lien+"\">localhost:8080/Conception_web/verify.jsp?"+lien+"</a>";
				content+="\n<p>verifier les informations :</p>\n<ul>";


				content+="<h2>Appelez les HENDEKs</h2>";
				%> av Mail.send<%
				
				new Mail().sendMail(content,mail);
				session.setAttribute("success","o");
				response.sendRedirect("Login.jsp");
				
			}catch (Exception e) {
				%> catch 1<%
				out.println("=====> ERROR(Mailer.service(1)) : "+e.getMessage());
				

			}
			finally {	  
				try{
					con.close();	  
				}catch (Exception e) {
					%> catch 2 <%
					System.out.println("=====> ERROR(Mailer.service(2)) : "+e.getMessage());
				}
			}
		
 
 
 %>
</body>
</html>