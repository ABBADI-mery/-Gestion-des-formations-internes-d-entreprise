<%@page import="services.FormationService"%>
<%@page import="entities.FormationInterne"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Gestion des Formations</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
                color: var(--text-light);
                text-decoration: none;
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

            /* Formations Content */
            .form-container {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: var(--card-shadow);
                margin-bottom: 30px;
            }

            fieldset {
                border: 1px solid #eee;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 25px;
            }

            legend {
                font-size: 1.2rem;
                color: var(--primary);
                font-weight: 600;
                padding: 0 10px;
                width: auto;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                font-weight: 500;
                color: #555;
            }

            .form-control {
                border-radius: 6px;
                border: 1px solid #ddd;
                padding: 10px 15px;
            }

            .form-control:focus {
                border-color: var(--primary-light);
                box-shadow: 0 0 0 0.2rem rgba(126, 87, 194, 0.25);
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }

            .table th {
                background-color: var(--primary);
                color: white;
                font-weight: 500;
                padding: 12px 15px;
                text-align: left;
            }

            .table td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            .table tr:nth-child(even) {
                background-color: #fafafa;
            }

            .btn-warning {
                background-color: #FFA000;
                border-color: #FFA000;
                color: white;
            }

            .btn-danger {
                background-color: #E53935;
                border-color: #E53935;
                color: white;
            }

            .alert {
                border-radius: 6px;
                padding: 15px;
                margin-bottom: 20px;
            }
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }
        </style>
    </head>
    <body>
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
                <a href="../users/admin.jsp" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Tableau de bord</span>
                </a>
                <a href="../formations/page.jsp" class="nav-item active">
                    <i class="fas fa-book-open"></i>
                    <span>Formations</span>
                </a>
                <a href="../sessions/page.jsp" class="nav-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions</span>
                </a>
                <a href="${pageContext.request.contextPath}/users/UsersController" class="nav-item ">
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
                    <h1>Gestion des Formations</h1>
                    <p>Créez et gérez les formations disponibles</p>
                </div>

                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin+Mery&background=7E57C2&color=fff" alt="Admin">
                    <span>Admin</span>
                </div>
            </div>

            <div class="form-container">
                <div class="alert alert-success" style="display:none;" id="success-alert">Formation enregistrée avec succès!</div>
                <div class="alert alert-danger" style="display:none;" id="error-alert">Une erreur s'est produite. Veuillez réessayer.</div>

                <fieldset>
                    <legend>Information Formation</legend>
                    <form method="POST" action="../FormationController">
                        <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : ""%>" />
                        <div class="form-group">
                            <label for="titre">Titre :</label>
                            <input type="text" class="form-control" id="titre" name="titre" value="<%= request.getParameter("titre") != null ? request.getParameter("titre") : ""%>" required />
                        </div>
                        <div class="form-group">
                            <label for="theme">Thème :</label>
                            <input type="text" class="form-control" id="theme" name="theme" value="<%= request.getParameter("theme") != null ? request.getParameter("theme") : ""%>" required />
                        </div>
                        <div class="form-group">
                            <label for="duree">Durée (en heures) :</label>
                            <input type="number" class="form-control" id="duree" name="duree" value="<%= request.getParameter("duree") != null ? request.getParameter("duree") : ""%>" required />
                        </div>
                        <button type="submit" class="btn btn-primary">Enregistrer</button>
                    </form>
                </fieldset>

                <fieldset>
                    <legend>Liste des Formations</legend>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Titre</th>
                                <th>Thème</th>
                                <th>Durée</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                FormationService fs = new FormationService();
                                for (FormationInterne f : fs.findAll()) {
                            %>
                            <tr>
                                <td><%= f.getId()%></td>
                                <td><%= f.getTitre()%></td>
                                <td><%= f.getTheme()%></td>
                                <td><%= f.getDuree()%> heures</td>
                                <td>
                                    <a href="../FormationController?id=<%= f.getId()%>&op=update" class="btn btn-warning btn-sm">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="../FormationController?id=<%= f.getId()%>&op=delete" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash-alt"></i> Supprimer
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </fieldset>
            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    // Afficher les messages d'alerte si nécessaire
            <% if (request.getParameter("success") != null) { %>
            document.getElementById('success-alert').style.display = 'block';
                    setTimeout(() = > {
                    document.getElementById('success-alert').style.display = 'none';
                    }, 3000);
            <% } %>

            <% if (request.getParameter("error") != null) { %>
            document.getElementById('error-alert').style.display = 'block';
            <% }%>
        </script>
    </body>
</html>