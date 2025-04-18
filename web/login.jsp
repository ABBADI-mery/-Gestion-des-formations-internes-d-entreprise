<%@page import="entities.Admin, entities.Client, entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - Gestion des Formations</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .create-account {
            text-align: center;
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container">
            <h2 class="text-center mb-4">Connexion</h2>
            
            <% if (request.getAttribute("erreur") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("erreur") %>
                </div>
            <% } %>
             <%-- Section pour afficher le message de déconnexion réussie --%>
            <% if (request.getParameter("logout") != null) { %>
                <div class="alert alert-success">
                    Vous avez été déconnecté avec succès.
                </div>
            <% } %>
            
            <form action="LoginController" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="motDePasse" class="form-label">Mot de passe</label>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Se connecter</button>
            </form>
            
            <div class="create-account">
                <p>Nouveau client ? <a href="register.jsp">Créer un compte</a></p>
                <!-- Ou utiliser un contrôleur si vous en avez un -->
                <!-- <p>Nouveau client ? <a href="RegisterController">Créer un compte</a></p> -->
            </div>
        </div>
    </div>
</body>
</html>