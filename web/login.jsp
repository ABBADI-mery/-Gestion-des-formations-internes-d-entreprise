<%@page import="entities.Admin, entities.Client, entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Connexion - Gestion des Formations</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #3f37c9;
                --accent-color: #4895ef;
                --light-color: #f8f9fa;
                --dark-color: #212529;
            }

            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .login-container {
                max-width: 450px;
                margin: 80px auto;
                padding: 2.5rem;
                background: white;
                border-radius: 12px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .login-container:hover {
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            }

            .login-header {
                text-align: center;
                margin-bottom: 2rem;
                position: relative;
            }

            .login-header h2 {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .login-header::after {
                content: '';
                display: block;
                width: 60px;
                height: 4px;
                background: var(--accent-color);
                margin: 0.8rem auto;
                border-radius: 2px;
            }

            .form-control {
                padding: 0.75rem 1rem;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                transition: all 0.3s;
            }

            .form-control:focus {
                border-color: var(--accent-color);
                box-shadow: 0 0 0 0.25rem rgba(72, 149, 239, 0.25);
            }

            .btn-login {
                background: var(--primary-color);
                border: none;
                padding: 0.75rem;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s;
            }

            .btn-login:hover {
                background: var(--secondary-color);
                transform: translateY(-2px);
            }

            .create-account {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid #eee;
                color: #666;
            }

            .create-account a {
                color: var(--primary-color);
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s;
            }

            .create-account a:hover {
                color: var(--secondary-color);
                text-decoration: underline;
            }

            .input-group-text {
                background-color: transparent;
                border-right: none;
            }

            .input-with-icon {
                border-left: none;
            }

            .brand-logo {
                text-align: center;
                margin-bottom: 1.5rem;
            }

            .brand-logo img {
                height: 50px;
            }

            .floating-alert {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1000;
                animation: fadeInDown 0.5s;
            }

            @media (max-width: 576px) {
                .login-container {
                    margin: 40px 20px;
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="login-container animate__animated animate__fadeIn">
                <!-- Brand Logo (remplacez par votre logo) -->
                <div class="brand-logo">
                    <i class="fas fa-graduation-cap" style="font-size: 2.5rem; color: var(--primary-color);"></i>
                </div>

                <div class="login-header">
                    <h2>Connexion à votre compte</h2>
                    <p>Accédez à votre espace personnel</p>
                </div>

                <% if (request.getAttribute("erreur") != null) {%>
                <div class="alert alert-danger animate__animated animate__shakeX">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("erreur")%>
                </div>
                <% } %>

                <% if (request.getParameter("logout") != null) { %>
                <div class="alert alert-success animate__animated animate__fadeIn">
                    <i class="fas fa-check-circle me-2"></i>
                    Vous avez été déconnecté avec succès.
                </div>
                <% }%>

                <form action="LoginController" method="post">
                    <div class="mb-4">
                        <label for="email" class="form-label fw-semibold">Adresse Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control input-with-icon" id="email" name="email" 
                                   required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="motDePasse" class="form-label fw-semibold">Mot de passe</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control input-with-icon" id="motDePasse" 
                                   name="motDePasse"  required>
                        </div>
                        <div class="form-text text-end mt-1">
                            <a href="#" class="text-decoration-none">Mot de passe oublié ?</a>
                        </div>
                    </div>

                    <div class="d-grid mb-3">
                        <button type="submit" class="btn btn-primary btn-login">
                            <i class="fas fa-sign-in-alt me-2"></i>Se connecter
                        </button>
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Se souvenir de moi</label>
                    </div>
                </form>

                <div class="create-account">
                    <p class="mb-0">Vous n'avez pas de compte ? <a href="register.jsp">S'inscrire maintenant</a></p>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    // Animation pour les champs de formulaire
                    document.querySelectorAll('.form-control').forEach(input = > {
            input.addEventListener('focus', function() {
            this.parentElement.parentElement.classList.add('animate__animated', 'animate__pulse');
            });
                    input.addEventListener('blur', function() {
                    this.parentElement.parentElement.classList.remove('animate__animated', 'animate__pulse');
                    });
            });
        </script>
    </body>
</html>