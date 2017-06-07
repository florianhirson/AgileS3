<%@ page session="true"%>
<html>
<head>
<title>jsp</title>
</head>
<body>

<%-- Commentaire jsp --%>
<!-- Commentaire java -->
<%! String a = "bonjour"; %>
<% for(int i = 0; i < 5 ; i++) { %>
<h1<%=i%>> titre <%=i%> <%=a%> ${login}!</h1<%=i%>>
<% } %>

</body>
</html>
