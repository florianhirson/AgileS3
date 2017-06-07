<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"  %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="metier.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
		<title>Ma page</title>
		<style>
			.redbann{
				background-color: red;
				color:#fff;
				text-align:center;
			}
			

		</style>
	</head>
	<body >

	
<!-- 
	A) Recuperation du panier ( et creation le cas écheant ) 
-->	
<% 
	
		Panier myPanier;	
		int prixTT=0;

		if(session.getAttribute("pan")==null){
			myPanier=new Panier();
		}else{
			myPanier=(Panier)session.getAttribute("pan");
		}

/*
<!-- 
	B) Recuperation du paramètre si il existe et ajout au panier + redirection ci dessous 
-->
*/
		String tmp;
		int i=0;
		int taille=myPanier.getNbArticle();
		
		while(i<taille){

			if(request.getParameter("take"+i)!=null&&(tmp=request.getParameter("id"+i))!=null){
				if(myPanier.getCount(tmp)==null)
					myPanier.addPanier(tmp,Integer.parseInt(request.getParameter("qte"+i)));
				else
					myPanier.addPanier(tmp,myPanier.getCount(tmp)+Integer.parseInt(request.getParameter("qte"+i)));

					session.setAttribute("pan",myPanier);
			}
			else if((tmp=request.getParameter("id"+i))==null){
				i=100;
			}

			i++;
		}
		
%>
<!--
	 A) Recuperation du panier ( et creation le cas écheant ) ci dessus 
-->
		

		<h2 class="redbann"> Votre panier : <a href="index.jsp?clear=yes">clear</a></h2>

		<table class="table">
			<tr>
				<th>Libelle</th><th>Quantité</th>
			</tr>
<!-- 
	C ) affichage du panier avec libelles ci dessous
-->

			<tr>
				<%=myPanier.toString()%>
			</tr>
				
		
		</table>
		<form method="get" action="/servlet/Commander">
			<input type="submit" value="Valider"/>
		</form>


		<h2 class="redbann">Les articles proposés sont : </h2>
		
		<table class="table">
			<tr>		
				<th>Libelle</th><th>Prix</th><th> Qte </th> <th> Acheter </th>
			<tr/>

<% 
	Connection con = null;

		try{

		    Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://psqlserv/n2p1";
			String nom = "barbetf";
			String mdp = "moi";
			con = DriverManager.getConnection(url,nom,mdp);

			Statement stmt = con.createStatement();
			stmt = con.createStatement();

			String query = "select lib,prix,reference from article";
			ResultSet rs = stmt.executeQuery(query);
%>

			<form method="get" action="index.jsp">
<%
			 i=0;
			while(rs.next()){
%>		
<!-- 
	D) affichage du panier avec libelles 
-->			
			<tr>
<%				out.println("<input type=\"hidden\" value=\""+rs.getString("reference")+"\" name=\"id"+i+"\"/> ");
%>
				<td><%=rs.getString("lib")%></td><td><%=rs.getString("prix")%></td>
<%
				out.println("<td><input type=\"number\" name=\"qte"+i+"\" value=\"\" class=\"form-control\"/></td>");
				out.println("<td><input type=\"checkbox\" name=\"take"+i+"\" value=\"ok\" /></td>");
%>	
		</tr>

<%
			i++;
			}
%>
			<input type="submit" value="Acheter" class="btn btn-default"/>
			</form>
<%
		session.setAttribute("taille",i);
		}catch (Exception e) {
%> <h1>Oups ! ( <%= e.getMessage() %> )</h1> <%
		}
		finally {	  
			try{
				con.close();	  
			}catch (Exception e) {
%><h1>Oups ! (<%= e.getMessage() %>)</h1><%
			}
		}
if(request.getParameter("clear")!=null){
			session.invalidate();
			response.sendRedirect("../tpcontrol/index.jsp");
		
		}
%>
		</table>
		
		<a href="index.jsp?clear=yes" class="btn">remise à zero</a>

	</body>
</html>
