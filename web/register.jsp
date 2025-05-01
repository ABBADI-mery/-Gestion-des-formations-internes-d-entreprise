<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Création de compte client - meriAcdemi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #7E57C2;
            --primary-light: #B39DDB;
            --primary-dark: #5E35B1;
            --secondary-color: #FF9800;
            --light-color: #F5F5F5;
            --dark-color: #424242;
            --success-color: #4CAF50;
            --error-color: #F44336;
        }

        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            background-color: var(--light-color);
        }

        .register-wrapper {
            display: flex;
            width: 100%;
            height: 100%;
        }

        .register-image {
            flex: 1;
            background-image: url('${pageContext.request.contextPath}/imgs/login-image.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
            display: none;
        }

        .register-image::before {
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

        .register-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background-color: white;
        }

        .register-box {
            max-width: 500px;
            width: 100%;
            padding: 2rem;
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

        .register-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--dark-color);
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

        .btn-register {
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

        .btn-register:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(126, 87, 194, 0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            color: var(--dark-color);
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s;
        }

        .login-link a:hover {
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

        .password-strength {
            height: 5px;
            background: #e0e0e0;
            border-radius: 3px;
            margin-top: 5px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: var(--dark-color);
            margin-top: 10px;
        }

        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .requirement i {
            margin-right: 5px;
            font-size: 0.7rem;
            color: #ccc;
        }

        .requirement.valid i {
            color: var(--success-color);
        }

        .requirement.valid {
            color: var(--success-color);
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

        @media (min-width: 992px) {
            .register-image {
                display: block;
            }
            
            .register-container {
                flex: 0 0 50%;
            }
        }

        @media (max-width: 576px) {
            .register-box {
                padding: 1.5rem;
            }
            
            .brand-logo {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-wrapper">
        <!-- Image Section -->
        <div class="register-image">
            <div class="image-content">
                <h2>Rejoignez MeryAcademi</h2>
                <p>Créez votre compte pour accéder à toutes nos formations et ressources éducatives.</p>
            </div>
        </div>
        
        <!-- Register Form Section -->
        <div class="register-container">
            <div class="register-box">
                <!-- Brand Header -->
                <div class="brand-header">
                    <div class="brand-logo">
                        <i class="fas fa-user-plus"></i>
                        <span>MeryAcademi</span>
                    </div>
                    <p class="brand-subtitle">Votre plateforme d'apprentissage en ligne</p>
                </div>

                <% if (request.getAttribute("erreur") != null) { %>
                    <div class="alert alert-danger animate__animated animate__shakeX">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <%= request.getAttribute("erreur") %>
                    </div>
                <% } %>

                <h1 class="register-title">Création de compte</h1>

                <form action="RegisterController" method="post" id="registerForm">
                    <div class="mb-3">
                        <label for="nom" class="form-label">Nom complet</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="nom" name="nom" 
                                   placeholder="Votre nom complet" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Adresse Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                            <input type="email" class="form-control" id="email" name="email" 
                                   placeholder="votre@email.com" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="motDePasse" class="form-label">Mot de passe</label>
                        <div class="password-container">
                            <input type="password" class="form-control" id="motDePasse" 
                                   name="motDePasse" placeholder="••••••••" required
                                   oninput="checkPasswordStrength(this.value)">
                            
                        </div>
                        
                        
                    </div>
                    
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirmer le mot de passe</label>
                        <div class="password-container">
                            <input type="password" class="form-control" id="confirmPassword" 
                                   name="confirmPassword" placeholder="••••••••" required
                                   oninput="checkPasswordMatch()">
                            
                        </div>
                        <small id="passwordMatchMessage" class="text-danger"></small>
                    </div>
                    
                  

                    <button type="submit" class="btn btn-register" id="submitBtn">
                        <i class="fas fa-user-plus me-2"></i>Créer le compte
                    </button>
                </form>

                <div class="login-link">
                    <p class="mb-0">Déjà un compte ? <a href="login.jsp">Se connecter</a></p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        
        
        // Vérification de la correspondance des mots de passe
        function checkPasswordMatch() {
            const password = document.getElementById('motDePasse').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const message = document.getElementById('passwordMatchMessage');
            
            if (confirmPassword === '') {
                message.textContent = '';
            } else if (password !== confirmPassword) {
                message.textContent = 'Les mots de passe ne correspondent pas';
                message.classList.remove('text-success');
                message.classList.add('text-danger');
            } else {
                message.textContent = 'Les mots de passe correspondent';
                message.classList.remove('text-danger');
                message.classList.add('text-success');
            }
        }
        
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('motDePasse');
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
        });
        
        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const password = document.getElementById('confirmPassword');
            const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
            password.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="far fa-eye"></i>' : '<i class="far fa-eye-slash"></i>';
        });
        
        // Validation du formulaire avant soumission
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('motDePasse').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas');
                return false;
            }
            
            if (!document.getElementById('termsCheck').checked) {
                e.preventDefault();
                alert('Vous devez accepter les conditions d\'utilisation');
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>