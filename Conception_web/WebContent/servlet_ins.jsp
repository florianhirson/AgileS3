<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
<%@ page import="import java.io.*,
import javax.servlet.*,
import javax.servlet.http.*,
import javax.servlet.annotation.WebServlet,
import java.util.Properties,
import java.sql.PreparedStatement,
import java.sql.ResultSet,
import javax.mail.*,
import javax.mail.internet.*,
import java.sql.DriverManager,
import java.sql.Connection,
import java.util.Calendar,
import java.sql.Date,
import java.sql.Types,
import org.apache.commons.validator.routines.EmailValidator," %>

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

 <%
  EmailValidator checkeremail = EmailValidator.getInstance();
	session.invalidate();
	session=request.getSession(true);
	ArrayList<String> link = new ArrayList<String>();
	String lien="";
String table = "utilisateur";
	
	String login=request.getParameter("login");
	
	String mdp=request.getParameter("mdp");
	
	String checkmdp=request.getParameter("checkmdp");
	
	String nom=request.getParameter("nom");
	
	String prenom=request.getParameter("prenom");
	
	String mail=request.getParameter("mail");
	
	String tel=request.getParameter("tel");
	
	String description=request.getParameter("address");



	Connection con = null;


	if(!mdp.equals(checkmdp) || (mdp.length()<5||mdp.length()>20)){
		System.out.println("Inscription "+mdp+" check : "+checkmdp+ " = "+mdp.equals(checkmdp));
		if(mdp.length()<5||mdp.length()>20)
			session.setAttribute("errort","t");
		else
			session.setAttribute("erroro","o");
		response.sendRedirect("Inscription.jsp");
	}else if(this.selectCheck(voir,login,link)){
		session.setAttribute("errore","e");
		response.sendRedirect("Inscription.jsp");
	}else if(this.selectCheck(voir, mail, link)){

		session.setAttribute("errorm","m");
		response.sendRedirect("Inscription.jsp");
	}else if(!checkeremail.isValid(mail)){
		session.setAttribute("errorfm","fm");
		response.sendRedirect("Inscription.jsp");
	}else{ 
		if(login.length()<4 || nom.length()<3 || naiss.length()<2|| prenom.length()<3){
			session.setAttribute("errornull","nullr");

			if(login.length()<4){
				session.setAttribute("isnulll","login d'une taille superieur à 4");
			}
			if(nom.length()<3){
				session.setAttribute("isnulln","nom");
			}
			if(naiss.length()<2){
				session.setAttribute("isnullna","naissance");
			}
			if(prenom.length()<3){
				session.setAttribute("isnullp","prenom");
			}
			response.sendRedirect("Inscription.jsp");
		}else{
			try{
				
				Class.forName("org.postgresql.Driver");

				String url = "jdbc:postgresql://psqlserv/n2p1";
				String user = "barbetf";
				String mdpasse = "moi";
				con = DriverManager.getConnection(url,user,mdpasse);
				String query="INSERT INTO ";
				query+=table+"(login,nom,prenom,mail,tel,mdp,address) VALUES ";

				PreparedStatement ps = con.prepareStatement(query+"(?,?,?,?,?,?,?);");

				ps.setString(1,login);
				ps.setString(2,nom);
				ps.setString(3,prenom);
				ps.setString(4,mail);
				ps.setString(5,tel);
				ps.setString(6,mdp);
				ps.setString(7,description);
				
				ps.executeUpdate();
				
				Mail.selectCheck(voir,login,link);

				String content="<h1>Doorsup vous souhaite la bienvenue</h1>\n";
				content+="<p>Bonjour "+prenom+" "+nom+",<p>";
				content+="\n<p>nous avons remarqué votre venu sur notre site, il ne reste plus qu'une etape pour l'activation de votre compte<p>";
				content+="\n<p> il faut appeler les HENDEK !<p>";
				content+="\n<p> Veuillez confirmer votre inscription en cliquant sur le lien suivant :<p>";

				lien+=link.get(0)+"="+link.get(1)+"&";
				lien+=link.get(2)+"="+link.get(3)+"&";
				lien+=link.get(4)+"="+link.get(5);

				content+="\n<a href=\"localhost:8080/Conception_web/verify.jsp?"+lien+"\">Activer mon compte </a>";
				content+="\n<p>verifier les informations :</p>\n<ul>";
				content+="\n<li> login : "+login+"</li>";
				content+="\n<li> tel : "+tel+"</li>";
				content+="\n<li> adresse : "+description+"</li>\n</ul>";

				content+="<h2>Appelez les HENDEKs</h2>";

				Mail.sendMail(content,mail);

				session.setAttribute("success","o");
				response.sendRedirect("Login.jsp");

			}catch (Exception e) {
				
				System.out.println("=====> ERROR(Mailer.service(1)) : "+e.getMessage());

			}
			finally {	  
				try{
					con.close();	  
				}catch (Exception e) {
					
					System.out.println("=====> ERROR(Mailer.service(2)) : "+e.getMessage());
				}
			}
		}
	}
 
 
 %>
</body>
</html>