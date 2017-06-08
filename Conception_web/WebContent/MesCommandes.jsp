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

<style type="text/css">body { cursor: url('data:image/x-icon;base64,AAACAAEAICAAABoAAQCoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAAAYAAAAPAAAAHwAAAC8AAAA5AQEBOgEBAS4BAQEoAQEBIQAAACMAAAAdAAAAEgAAAAcAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAMAAAAFQAAACUBAQE3rSqa/6Auj/8HBwdZBwcHTwkJCU0ICAhHBAQERQEBATcAAAAjAAAADwAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAADAAAAB8AAAAwlQx+/3wGcv9qBGH/YwVY/xUVFXkVFRV1FhYWdRUVFXENDQ1mBAQEUAAAADMAAAAYAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAkAAAAbAQEBNosSg/95CG3/dwZp/14EV/9NBUf/HBwch4MbeP96Fmz/aw5i/xUVFXoICAhhAQEBOwAAAB4AAAAEAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEL0usP+LEYT/hg9//30Odv9cBFb/NwEy/4cWev9yC2f/chNm/2wNZf9sDWL/UwpG/wwMDGgCAgI9AAAAHQAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADFQ7z/hgyE/48Ziv+DFYH/XwVZ/zACLP95CnL/dg1v/20MZf9tDmL/axRd/3YgS/9/TQD/DQ0NZQICAjgAAAAXAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAyUPH+p4jl/+hJZv/lBqQ/24FZv9LBUr/cwZn/20KZ/9yDmr/awxj/2wPV/+LUQD/lFsA/4tTAP8LCwtaAQEBLQAAAA4AAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC6MrT/pCSg/6YlpP+HEoT/jBuF/34Sef96EnP/agti/2QHWP9sHDb/ik0A/49TAP+RVQD/ilYA/wcHB04BAQEnAAAACQAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQMAAAAAAAAAAKs5qf+gLZz/jyKJ/4EXff90D1r/h0wA/4hMAP+JTAD/iE0A/4lRAP8PDw9wAwMDRwAAACgAAAALAAAAAwAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAgAAAAAAAAAAtEO2/6s7q/+aKpP/iSJv/6VrAP+XWwD/j1EA/4FJAP9/SgD/f08A/w0NDW0DAwNLAAAAMAAAABUAAAAIAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAgAAAAAAAAAAsDeu/7JXa//BhgD/tXcA/6ZsAP+ZXQD/ilIA/4dMAP+GUwD/ERERdAYGBlgBAQFAAAAAJgAAABMAAAAGAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQEAAAAAz58A/8iTAP/DiQD/v4MA/6tvAP+SVwD/jFIA/3xeAP8XFxd/DAwMaQMDA1EAAAA5AAAAIgAAAA4AAAAFAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQEAAAAA0KIA/8qXAP/HkQD/uHwA/6p0AP9KbwD/QHUA/0d+AP8VFRV7CgoKZQICAksAAAAzAAAAGwAAAAoAAAADAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0KMA/8ybAP/AmgD/YaAA/0J6AP8+dQD/Q3kA/06DAP8TExN4CQkJYAICAkQAAAArAAAAFgAAAAkAAAADAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxqgA/3u8AP9utQD/UpUA/zl6AP9CegD/Qn8A/zhSDr4SEhJ0BwcHWQEBAT8AAAAnAAAAEwAAAAcAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQEAAAAAesAA/33AAP9qtAD/RIkA/z5/AP9BfwD/PYEA/xkZGYEODg5sBAQEUwAAADsAAAAjAAAADwAAAAQAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGNxwD/dL0A/3m/AP9fqgD/PIEA/xuDAP8Atr7/ALvL/xcXF34MDAxnAwMDUAAAADUAAAAcAAAACQAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQKIxgD/dL4A/3G8AP8Awqr/AMXS/wC/1v8Avdb/AL/Y/xQUFHgICAhhAQEBRQAAACoAAAARAAAABAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQJ2xQD/AOLf/wDi7f8A0Ob/AMXg/wDA3P8Aut3/B4vQ7hAQEHAFBQVVAAAAOAAAAB0AAAAJAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEBAQQA6vP/AOn1/wDe8/8Azer/ALzl/wBw/v8AZv7/FhYWfQoKCmQCAgJHAAAAKgAAABEAAAAEAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQMDAwcA6fj/AOP4/wDH+v8AbP//AGP//wBj//8Aaf//EBAQcgQEBFUAAAA4AAAAHAAAAAgAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAgXl+v8AvP//B6f//wB3//8AZ///AGT//wBj//8VFRV8CQkJYwEBAUYAAAApAAAADwAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgICBROv//8Cq///AJX//wCL//8AaP//AGb//wBl/f8PDw9vAwMDUwAAADcAAAAaAAAABgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQECAAAAAAmo//8EoP//AIn//wBx//8AX///Girx/xMTE3gHBwdfAQEBQgAAACYAAAAMAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKr//wGh//8Ak///AHj//xgc9P8cHer/JSHm/wsLC2kCAgJPAAAAMAAAABQAAAACAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAip/DxAZ3//zFI//8fJPz/EhHk/w8O2P8YF9j/Dw8PcAQEBFgAAAA4AAAAGwAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAvN///Mzz//zM0//8vMvv/Jyf1/x8i7f80MrXeBwcHXAEBATgAAAAbAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgICBVBV//85O///KC7//yQk/P8aG/L/Ghvs/yEi6f8JCQlXAQEBMAAAABQAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAQEBAQEBBEpS//89P///LzL//xwe9/8bG+//IB7n/wgICEEBAQEfAAAACgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBBEdK//9CRf//JCb//xoa8f8bG+j/BAQEHwAAAA4AAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAgICBUlL//8sMP//Hh70/wAAAAABAQEIAAAAAwAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQEBAgEBAQMBAQEDAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAA///////n////h////wB///wAP//4AD//8AA///AAP//+AH///gB///8Af///gH///8A////gH///8A////gH///4B////AP///4B////Af///4D///+A////wH///+B////gP///4D////Af///wH///+B////wf///+P/////8='), auto; }</style>

	<% int pageArt=0; %>
	<%if(request.getParameter("pageArt")==null){%>
		<%pageArt = 0; %>
	<%} else {%>
		<%pageArt = Integer.valueOf(request.getParameter("pageArt"));%>
	<%}%>
	
	<%if (session.getAttribute("login") == null || session.getAttribute("user") == null )
			response.sendRedirect("Login.jsp");%>

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
		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a> 
		<% } else { %>
		<% if(((Me)session.getAttribute("user"))!=null && ((Me)session.getAttribute("user")).getDroit()==2 ){ %>
		<a class="btn btn-default" href="./admin.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Administration</a> 
		<% } else { %>
		<a class="btn btn-default" href="./edit_account.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mon
			Compte</a>
		<% } %> 
		<% } %>  <a class="btn btn-default" href="./MesCommandes.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Mes
			Commandes</a>
			<a class="btn btn-default" href="./Promotions.jsp" role="button"
			style="width: 18%; margin-left: 1%; margin-right: 1%; background-color: #dfe3ee">Promotions</a>
		<%if(session.getAttribute("login")==null){ %>
		<a class="btn btn-default" href="" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Connexion</a>
		<%}else{%>
		<a class="btn btn-default" href="./LogOut.jsp" role="button"
			style="width: 18%; margin-left: 1%; background-color: #dfe3ee">Deconnexion</a>
		<%}%>
	</div>
	
	<div style="background-color: #dddddd; margin: 2%; border-radius: 10px; padding: 1%;">
	
		<h3> Pas de commandes en cours </h3>
		</div>
</body>