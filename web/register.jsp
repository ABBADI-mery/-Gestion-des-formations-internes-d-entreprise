<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Création de compte client</title>
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
            --success-color: #4bb543;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .register-container {
            max-width: 550px;
            margin: 80px auto;
            padding: 2.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .register-container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
            position: relative;
        }
        
        .register-header h2 {
            color: var(--primary-color);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .register-header::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: var(--accent-color);
            margin: 0.8rem auto;
            border-radius: 2px;
        }
        
        .register-header p {
            color: #666;
            font-size: 0.95rem;
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
        
        .btn-register {
            background: var(--primary-color);
            border: none;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s;
            margin-top: 1rem;
        }
        
        .btn-register:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #eee;
            color: #666;
        }
        
        .login-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .login-link a:hover {
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
            background: var(--success-color);
            transition: width 0.3s;
        }
        
        .password-requirements {
            font-size: 0.8rem;
            color: #666;
            margin-top: 5px;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin-bottom: 3px;
        }
        
        .requirement i {
            margin-right: 5px;
            font-size: 0.7rem;
        }
        
        .requirement.valid {
            color: var(--success-color);
        }
        
        @media (max-width: 576px) {
            .register-container {
                margin: 40px 20px;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container animate__animated animate__fadeIn">
            <!-- Brand Logo -->
            <div class="brand-logo">
                <i class="fas fa-user-plus" style="font-size: 2.5rem; color: var(--primary-color);"></i>
            </div>
            
            <div class="register-header">
                <h2>Création de compte client</h2>
                <p>Remplissez le formulaire pour créer votre compte</p>
            </div>
            
            <% if (request.getAttribute("erreur") != null) { %>
                <div class="alert alert-danger animate__animated animate__shakeX">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <%= request.getAttribute("erreur") %>
                </div>
            <% } %>
            
            <form action="RegisterController" method="post" id="registerForm">
                <div class="mb-4">
                    <label for="nom" class="form-label fw-semibold">Nom complet</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control input-with-icon" id="nom" name="nom" 
                               placeholder="Votre nom complet" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="email" class="form-label fw-semibold">Adresse Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control input-with-icon" id="email" name="email" 
                               placeholder="votre@email.com" required>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="motDePasse" class="form-label fw-semibold">Mot de passe</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control input-with-icon" id="motDePasse" 
                               name="motDePasse" placeholder="••••••••" required
                               oninput="checkPasswordStrength(this.value)">
                    </div>
                    <div class="password-strength">
                        <div class="password-strength-bar" id="passwordStrengthBar"></div>
                    </div>
                    <div class="password-requirements">
                        <div class="requirement" id="lengthReq">
                            <i class="fas fa-circle"></i> 8 caractères minimum
                        </div>
                        <div class="requirement" id="numberReq">
                            <i class="fas fa-circle"></i> Au moins 1 chiffre
                        </div>
                        <div class="requirement" id="specialReq">
                            <i class="fas fa-circle"></i> Au moins 1 caractère spécial
                        </div>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label for="confirmPassword" class="form-label fw-semibold">Confirmer le mot de passe</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control input-with-icon" id="confirmPassword" 
                               name="confirmPassword" placeholder="••••••••" required
                               oninput="checkPasswordMatch()">
                    </div>
                    <small id="passwordMatchMessage" class="text-danger"></small>
                </div>
                
                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary btn-register" id="submitBtn">
                        <i class="fas fa-user-plus me-2"></i>Créer le compte
                    </button>
                </div>
                
                <div class="form-check mb-3">
                    <input class="form-check-input" type="checkbox" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">
                        J'accepte les <a href="#" class="text-decoration-none">conditions d'utilisation</a>
                    </label>
                </div>
            </form>
            
            <div class="login-link">
                <p class="mb-0">Déjà un compte ? <a href="login.jsp">Se connecter</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Vérification de la force du mot de passe
        function checkPasswordStrength(password) {
            let strength = 0;
            const bar = document.getElementById('passwordStrengthBar');
            
            // Vérifier la longueur
            if (password.length >= 8) {
                strength += 25;
                document.getElementById('lengthReq').classList.add('valid');
            } else {
                document.getElementById('lengthReq').classList.remove('valid');
            }
            
            // Vérifier les chiffres
            if (password.match(/([0-9])/)) {
                strength += 25;
                document.getElementById('numberReq').classList.add('valid');
            } else {
                document.getElementById('numberReq').classList.remove('valid');
            }
            
            // Vérifier les caractères spéciaux
            if (password.match(/([!,%,&,@,#,$,^,*,?,_,~])/)) {
                strength += 25;
                document.getElementById('specialReq').classList.add('valid');
            } else {
                document.getElementById('specialReq').classList.remove('valid');
            }
            
            // Vérifier les majuscules
            if (password.match(/([A-Z])/)) {
                strength += 25;
            }
            
            bar.style.width = strength + '%';
            
            // Changer la couleur en fonction de la force
            if (strength < 50) {
                bar.style.background = '#ff5252';
            } else if (strength < 75) {
                bar.style.background = '#ffb142';
            } else {
                bar.style.background = '#4bb543';
            }
        }
        
        // Vérification de la correspondance des mots de passe
        function checkPasswordMatch() {
            const password = document.getElementById('motDePasse').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const message = document.getElementById('passwordMatchMessage');
            
            if (confirmPassword === '') {
                message.textContent = '';
            } else if (password !== confirmPassword) {
                message.textContent = 'Les mots de passe ne correspondent pas';
            } else {
                message.textContent = 'Les mots de passe correspondent';
                message.classList.remove('text-danger');
                message.classList.add('text-success');
            }
        }
        
        // Validation du formulaire avant soumission
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('motDePasse').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas');
            }
        });
    </script>
</body>
</html>