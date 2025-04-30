<%@page import="services.SessionService"%>
<%@page import="services.FormationService"%>
<%@page import="entities.SessionFormation"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Gestion des Sessions</title>
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

            .search-form {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: var(--card-shadow);
                margin-bottom: 25px;
            }

            .search-form {
                background: white;
                border-radius: 10px;
                padding: 25px;
                box-shadow: var(--card-shadow);
                margin-bottom: 25px;
                border-top: 3px solid var(--primary);
            }

            .search-form .form-label {
                font-weight: 500;
                color: #555;
                margin-bottom: 8px;
            }

            .search-form .input-group-text {
                background-color: var(--primary-light);
                color: white;
                border: none;
            }

            .search-form .form-select,
            .search-form .form-control {
                border: 1px solid #e0e0e0;
                padding: 10px 15px;
                transition: all 0.3s ease;
            }

            .search-form .form-select:focus,
            .search-form .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 0.2rem rgba(126, 87, 194, 0.15);
            }

            .search-form .btn-primary {
                background: linear-gradient(145deg, var(--primary), var(--primary-dark));
                border: none;
                padding: 12px 20px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .search-form .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
                <a href="../formations/page.jsp" class="nav-item">
                    <i class="fas fa-book-open"></i>
                    <span>Formations</span>
                </a>
                <a href="../sessions/page.jsp" class="nav-item active">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions</span>
                </a>
                <a href="../users/page.jsp" class="nav-item">
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
                    <h1>Gestion des Sessions</h1>
                    <p>Planifiez et gérez les sessions de formation</p>
                </div>

                <div class="user-profile">
                    <img src="https://ui-avatars.com/api/?name=Admin+Mery&background=7E57C2&color=fff" alt="Admin">
                    <span>Admin</span>
                </div>
            </div>

            <div class="form-container">
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success" id="success-alert">
                        <c:choose>
                            <c:when test="${param.success == 'create'}">Session créée avec succès!</c:when>
                            <c:when test="${param.success == 'update'}">Session mise à jour avec succès!</c:when>
                            <c:when test="${param.success == 'delete'}">Session supprimée avec succès!</c:when>
                        </c:choose>
                    </div>
                </c:if>
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger" id="error-alert">Une erreur s'est produite. Veuillez réessayer.</div>
                </c:if>

                <!-- Search Form - Improved Design -->
                <div class="search-form">
                    <form action="SessionFormationController" method="get" class="row g-3 align-items-center">
                        <input type="hidden" name="op" value="search">
                        <div class="col-md-3">
                            <label for="searchType" class="form-label">Critère de recherche</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-filter"></i></span>
                                <select name="searchType" id="searchType" class="form-select">
                                    <option value="theme">Par Thème</option>
                                    <option value="date">Par Date</option>
                                    <option value="formateur">Par Formateur</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="searchValue" class="form-label">Valeur</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-search"></i></span>
                                <input type="text" id="searchValue" name="searchValue" class="form-control" placeholder="Entrez votre recherche...">
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">&nbsp;</label>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="fas fa-search me-2"></i> Rechercher
                            </button>
                        </div>
                    </form>
                </div>

                <fieldset>
                    <legend>${param.id == null ? 'Ajouter' : 'Modifier'} une Session</legend>
                    <form action="SessionFormationController" method="post">
                        <input type="hidden" name="id" value="${param.id}">

                        <div class="form-group">
                            <label for="formationId">Formation</label>
                            <select class="form-control" id="formationId" name="formationId" required>
                                <option value="">Sélectionnez une formation</option>
                                <c:forEach var="formation" items="${formations}">
                                    <option value="${formation.id}" ${formation.id == sessionToUpdate.formation.id ? 'selected' : ''}>
                                        ${formation.titre} (${formation.theme})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="date">Date</label>
                            <input type="date" class="form-control" id="date" name="date" 
                                   value="${sessionToUpdate.date}" required>
                        </div>

                        <div class="form-group">
                            <label for="formateur">Formateur</label>
                            <input type="text" class="form-control" id="formateur" name="formateur" 
                                   value="${sessionToUpdate.formateur}" required>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${param.id == null ? 'Ajouter' : 'Mettre à jour'}
                        </button>
                        <a href="page.jsp" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Annuler
                        </a>
                    </form>
                </fieldset>

                <fieldset>
                    <legend>Liste des Sessions</legend>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Formation</th>
                                <th>Thème</th>
                                <th>Date</th>
                                <th>Formateur</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                SessionService ss = new SessionService();
                                List<SessionFormation> sessions = (request.getAttribute("sessions") != null)
                                        ? (List<SessionFormation>) request.getAttribute("sessions")
                                        : ss.findAll();
                                for (SessionFormation s : sessions) {

                            %>
                            <tr>
                                <td><%= s.getId()%></td>
                                <td><%= s.getFormation().getTitre()%></td>
                                <td><%= s.getFormation().getTheme()%></td>
                                <td>
                                    <%
                                        java.time.LocalDate date = s.getDate();
                                        String dateStr = (date != null) ? date.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "N/A";
                                        out.print(dateStr);
                                    %>
                                </td>
                                <td><%= s.getFormateur()%></td>
                                <td>
                                    <a href="SessionFormationController?op=update&id=<%= s.getId()%>" 
                                       class="btn btn-warning btn-sm">
                                        <i class="fas fa-edit"></i> Modifier
                                    </a>
                                    <a href="SessionFormationController?op=delete&id=<%= s.getId()%>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette session?')">
                                        <i class="fas fa-trash-alt"></i> Supprimer
                                    </a>
                                </td>
                            </tr>
                            <%
                                } 
                            %>
                        </tbody>
                    </table>
                </fieldset>

            </div>
        </div>

        <!-- Bootstrap JS Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                   // Afficher les messages d'alerte si nécessaire
                                                   if (document.getElementById('success-alert')) {
                                           setTimeout(() = > {
                                           document.getElementById('success-alert').style.display = 'none';
                                           }, 3000);
                                           }
        </script>
    </body>
</html>