<%@page import="entities.Admin, entities.Client, entities.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Connexion - meriAcdemi</title>
        <!-- Favicon -->
        <link rel="icon" href="assets/img/favicon.ico">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Animate.css -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <style>
            :root {
                --primary-color: #7E57C2;
                --primary-light: #B39DDB;
                --primary-dark: #5E35B1;
                --secondary-color: #FF9800;
                --light-color: #F5F5F5;
                --dark-color: #424242;
                --text-color: #212121;
                --success-color: #4CAF50;
                --error-color: #F44336;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background-color: var(--light-color);
                height: 100vh;
                margin: 0;
                padding: 0;
            }

            .login-wrapper {
                display: flex;
                height: 100%;
            }

            .login-image {
                flex: 1;
                background-image: url('${pageContext.request.contextPath}/imgs/login-image.jpg');
                background-size: cover;
                background-position: center;
                position: relative;
                display: none;
            }

            .login-image::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(126, 87, 194, 0.7);
            }

            .image-content {
                position: relative;
                z-index: 2;
                color: white;
                padding: 2rem;
                height: 100%;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .image-content h2 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .image-content p {
                font-size: 1.1rem;
                opacity: 0.9;
                max-width: 80%;
            }

            .login-container {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                background-color: white;
            }

            .login-box {
                max-width: 450px;
                width: 100%;
                padding: 2.5rem;
                animation: fadeInDown 0.6s;
            }

            .brand-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .brand-logo {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .brand-logo i {
                margin-right: 10px;
            }

            .login-title {
                font-size: 1.8rem;
                font-weight: 600;
                color: var(--text-color);
                margin-bottom: 1.5rem;
                text-align: center;
            }

            .form-control {
                padding: 0.75rem 1.25rem;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
                transition: all 0.3s;
                height: 48px;
                font-size: 0.95rem;
            }

            .form-control:focus {
                border-color: var(--primary-light);
                box-shadow: 0 0 0 0.25rem rgba(126, 87, 194, 0.15);
            }

            .btn-login {
                background-color: var(--primary-color);
                border: none;
                padding: 0.75rem;
                border-radius: 8px;
                font-weight: 600;
                letter-spacing: 0.5px;
                transition: all 0.3s;
                height: 48px;
                width: 100%;
                font-size: 1rem;
                margin-top: 1rem;
            }

            .btn-login:hover {
                background-color: var(--primary-dark);
                transform: translateY(-2px);
            }

            .form-footer {
                text-align: center;
                margin-top: 1.5rem;
                padding-top: 1.5rem;
                border-top: 1px solid #eee;
                color: var(--dark-color);
                font-size: 0.95rem;
            }

            .form-footer a {
                color: var(--primary-color);
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s;
            }

            .form-footer a:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }

            .password-toggle {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: var(--dark-color);
                z-index: 5;
            }

            .password-container {
                position: relative;
            }

            .forgot-password {
                text-align: right;
                margin-top: 0.5rem;
            }

            .forgot-password a {
                color: var(--primary-color);
                font-size: 0.85rem;
                text-decoration: none;
            }

            .forgot-password a:hover {
                text-decoration: underline;
            }

            .alert {
                border-radius: 8px;
                padding: 1rem;
                border: none;
                margin-bottom: 1.5rem;
            }

            .alert-danger {
                background-color: rgba(244, 67, 54, 0.1);
                color: var(--error-color);
                border-left: 4px solid var(--error-color);
            }

            .alert-success {
                background-color: rgba(76, 175, 80, 0.1);
                color: var(--success-color);
                border-left: 4px solid var(--success-color);
            }

            @media (min-width: 992px) {
                .login-image {
                    display: block;
                }
                
                .login-container {
                    flex: 0 0 50%;
                }
            }

            @media (max-width: 576px) {
                .login-box {
                    padding: 1.75rem;
                }
                
                .brand-logo {
                    font-size: 2rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-wrapper">
            <!-- Image Section -->
            <div class="login-image">
                <div class="image-content">
                    <h2>Bienvenue sur MeryAcademi</h2>
                    <p>Accédez à votre espace personnel pour gérer vos formations et suivre votre progression académique.</p>
                </div>
            </div>
            
            <!-- Login Form Section -->
            <div class="login-container">
                <div class="login-box">
                    <!-- Brand Header -->
                    <div class="brand-header">
                        <div class="brand-logo">
                            <i class="fas fa-graduation-cap"></i>
                            <span>MeryAcademi</span>
                        </div>
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

                    <h1 class="login-title">Login</h1>

                    <form action="LoginController" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="you@example.com" required>
                        </div>

                        <div class="mb-3">
                            <label for="motDePasse" class="form-label">Password</label>
                            <div class="password-container">
                                <input type="password" class="form-control" id="motDePasse" 
                                       name="motDePasse" placeholder="Enter 8 characters or more" required>
                               
                            </div>
                            <div class="forgot-password">
                                <a href="#">Forgot Password?</a>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-login">
                            Login
                        </button>
                    </form>

                    <div class="form-footer">
                        Doesn't have an account yet? <a href="register.jsp">Sign Up</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Toggle password visibility
            const togglePassword = document.querySelector('#togglePassword');
            const password = document.querySelector('#motDePasse');
            
            togglePassword.addEventListener('click', function () {
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
            });

            // Auto-hide alerts after 5 seconds
            setTimeout(() => {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    alert.classList.add('animate__animated', 'animate__fadeOut');
                    setTimeout(() => {
                        alert.remove();
                    }, 500);
                });
            }, 5000);
        </script>
    </body>
</html>