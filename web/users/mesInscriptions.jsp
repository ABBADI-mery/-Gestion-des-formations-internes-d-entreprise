<%@page import="entities.Client"%>
<%@page import="entities.SessionFormation"%>
<%@page import="java.util.List"%>
<%@page import="entities.User"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Mes Inscriptions</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary: #2A2E7F; /* Bleu nuit profond */
                --primary-light: #4B50A6; /* Bleu plus clair */
                --accent: #FFD700; /* Doré pour les accents */
                --background: #F8FAFC; /* Fond clair et professionnel */
                --card-bg: #FFFFFF; /* Fond des cartes */
                --text-dark: #1A1C4A; /* Texte sombre */
                --text-light: #FFFFFF; /* Texte clair */
                --text-muted: #6B7280; /* Texte secondaire */
                --shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
                --gradient: linear-gradient(135deg, var(--primary), var(--primary-light));
                --danger: #EF4444; /* Rouge pour annuler */
                --gradient-danger: linear-gradient(135deg, #EF4444, #DC2626);
                --success: #10B981; /* Vert pour succès */
                --warning: #F59E0B; /* Jaune pour en cours */
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
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
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
                background: rgba(255, 255, 255, 0.15);
                color: var(--accent);
            }

            /* Main Content */
            .main-content {
                margin-left: 80px;
                flex: 1;
                padding: 40px;
                transition: margin-left 0.3s ease;
            }

            .sidebar:hover ~ .main-content {
                margin-left: 220px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 40px;
            }

            .header h1 {
                font-size: 2rem;
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
                padding: 8px 15px;
                border-radius: 30px;
                box-shadow: var(--shadow);
                transition: all 0.3s ease;
            }

            .user-profile:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .user-profile img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 12px;
                border: 2px solid var(--primary-light);
            }

            .user-profile span {
                font-size: 1rem;
                font-weight: 500;
            }

            /* Action Bar */
            .action-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                background: var(--card-bg);
                padding: 15px 25px;
                border-radius: 15px;
                box-shadow: var(--shadow);
            }

            .action-bar .filter-select {
                width: 200px;
                border-radius: 10px;
                border: 1px solid #E5E7EB;
                padding: 8px 15px;
                font-size: 0.9rem;
                transition: all 0.3s ease;
            }

            .action-bar .filter-select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(42, 46, 127, 0.1);
            }

            .action-bar .btn-primary {
                background: var(--gradient);
                color: var(--text-light);
                border-radius: 25px;
                padding: 8px 20px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .action-bar .btn-primary:hover {
                background: var(--primary-light);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(42, 46, 127, 0.2);
            }

            /* Sessions Container */
            .sessions-container {
                background: transparent;
            }

            .session-card {
                background: var(--card-bg);
                border-radius: 15px;
                padding: 25px;
                box-shadow: var(--shadow);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                border: 1px solid rgba(0, 0, 0, 0.03);
            }

            .session-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
            }

            .session-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: var(--gradient);
                transition: all 0.3s ease;
            }

            .session-card:hover::before {
                height: 6px;
            }

            .session-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .session-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 0;
            }

            .status-badge {
                font-size: 0.8rem;
                font-weight: 500;
                padding: 5px 12px;
                border-radius: 20px;
                text-transform: uppercase;
            }

            .status-badge.upcoming {
                background: rgba(16, 185, 129, 0.1);
                color: var(--success);
            }

            .status-badge.completed {
                background: rgba(107, 114, 128, 0.1);
                color: var(--text-muted);
            }

            .session-theme {
                font-size: 0.95rem;
                font-weight: 500;
                color: var(--primary);
                background: rgba(42, 46, 127, 0.1);
                padding: 4px 14px;
                border-radius: 20px;
                display: inline-block;
                margin-bottom: 20px;
            }

            .session-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(130px, 1fr));
                gap: 15px;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            }

            .session-meta-item {
                display: flex;
                align-items: center;
                font-size: 0.9rem;
                color: var(--text-muted);
            }

            .session-meta-item i {
                margin-right: 10px;
                color: var(--primary);
                background: rgba(42, 46, 127, 0.1);
                padding: 8px;
                border-radius: 50%;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .session-card:hover .session-meta-item i {
                background: var(--primary);
                color: var(--text-light);
            }

            .btn-danger {
                background: var(--gradient-danger);
                color: var(--text-light);
                border-radius: 25px;
                padding: 8px 20px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-danger:hover {
                background: #DC2626;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(239, 68, 68, 0.3);
            }

            .popular-tag {
                position: absolute;
                top: 15px;
                right: 15px;
                background: var(--accent);
                color: var(--text-light);
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .no-sessions {
                text-align: center;
                padding: 60px;
                background: var(--card-bg);
                border-radius: 15px;
                box-shadow: var(--shadow);
            }

            .no-sessions i {
                font-size: 3.5rem;
                color: #D1D5DB;
                margin-bottom: 20px;
            }

            .no-sessions h3 {
                font-size: 1.5rem;
                font-weight: 500;
                color: var(--text-dark);
                margin-bottom: 15px;
            }

            .no-sessions p {
                font-size: 1rem;
                color: var(--text-muted);
                margin-bottom: 20px;
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
                box-shadow: 0 5px 15px rgba(42, 46, 127, 0.2);
            }

            /* Message Styles */
            .message-box {
                padding: 15px 25px;
                border-radius: 10px;
                margin-bottom: 30px;
                box-shadow: var(--shadow);
                background: var(--card-bg);
                display: flex;
                align-items: center;
            }

            .message-box i {
                margin-right: 10px;
                font-size: 1.2rem;
            }

            .message-success {
                color: var(--success);
                font-weight: 500;
            }

            .message-error {
                color: var(--danger);
                font-weight: 500;
            }

            /* Animations */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(15px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .fade-in {
                animation: fadeIn 0.5s ease forwards;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-content {
                    padding: 20px;
                }

                .action-bar {
                    flex-direction: column;
                    gap: 15px;
                }

                .action-bar .filter-select {
                    width: 100%;
                }

                .header h1 {
                    font-size: 1.5rem;
                }
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
                <a href="MesInscriptionsController" class="nav-item active">
                    <i class="fas fa-list-check"></i>
                    <span>Mes Inscriptions</span>
                </a>
                <a href="ProfilController" class="nav-item">
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
                <h1>Mes Inscriptions</h1>
                <div class="user-profile">
                    <%
                        String nomClient = user.getNom();
                    %>
                    <img src="https://ui-avatars.com/api/?name=<%= nomClient%>&background=2A2E7F&color=fff" alt="<%= nomClient%>">
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
                <i class="fas fa-check-circle"></i><%= message%>
            </div>
            <%
                }
                if (error != null) {
            %>
            <div class="message-box message-error fade-in">
                <i class="fas fa-exclamation-circle"></i><%= error%>
            </div>
            <%
                }
            %>

            <!-- Action Bar -->
            <div class="action-bar fade-in">
                <select class="filter-select">
                    <option value="all">Toutes les sessions</option>
                    <option value="upcoming">À venir</option>
                    <option value="completed">Terminées</option>
                </select>
                <a href="client.jsp" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>Nouvelle inscription
                </a>
            </div>

            <div class="sessions-container">
                <%
                    List<SessionFormation> sessions = (List<SessionFormation>) request.getAttribute("sessions");
                    if (sessions != null && !sessions.isEmpty()) {
                %>
                <div class="row g-4">
                    <%
                        for (SessionFormation s : sessions) {
                            boolean isPopular = Math.random() > 0.7;
                            boolean isUpcoming = s.getDate().isAfter(LocalDate.now());
                    %>
                    <div class="col-md-6 col-lg-4">
                        <div class="session-card fade-in">
                            <% if (isPopular) { %>
                            <span class="popular-tag">Populaire</span>
                            <% }%>
                            <div class="session-header">
                                <h3 class="session-title"><%= s.getFormation().getTitre()%></h3>
                                <span class="status-badge <%= isUpcoming ? "upcoming" : "completed"%>">
                                    <%= isUpcoming ? "À venir" : "Terminé"%>
                                </span>
                            </div>
                            <span class="session-theme"><%= s.getFormation().getTheme()%></span>
                            <div class="session-meta">
                                <div class="session-meta-item">
                                    <i class="fas fa-calendar-day"></i>
                                    <span><%= s.getDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))%></span>
                                </div>
                                <div class="session-meta-item">
                                    <i class="fas fa-chalkboard-teacher"></i>
                                    <span><%= s.getFormateur()%></span>
                                </div>
                                <div class="session-meta-item">
                                    <i class="fas fa-clock"></i>
                                    <span><%= s.getFormation().getDuree()%> Heures</span>
                                </div>
                                <div class="session-meta-item">
                                    <i class="fas fa-users"></i>
                                    <span><%= (int) (Math.random() * 15) + 5%> participants</span>
                                </div>
                            </div>
                            <% if (isUpcoming) {%>
                            <form action="MesInscriptionsController" method="post">
                                <input type="hidden" name="op" value="cancel">
                                <input type="hidden" name="sessionId" value="<%= s.getId()%>">
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-trash-alt me-2"></i>Annuler
                                </button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                } else {
                %>
                <div class="no-sessions fade-in">
                    <i class="fas fa-calendar-times"></i>
                    <h3>Aucune inscription</h3>
                    <p>Inscrivez-vous à une session pour commencer votre apprentissage.</p>
                    <a href="client.jsp" class="btn btn-primary">
                        <i class="fas fa-calendar-alt me-2"></i>Voir les sessions
                    </a>
                </div>
                <%
                    }
                %>
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    document.addEventListener('DOMContentLoaded', function() {
                    const cards = document.querySelectorAll('.session-card');
                            cards.forEach((card, index) = > {
                            card.style.animationDelay = `${index * 0.1}s`;
                            });
                            // Filtre des sessions
                            const filterSelect = document.querySelector('.filter-select');
                            filterSelect.addEventListener('change', function() {
                            const filterValue = this.value;
                                    const sessionCards = document.querySelectorAll('.session-card');
                                    sessionCards.forEach(card = > {
                                    const status = card.querySelector('.status-badge').classList.contains('upcoming') ? 'upcoming' : 'completed';
                                            if (filterValue === 'all' || filterValue === status) {
                                    card.parentElement.style.display = 'block';
                                    } else {
                                    card.parentElement.style.display = 'none';
                                    }
                                    });
                            });
                    });
        </script>
    </body>
</html>