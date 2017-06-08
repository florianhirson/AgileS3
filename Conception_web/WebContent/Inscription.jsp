<%@ page
	import="java.lang.*, java.lang.Integer, java.util.*, achat.*, article.Article, utilisateur.*, java.util.ArrayList, java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement"%>
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

 <section class="">
                <% 
            System.out.println( "CHECK mdp : ~~~~~~~ "+session.getAttribute("login") +"\n");
            if(session.getAttribute("error")=="o"){ %>

                    <p class="error_message">Erreur les mots de passes ne correspondent pas.</p>

			<% }else if(session.getAttribute("errort")=="t"){ %>
	                        <p class="error_message">Veuillez entrer un mot de passe.</p>
			<% } else if(session.getAttribute("errore")=="e"){%>
	                        <p class="error_message"> ce login existe deja </p>
			<% } else if(session.getAttribute("errorm")=="m"){ %>
                                <p class="error_message"> ce mail est deja present sur ce site </p>
			<% } else if(session.getAttribute("errornull")=="nullr"){ %>
        	                <p class="error_message"> Veuillez renseigner :
					<% if(session.getAttribute("isnulll")!=null ) %>
						<%=session.getAttribute("isnulll")%>
					<% if(session.getAttribute("isnulln")!=null ) %>
						<%=session.getAttribute("isnulln")%>
					<% if(session.getAttribute("isnullna")!=null ) %>
						<%=session.getAttribute("isnullna")%>
					<% if(session.getAttribute("isnullp")!=null ) %>
						<%=session.getAttribute("isnullp")%>
                                    </p>
			<% } else if(session.getAttribute("errorfm")=="fm"){ %>
                               <p class="error_message"> cette adresse email est invalide </p>
			<% } %>
                                            <header>
                                                <h1 class="color-clear">Inscription </h1>
                                            </header>

                                            <form method="get" action="servlet_ins.jsp">
                                                <hr class="hr-petite" />
                                                <div>
                                                    <p> Login* : </p>
                                                    <input type="text" maxlength="16" name="login" value="<c:out value="${login}"/>" />
                                                </div>
                                                <div class=" navbar-header">
                                                    <p>Nom* : </p>
                                                    <input type="text" maxlength="20" value="<c:out value="${nom}"/>" name="nom" />
                                                </div>
                                                <div class="collapse navbar-collapse" aria-expanded="true">
                                                    <ul class="nav navbar-nav navbar-right">
                                                        <li>
                                                            <p>Prenom* : </p>
                                                            <input type="text" maxlength="16" value="<c:out value="${prenom}"/>" name="prenom" />
                                                        </li>
                                                    </ul>
                                                </div>
                                                <p> </p>
                                                <p>Adresse* :</p><input type="text" size="10" maxlength="250" value="<c:out value="${address}"/>" class="Boitegrandetaille" name="address" />
                                                <p> </p>
                                                <p> Mail* : <input type="email" maxlength="50" value="<c:out value="${mail}"/>" class="form-control" name="mail" /></p>
                                                <p> </p>

                                                <div class="navbar-header">
                                                    <p>tel. : </p>
                                                    <input type="text" maxlength="10" value="<c:out value="${tel}"/>" name="tel" />
                                                </div>

                                                <hr />
                                                <p> Mot de passe* </p><input type="password" maxlength="16" value="<c:out value="${mdp}"/>" class="form-control" name="mdp" />
                                                <p> Confirmer mot de passe* </p><input type="password" maxlength="16" value="<c:out value=""/>" class="form-control" name="checkmdp" />
                                                <hr  />


                                                <input type=submit value="Valider" class="btn btn-primary btn-x1" />
                                            </form>
                                            <p class="ecritpetit text-left">* : obligatoire </p>

            </section>
</body>
</html>
