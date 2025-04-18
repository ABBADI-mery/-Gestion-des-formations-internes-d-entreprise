<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entities.Client, entities.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !(user instanceof Client)) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Client client = (Client) user;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Espace Client</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">Gestion des Formations</a>
            <div class="navbar-text ms-auto">
                Bienvenue <strong><%= client.getNom() %></strong>
             <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-light ms-3">Déconnexion</a>            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h1>Espace Client</h1>
        <div class="card mt-4">
            <div class="card-header">
                Mon compte
            </div>
            <div class="card-body">
                <p><strong>Email :</strong> <%= client.getEmail() %></p>
                <!-- Ajoutez ici le contenu spécifique au client -->
            </div>
        </div>
    </div>
</body>
</html>