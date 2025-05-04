<%@page import="entities.Client"%>
<%@page import="entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Mon Profil</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #7E57C2;
                --primary-light: #B39DDB;
                --primary-dark: #5E35B1;
                --accent: #FF9800;
                --background: #F9F9F9;
                --card-bg: #FFFFFF;
                --text-dark: #212121;
                --text-light: #F5F5F5;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                --gradient: linear-gradient(135deg, var(--primary), var(--primary-light));
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                background-color: var(--background);
                font-family: 'Inter', sans-serif;
                display: flex;
                min-height: 100vh;
                color: var(--text-dark);
            }

            /* Sidebar */
            .sidebar {
                width: 80px;
                background: var(--gradient);
                height: 100vh;
                position: fixed;
                transition: width 0.3s ease;
                display: flex;
                flex-direction: column;
                align-items: center;
                padding-top: 20px;
            }

            .sidebar:hover {
                width: 220px;
            }

            .brand {
                margin-bottom: 30px;
                text-align: center;
            }

            .brand-logo i {
                font-size: 1.8rem;
                color: var(--accent);
            }

            .brand-logo span {
                display: none;
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--text-light);
            }

            .sidebar:hover .brand-logo span {
                display: inline;
            }

            .nav-menu {
                flex: 1;
                width: 100%;
            }

            .nav-item {
                display: flex;
                align-items: center;
                padding: 15px 20px;
                color: var(--text-light);
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .nav-item i {
                font-size: 1.2rem;
                margin-right: 15px;
                width: 24px;
                text-align: center;
            }

            .nav-item span {
                display: none;
            }

            .sidebar:hover .nav-item span {
                display: inline;
            }

            .nav-item:hover, .nav-item.active {
                background: rgba(255, 255, 255, 0.1);
                color: var(--accent);
            }

            /* Main Content */
            .main-content {
                margin-left: 80px;
                flex: 1;
                padding: 30px;
                transition: margin-left 0.3s ease;
            }

            .sidebar:hover ~ .main-content {
                margin-left: 220px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .header h1 {
                font-size: 1.8rem;
                font-weight: 600;
                background: var(--gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .header .user-profile {
                display: flex;
                align-items: center;
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                padding: 5px 10px;
                border-radius: 30px;
                box-shadow: var(--shadow);
                transition: all 0.3s ease;
            }

            .user-profile:hover {
                transform: translateY(-2px);
            }

            .user-profile img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                margin-right: 10px;
                border: 2px solid var(--primary-light);
            }

            .user-profile span {
                font-size: 0.9rem;
                font-weight: 500;
            }

            /* Profile Container */
            .profile-container {
                background: var(--card-bg);
                border-radius: 15px;
                padding: 30px;
                box-shadow: var(--shadow);
            }

            .profile-info {
                margin-bottom: 30px;
                padding: 20px;
                background: rgba(126, 87, 194, 0.05);
                border-radius: 10px;
            }

            .profile-info h3 {
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 15px;
            }

            .profile-info p {
                font-size: 0.9rem;
                color: #6B7280;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .profile-info p strong {
                color: var(--text-dark);
                width: 100px;
                font-weight: 500;
            }

            .profile-info p i {
                margin-right: 8px;
                color: var(--primary);
            }

            .form-section h3 {
                font-size: 1.4rem;
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 20px;
            }

            .form-label {
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--text-dark);
            }

            .form-control {
                border-radius: 10px;
                border: 1px solid #E5E7EB;
                padding: 10px 15px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(126, 87, 194, 0.1);
            }

            .btn-primary {
                background: var(--gradient);
                color: var(--text-light);
                border-radius: 25px;
                padding: 10px 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: var(--primary-light);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(126, 87, 194, 0.2);
            }

            /* Message Styles */
            .message-box {
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                box-shadow: var(--shadow);
                background: var(--card-bg);
            }

            .message-success {
                color: #10B981;
                font-weight: 500;
            }

            .message-error {
                color: #EF4444;
                font-weight: 500;
            }

            /* Animations */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .fade-in {
                animation: fadeIn 0.5s ease forwards;
            }
        </style>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            if (user == null || !(user instanceof Client)) {
                response.sendRedirect("../login.jsp");
                return;
            }
            Client client = (Client) request.getAttribute("client");
            if (client == null) {
                client = (Client) user; // Fallback si le contrôleur ne passe pas le client
            }
        %>
        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="brand">
                <div class="brand-logo">
                    <i class="fas fa-graduation-cap"></i>
                    <span>MeryAcademi</span>
                </div>
            </div>

            <div class="nav-menu">
                <a href="client.jsp" class="nav-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions Disponibles</span>
                </a>
                <a href="mesInscriptions.jsp" class="nav-item">
                    <i class="fas fa-list-check"></i>
                    <span>Mes Inscriptions</span>
                </a>
                <a href="profil.jsp" class="nav-item active">
                    <i class="fas fa-user"></i>
                    <span>Mon Profil</span>
                </a>
                <a href="../logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="main-content">
            <div class="header">
                <h1>Mon Profil</h1>
                <div class="user-profile">
                    <%
                        String nomClient = client.getNom();
                    %>
                    <img src="https://ui-avatars.com/api/?name=<%= nomClient%>&background=7E57C2&color=fff" alt="<%= nomClient%>">
                    <span><%= nomClient%></span>
                </div>
            </div>

            <!-- Affichage des messages -->
            <%
                String message = (String) request.getAttribute("message");
                String error = (String) request.getAttribute("error");
                if (message != null) {
            %>
            <div class="message-box message-success fade-in">
                <i class="fas fa-check-circle me-2"></i><%= message%>
            </div>
            <%
                }
                if (error != null) {
            %>
            <div class="message-box message-error fade-in">
                <i class="fas fa-exclamation-circle me-2"></i><%= error%>
            </div>
            <%
                }
            %>

            <!-- Profile Content -->
            <div class="profile-container fade-in">
                <div class="profile-info">
                    <h3>Informations Personnelles</h3>
                    <p><i class="fas fa-user"></i><strong>Nom :</strong> <%= client.getNom()%></p>
                    <p><i class="fas fa-envelope"></i><strong>Email :</strong> <%= client.getEmail()%></p>
                </div>

                <div class="form-section">
                    <h3>Changer le mot de passe</h3>
                    <form action="profil.jsp" method="post">
                        <input type="hidden" name="op" value="update">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Mot de passe actuel</label>
                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" placeholder="Entrez votre mot de passe actuel" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Nouveau mot de passe</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Entrez un nouveau mot de passe" required>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-2"></i>Mettre à jour
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>