<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Création de compte client</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        .register-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h2 class="text-center mb-4">Création de compte client</h2>
            
            <% if (request.getAttribute("erreur") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("erreur") %>
                </div>
            <% } %>
            
            <form action="RegisterController" method="post">
                <div class="mb-3">
                    <label for="nom" class="form-label">Nom complet</label>
                    <input type="text" class="form-control" id="nom" name="nom" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="mb-3">
                    <label for="motDePasse" class="form-label">Mot de passe</label>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Créer le compte</button>
            </form>
            
            <div class="text-center mt-3">
                <p>Déjà un compte ? <a href="login.jsp">Se connecter</a></p>
            </div>
        </div>
    </div>
</body>
</html>