<%@page import="entities.Admin, entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Tableau de bord Admin</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #7E57C2;
                --primary-light: #B39DDB;
                --primary-dark: #5E35B1;
                --accent: #FF9800;
                --text-light: #F5F5F5;
                --text-dark: #212121;
                --bg-light: #F9F9F9;
                --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: var(--bg-light);
                color: var(--text-dark);
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar */
            .sidebar {
                width: 280px;
                background: linear-gradient(145deg, var(--primary-dark), var(--primary));
                color: var(--text-light);
                height: 100vh;
                position: fixed;
                box-shadow: 2px 0 15px rgba(0, 0, 0, 0.1);
                z-index: 100;
            }

            .brand {
                padding: 25px;
                text-align: center;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .brand-logo {
                font-size: 1.8rem;
                font-weight: 700;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 5px;
            }

            .brand-logo i {
                margin-right: 10px;
                color: var(--accent);
            }

            .brand-tagline {
                font-size: 0.8rem;
                opacity: 0.8;
                font-weight: 300;
            }

            .nav-menu {
                padding: 20px 0;
            }

            .nav-item {
                padding: 12px 25px;
                margin: 0 15px;
                border-radius: 6px;
                cursor: pointer;
                display: flex;
                align-items: center;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .nav-item i {
                width: 24px;
                margin-right: 15px;
                text-align: center;
                font-size: 1.1rem;
            }

            .nav-item:hover {
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(5px);
            }

            .nav-item.active {
                background: rgba(255, 255, 255, 0.2);
                border-left: 4px solid var(--accent);
            }

            /* Main Content */
            .main-content {
                margin-left: 280px;
                flex: 1;
                padding: 30px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            .page-title h1 {
                font-size: 1.8rem;
                color: var(--primary-dark);
                font-weight: 600;
            }

            .page-title p {
                font-size: 0.9rem;
                color: #666;
            }

            .user-profile {
                display: flex;
                align-items: center;
                background: white;
                padding: 8px 15px;
                border-radius: 30px;
                box-shadow: var(--card-shadow);
            }

            .user-profile img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
                object-fit: cover;
            }

            /* Welcome Section */
            .welcome-section {
                background: white;
                border-radius: 12px;
                padding: 30px;
                box-shadow: var(--card-shadow);
                margin-bottom: 30px;
            }

            .welcome-header {
                margin-bottom: 30px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }

            .welcome-header h2 {
                font-size: 1.8rem;
                color: var(--primary-dark);
                display: flex;
                align-items: center;
            }

            .welcome-header h2 i {
                margin-right: 15px;
                color: var(--accent);
            }

            .welcome-header .brand {
                color: var(--primary);
                font-weight: 700;
            }

            .welcome-header .subtitle {
                color: #666;
                font-size: 1rem;
                margin-top: 5px;
            }

            .welcome-content {
                display: flex;
                gap: 20px;
                margin-bottom: 30px;
            }

            .welcome-card {
                flex: 1;
                background: linear-gradient(135deg, #f9f9f9, #fff);
                border-radius: 10px;
                padding: 25px;
                border-left: 4px solid var(--accent);
            }

            .welcome-card h3 {
                color: var(--primary-dark);
                margin-bottom: 15px;
                font-size: 1.3rem;
            }

            .welcome-card p {
                color: #555;
                line-height: 1.6;
                margin-bottom: 20px;
            }

            .quick-actions {
                list-style: none;
            }

            .quick-actions li {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .quick-actions li i {
                color: var(--accent);
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .quick-actions li a {
                color: var(--primary);
                text-decoration: none;
                transition: all 0.3s;
            }

            .quick-actions li a:hover {
                color: var(--primary-dark);
                text-decoration: underline;
            }

            .welcome-stats {
                display: flex;
                gap: 20px;
                flex: 1;
            }

            .stat-card {
                flex: 1;
                background: white;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                box-shadow: var(--card-shadow);
                position: relative;
                overflow: hidden;
                border-top: 3px solid var(--primary);
            }

            .stat-card i {
                position: absolute;
                bottom: 10px;
                right: 10px;
                font-size: 2.5rem;
                opacity: 0.2;
                color: var(--primary);
            }

            .stat-value {
                font-size: 2.2rem;
                font-weight: 700;
                color: var(--primary-dark);
                margin-bottom: 5px;
            }

            .stat-label {
                color: #666;
                font-size: 0.9rem;
            }

            .recent-activity {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: var(--card-shadow);
            }

            .recent-activity h3 {
                color: var(--primary-dark);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }

            .recent-activity h3 i {
                margin-right: 10px;
                color: var(--accent);
            }

            .activity-list {
                list-style: none;
            }

            .activity-list li {
                padding: 12px 0;
                border-bottom: 1px solid #eee;
                display: flex;
                align-items: center;
            }

            .activity-list li:last-child {
                border-bottom: none;
            }

            .activity-list li i {
                margin-right: 15px;
                color: var(--primary);
                width: 20px;
                text-align: center;
            }

            .activity-list li span {
                flex: 1;
            }

            .activity-time {
                color: #888;
                font-size: 0.85rem;
            }
            .nav-menu a {
                color: inherit; 
                text-decoration: none; 
                display: block; 
            }

            .nav-menu .nav-item {
                color: var(--text-light); 
            }
        </style>
    </head>
    <body>
        <!-- Vérification de l'utilisateur -->
        <%
            User user = (User) session.getAttribute("user");
            if (user == null || !(user instanceof Admin)) {
                response.sendRedirect("../login.jsp");
                return;
            }
            Admin admin = (Admin) user;
        %>

        <!-- Sidebar Navigation -->
        <div class="sidebar">
            <div class="brand">
                <div class="brand-logo">
                    <i class="fas fa-graduation-cap"></i>
                    <span>MeryAcademi</span>
                </div>
                <div class="brand-tagline">Plateforme d'éducation digitale</div>
            </div>

            <div class="nav-menu">
                <div class="nav-item active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Tableau de bord</span>
                </div>
                <a href="${pageContext.request.contextPath}/formations/page.jsp" class="nav-item">
                    <i class="fas fa-book-open"></i>
                    <span>Formations</span>
                </a>
                <a href="../sessions/page.jsp" class="nav-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions</span>
                </a>
                <a href="../users/participants.jsp" class="nav-item">
                    <i class="fas fa-users"></i>
                    <span>Utilisateurs</span>
                </a>
                <a href="../statistique/statis.jsp" class="nav-item">
                    <i class="fas fa-chart-line"></i>
                    <span>Statistiques</span>
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
                <div class="page-title">
                    <h1>Tableau de bord</h1>
                    <p>Bienvenue dans votre espace d'administration</p>
                </div>

                <div class="user-profile">
                    <%
                        String nomAdmin = admin.getNom();
                    %>
                    <img src="https://ui-avatars.com/api/?name=<%= nomAdmin %>&background=7E57C2&color=fff" alt="<%= nomAdmin %>">
                    <span><%= nomAdmin %></span>
                </div>
            </div>

            <!-- Improved Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-header">
                    <h2><i class="fas fa-hand-wave"></i> Bienvenue sur <span class="brand">MeryAcademi</span> Admin</h2>
                    <p class="subtitle">Votre centre de commande pour une gestion optimale de la plateforme</p>
                </div>

                <div class="welcome-content">
                    <div class="welcome-card">
                        <h3>Commencez rapidement</h3>
                        <p>Prenez en main les fonctionnalités clés pour administrer efficacement votre plateforme éducative.</p>
                        <ul class="quick-actions">
                            <li><i class="fas fa-plus-circle"></i> <a href="${pageContext.request.contextPath}/formations/page.jsp">Créer une nouvelle formation</a></li>
                            <li><i class="fas fa-user-plus"></i> <a href="#">Ajouter un utilisateur</a></li>
                            <li><i class="fas fa-chart-pie"></i> <a href="../statistique/statis.jsp">Voir les statistiques</a></li>
                        </ul>
                    </div>

                    <div class="welcome-stats">
                        <div class="stat-card">
                            <div class="stat-value" id="formations-count">0</div>
                            <div class="stat-label">Formations actives</div>
                            <i class="fas fa-book-open"></i>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" id="users-count">0</div>
                            <div class="stat-label">Utilisateurs</div>
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value" id="sessions-count">0</div>
                            <div class="stat-label">Sessions en cours</div>
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Script AJAX pour récupérer les données -->
       <script>
    // Fonction pour charger les statistiques dynamiquement
    function loadStats() {
        // Requête AJAX pour le nombre de formations
        fetch('${pageContext.request.contextPath}/FormationStatsController')
            .then(response => response.json())
            .then(data => {
                document.getElementById('formations-count').textContent = data.formationsCount || 0;
            })
            .catch(error => console.error('Erreur formations:', error));

        // Requête AJAX pour le nombre d'utilisateurs
        fetch('${pageContext.request.contextPath}/UserStatsController')
            .then(response => response.json())
            .then(data => {
                document.getElementById('users-count').textContent = data.usersCount || 0;
            })
            .catch(error => console.error('Erreur utilisateurs:', error));

        // Requête AJAX pour le nombre total de sessions (via SessionStatsController)
        fetch('${pageContext.request.contextPath}/SessionStatsController?statType=countAll')
            .then(response => response.json())
            .then(data => {
                document.getElementById('sessions-count').textContent = data.sessionsCount || 0;
            })
            .catch(error => console.error('Erreur sessions totales:', error));

        // OPTIONNEL : Statistiques avancées (participants par session)
        fetch('${pageContext.request.contextPath}/SessionStatsController?statType=participantsBySession')
            .then(response => response.json())
            .then(data => {
                const participantsData = data.participantsBySession;
                let totalParticipants = 0;
                
                // Calcul du total des participants
                for (const session in participantsData) {
                    totalParticipants += participantsData[session];
                }
                
                // Affichage dans un élément (ajoutez un élément HTML avec id="total-participants")
                document.getElementById('total-participants').textContent = totalParticipants;
                
                // Vous pouvez aussi utiliser ces données pour un graphique
                console.log("Données pour graphique:", participantsData);
            })
            .catch(error => console.error('Erreur participants:', error));
    }

    // Chargement au démarrage et toutes les 60 secondes (rafraîchissement automatique)
    document.addEventListener('DOMContentLoaded', () => {
        loadStats();
        setInterval(loadStats, 60000); // Rafraîchit toutes les minutes
    });
</script>
    </body>
</html>