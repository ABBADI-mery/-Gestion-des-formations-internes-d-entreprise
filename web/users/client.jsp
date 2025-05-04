<%@page import="services.SessionService"%>
<%@page import="entities.FormationInterne"%>
<%@page import="entities.SessionFormation"%>
<%@page import="java.util.List"%>
<%@page import="entities.Client"%>
<%@page import="entities.User"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Espace Client</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            }

            body {
                background-color: var(--bg-light);
                font-family: 'Poppins', sans-serif;
                display: flex;
                min-height: 100vh;
                color: var(--text-dark);
            }

            /* Sidebar */
            .sidebar {
                width: 72px;
                background: var(--primary);
                height: 100vh;
                position: fixed;
                transition: var(--transition);
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 24px 0;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
                z-index: 1000;
            }

            .sidebar:hover {
                width: 260px;
            }

            .brand {
                margin-bottom: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
            }

            .brand-logo i {
                font-size: 2rem;
                color: var(--accent);
            }

            .brand-logo span {
                display: none;
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-light);
                margin-left: 12px;
            }

            .sidebar:hover .brand-logo span {
                display: inline;
            }

            .nav-menu {
                flex: 1;
                width: 100%;
                display: flex;
                flex-direction: column;
            }

            .nav-item {
                display: flex;
                align-items: center;
                padding: 16px 24px;
                color: var(--text-light);
                text-decoration: none;
                transition: var(--transition);
            }

            .nav-item i {
                font-size: 1.5rem;
                width: 24px;
                text-align: center;
                color: var(--accent);
            }

            .nav-item span {
                display: none;
                font-size: 0.95rem;
                font-weight: 500;
                margin-left: 16px;
            }

            .sidebar:hover .nav-item span {
                display: inline;
            }

            .nav-item:hover, .nav-item.active {
                background: rgba(126, 87, 194, 0.1);
                color: var(--accent);
            }

            /* Main Content */
            .main-content {
                margin-left: 72px;
                flex: 1;
                padding: 40px;
                transition: var(--transition);
                max-width: 1400px;
                margin-left: auto;
                margin-right: auto;
            }

            .sidebar:hover ~ .main-content {
                margin-left: 260px;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 32px;
            }

            .header h1 {
                font-size: 1.75rem;
                font-weight: 600;
                color: var(--text-dark);
            }

            .user-profile {
                display: flex;
                align-items: center;
                background: var(--card-bg);
                padding: 8px 16px;
                border-radius: 9999px;
                box-shadow: var(--card-shadow);
                transition: var(--transition);
            }

            .user-profile:hover {
                transform: scale(1.05);
            }

            .user-profile img {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                margin-right: 12px;
                border: 2px solid var(--primary-light);
            }

            .user-profile span {
                font-size: 0.95rem;
                font-weight: 500;
            }

            /* Search Box */
            .search-box {
                max-width: 600px;
                margin: 0 auto 48px;
                padding: 24px;
                background: var(--card-bg);
                border-radius: 16px;
                box-shadow: var(--card-shadow);
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 16px;
            }

            .search-box:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            }

            .form-select, .form-control {
                border-radius: 12px;
                border: 1px solid #E2E8F0;
                padding: 12px;
                font-size: 0.95rem;
                transition: var(--transition);
                width: 120px;
            }

            .form-control {
                flex-grow: 1;
                background: #EDF2F7;
                border: none;
            }

            .form-select:focus, .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(126, 87, 194, 0.1);
            }

            .btn-search {
                background: var(--primary);
                color: var(--text-light);
                border-radius: 12px;
                padding: 12px 24px;
                font-weight: 500;
                font-size: 0.95rem;
                transition: var(--transition);
                white-space: nowrap;
            }

            .btn-search:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(126, 87, 194, 0.3);
            }

            /* Containers */
            .formations-container, .sessions-container {
                max-width: 100%;
            }

            .formation-card, .session-card {
                background: var(--card-bg);
                border-radius: 16px;
                padding: 32px;
                box-shadow: var(--card-shadow);
                transition: var(--transition);
                position: relative;
                margin-bottom: 24px;
            }

            .formation-card:hover, .session-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.12);
            }

            .formation-title, .session-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-dark);
                margin-bottom: 12px;
            }

            .session-number {
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--primary);
                background: rgba(126, 87, 194, 0.1);
                padding: 4px 12px;
                border-radius: 9999px;
                display: inline-block;
                margin-bottom: 8px;
            }

            .formation-theme, .session-theme {
                font-size: 0.9rem;
                font-weight: 500;
                color: var(--primary);
                background: rgba(126, 87, 194, 0.1);
                padding: 6px 16px;
                border-radius: 9999px;
                display: inline-block;
                margin-bottom: 16px;
            }

            .formation-meta, .session-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 16px;
                margin-bottom: 24px;
            }

            .formation-meta-item, .session-meta-item {
                display: flex;
                align-items: center;
                font-size: 0.9rem;
                color: var(--text-dark);
            }

            .formation-meta-item i, .session-meta-item i {
                margin-right: 8px;
                color: var(--primary);
                font-size: 1.1rem;
            }

            .btn-primary {
                background: var(--primary);
                color: var(--text-light);
                border-radius: 9999px;
                padding: 10px 24px;
                font-size: 0.95rem;
                font-weight: 500;
                border: none;
                transition: var(--transition);
            }

            .btn-primary:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(126, 87, 194, 0.3);
            }

            .no-items {
                text-align: center;
                padding: 48px;
                background: var(--card-bg);
                border-radius: 16px;
                box-shadow: var(--card-shadow);
                margin-top: 24px;
            }

            .no-items i {
                font-size: 2.5rem;
                color: var(--text-dark);
                margin-bottom: 16px;
            }

            .no-items h3 {
                font-size: 1.25rem;
                font-weight: 500;
                margin-bottom: 8px;
            }

            .no-items p {
                font-size: 0.95rem;
                color: var(--text-dark);
                margin-bottom: 24px;
            }

            .btn-alert {
                background: var(--primary);
                color: var(--text-light);
                border-radius: 9999px;
                padding: 12px 24px;
                font-size: 0.95rem;
                font-weight: 500;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
            }

            .btn-alert:hover {
                background: var(--primary-dark);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(126, 87, 194, 0.3);
            }

            .btn-alert i {
                margin-right: 8px;
            }

            /* Message Styles */
            .message-box {
                padding: 16px;
                border-radius: 12px;
                margin-bottom: 24px;
                display: flex;
                align-items: center;
                font-size: 0.95rem;
                font-weight: 500;
                box-shadow: var(--card-shadow);
            }

            .message-success {
                background: rgba(16, 185, 129, 0.1);
                color: #10B981;
            }

            .message-error {
                background: rgba(239, 68, 68, 0.1);
                color: #EF4444;
            }

            .message-box i {
                margin-right: 12px;
                font-size: 1.25rem;
            }

            /* Back Button */
            .btn-back {
                background: transparent;
                color: var(--primary);
                border: 1px solid var(--primary);
                border-radius: 9999px;
                padding: 10px 24px;
                font-size: 0.95rem;
                font-weight: 500;
                transition: var(--transition);
                margin-bottom: 24px;
                display: inline-flex;
                align-items: center;
            }

            .btn-back:hover {
                background: var(--primary);
                color: var(--text-light);
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(126, 87, 194, 0.3);
            }

            .btn-back i {
                margin-right: 8px;
            }

            /* Animations */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(16px); }
                to { opacity: 1; transform: translateY(0); }
            }

            .fade-in {
                animation: fadeIn 0.5s ease forwards;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    width: 60px;
                }

                .sidebar:hover {
                    width: 220px;
                }

                .main-content {
                    margin-left: 60px;
                    padding: 24px;
                }

                .sidebar:hover ~ .main-content {
                    margin-left: 220px;
                }

                .header h1 {
                    font-size: 1.5rem;
                }

                .search-box {
                    flex-direction: column;
                    padding: 16px;
                    gap: 12px;
                }

                .form-select, .form-control {
                    width: 100%;
                }

                .btn-search {
                    width: 100%;
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
                <a href="ClientSessionController" class="nav-item active">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Formations & Sessions</span>
                </a>
                <a href="MesInscriptionsController" class="nav-item">
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
                <%
                    if ("sessions".equals(request.getAttribute("view"))) {
                        FormationInterne selectedFormation = (FormationInterne) request.getAttribute("selectedFormation");
                        if (selectedFormation != null) {
                %>
                <h1>Les sessions de formation <%= selectedFormation.getTitre() %></h1>
                <%
                        }
                    } else {
                %>
                <h1>Explorez Nos Formations</h1>
                <%
                    }
                %>
                <div class="user-profile">
                    <%
                        String nomClient = user.getNom();
                    %>
                    <img src="https://ui-avatars.com/api/?name=<%= nomClient%>&background=7E57C2&color=fff" alt="<%= nomClient%>">
                    <span><%= nomClient.substring(0, Math.min(nomClient.length(), 8))%>...</span>
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

            <!-- Formulaire de recherche (visible uniquement dans la vue formations) -->
            <%
                if (!"sessions".equals(request.getAttribute("view"))) {
            %>
            <div class="search-box fade-in">
                <form action="ClientSessionController" method="get">
                    <div class="row g-2 align-items-center">
                        <div class="col-auto">
                            <select name="searchType" class="form-select">
                                <option value="theme">Par thème</option>
                                <option value="titre">Par titre</option>
                            </select>
                        </div>
                        <div class="col">
                            <input type="text" name="searchValue" class="form-control" placeholder="Rechercher...">
                        </div>
                        <div class="col-auto">
                            <button type="submit" name="op" value="search" class="btn btn-search">
                                <i class="fas fa-search me-2"></i>Rechercher
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <%
                }
            %>

            <%
                if ("sessions".equals(request.getAttribute("view"))) {
                    FormationInterne selectedFormation = (FormationInterne) request.getAttribute("selectedFormation");
                    if (selectedFormation != null) {
            %>
            <!-- Bouton Retour -->
            <a href="ClientSessionController" class="btn-back fade-in">
                <i class="fas fa-arrow-left"></i>Retour aux formations
            </a>
            <%
                    }
            %>
            <div class="sessions-container">
                <%
                    List<SessionFormation> sessions = (List<SessionFormation>) request.getAttribute("sessions");
                    if (sessions != null && !sessions.isEmpty()) {
                        int sessionCounter = 1;
                %>
                <div class="row g-4">
                    <%
                        for (SessionFormation s : sessions) {
                            boolean isPopular = Math.random() > 0.7;
                    %>
                    <div class="col-md-6 col-lg-4">
                        <div class="session-card fade-in">
                            <% if (isPopular) { %>
                            <span class="popular-tag">Populaire</span>
                            <% } %>
                            <span class="session-number">Session <%= sessionCounter %></span>
                            <h3 class="session-title"><%= s.getFormation().getTitre()%></h3>
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
                                    <i class="fas fa-users"></i>
                                    <span><%= (int) (Math.random() * 15) + 5%> participants</span>
                                </div>
                            </div>
                            <form action="ClientSessionController" method="post">
                                <input type="hidden" name="op" value="register">
                                <input type="hidden" name="sessionId" value="<%= s.getId()%>">
                                <input type="hidden" name="formationId" value="<%= s.getFormation().getId()%>">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-pen-to-square me-2"></i>S'inscrire
                                </button>
                            </form>
                        </div>
                    </div>
                    <%
                            sessionCounter++;
                        }
                    %>
                </div>
                <%
                    } else {
                %>
                <div class="no-items fade-in">
                    <i class="fas fa-calendar-times"></i>
                    <h3>Aucune session disponible</h3>
                    <p>Revenez bientôt pour découvrir de nouvelles sessions de formation.</p>
                    <a href="#" class="btn btn-primary">
                        <i class="fas fa-bell me-2"></i>M'alerter
                    </a>
                </div>
                <%
                    }
                %>
            </div>
            <%
                } else {
            %>
            <div class="formations-container">
                <%
                    List<FormationInterne> formations = (List<FormationInterne>) request.getAttribute("formations");
                    if (formations != null && !formations.isEmpty()) {
                %>
                <div class="row g-4">
                    <%
                        for (FormationInterne f : formations) {
                            boolean isPopular = Math.random() > 0.7;
                    %>
                    <div class="col-md-6 col-lg-4">
                        <div class="formation-card fade-in">
                            <% if (isPopular) { %>
                            <span class="popular-tag">Populaire</span>
                            <% } %>
                            <h3 class="formation-title"><%= f.getTitre()%></h3>
                            <span class="formation-theme"><%= f.getTheme()%></span>
                            <div class="formation-meta">
                                <div class="formation-meta-item">
                                    <i class="fas fa-clock"></i>
                                    <span><%= f.getDuree()%> Heures</span>
                                </div>
                                <div class="formation-meta-item">
                                    <i class="fas fa-book"></i>
                                    <span><%= f.getSessions() != null ? f.getSessions().size() : 0%> Sessions</span>
                                </div>
                            </div>
                            <form action="ClientSessionController" method="get">
                                <input type="hidden" name="op" value="viewSessions">
                                <input type="hidden" name="formationId" value="<%= f.getId()%>">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-eye me-2"></i>Voir les sessions
                                </button>
                            </form>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                    } else {
                %>
                <div class="no-items fade-in">
                    <i class="fas fa-book-open"></i>
                    <h3>Aucune formation disponible</h3>
                    <p>Revenez bientôt pour découvrir de nouvelles formations.</p>
                    <a href="#" class="btn-alert">
                        <i class="fas fa-bell"></i>M'alerter
                    </a>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const cards = document.querySelectorAll('.formation-card, .session-card');
                cards.forEach((card, index) => {
                    card.style.animationDelay = `${index * 0.1}s`;
                });
            });
        </script>
    </body>
</html>