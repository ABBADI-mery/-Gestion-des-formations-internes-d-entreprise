<%@page import="entities.Admin"%>
<%@page import="entities.User"%>
<%@page import="services.ClientService"%>
<%@page import="services.SessionService"%>
<%@page import="entities.Client"%>
<%@page import="entities.SessionFormation"%>
<%@page import="entities.Participation"%>
<%@page import="dao.ClientDao"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Gestion des Utilisateurs</title>
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

            /* Content */
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

            .alert {
                border-radius: 6px;
                padding: 15px;
                margin-bottom: 20px;
            }

            /* Modal Styles */
            .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: var(--card-shadow);
            }

            .modal-header {
                background-color: var(--primary);
                color: var(--text-light);
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
            }

            .modal-title {
                font-weight: 600;
            }

            .modal-body {
                padding: 20px;
            }

            .form-label {
                font-weight: 500;
                color: var(--text-dark);
            }

            .form-control {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 10px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            .form-control:focus {
                border-color: var(--primary);
                box-shadow: 0 0 8px rgba(126, 87, 194, 0.2);
                outline: none;
            }

            .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
                border-color: var(--primary-dark);
            }

            .btn-secondary {
                border-radius: 8px;
                padding: 10px 20px;
                font-weight: 500;
            }

            .modal-footer {
                border-top: none;
                padding: 15px 20px;
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
                <a href="../users/admin.jsp" class="nav-item">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Tableau de bord</span>
                </a>
                <a href="../formations/page.jsp" class="nav-item">
                    <i class="fas fa-book-open"></i>
                    <span>Formations</span>
                </a>
                <a href="../sessions/page.jsp" class="nav-item">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions</span>
                </a>
                <a href="../users/participants.jsp" class="nav-item active">
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
                    <h1>Gestion des Utilisateurs</h1>
                    <p>Voir les clients et leurs sessions</p>
                </div>

                <div class="user-profile">
                    <%
                        String nomAdmin = admin.getNom();
                    %>
                    <img src="https://ui-avatars.com/api/?name=<%= nomAdmin%>&background=7E57C2&color=fff" alt="<%= nomAdmin%>">
                    <span><%= nomAdmin%></span>
                </div>
            </div>

            <!-- Messages de retour -->
            <c:if test="${param.success == 'deleted'}">
                <div class="alert alert-success">
                    Client supprimé avec succès.
                </div>
            </c:if>
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success">
                    Client modifié avec succès.
                </div>
            </c:if>
            <c:if test="${param.error == 'client_not_found'}">
                <div class="alert alert-danger">
                    Client non trouvé.
                </div>
            </c:if>
            <c:if test="${param.error == 'invalid_id'}">
                <div class="alert alert-danger">
                    ID client invalide.
                </div>
            </c:if>
            <c:if test="${param.error == 'server_error'}">
                <div class="alert alert-danger">
                    Une erreur s'est produite. Veuillez réessayer.
                </div>
            </c:if>
            <c:if test="${param.error == 'invalid_operation'}">
                <div class="alert alert-danger">
                    Opération non valide.
                </div>
            </c:if>

            <fieldset>
                <legend>Liste des Clients et leurs Formations</legend>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID Client</th>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Formation</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ClientService cs = new ClientService();
                            List<Client> clients = (request.getAttribute("clients") != null)
                                    ? (List<Client>) request.getAttribute("clients")
                                    : cs.findAllWithSessions();

                            for (Client client : clients) {
                                boolean hasParticipations = client.getParticipations() != null && !client.getParticipations().isEmpty();

                                if (hasParticipations) {
                                    for (Participation participation : client.getParticipations()) {
                                        SessionFormation s = participation.getSessionFormation();
                                        String formationTitre = (s != null && s.getFormation() != null)
                                                ? s.getFormation().getTitre() : "N/A";
                        %>
                        <tr>
                            <td><%= client.getId()%></td>
                            <td><%= client.getNom()%></td>
                            <td><%= client.getEmail()%></td>
                            <td><%= formationTitre%></td>
                            <td>
                                <%
                                    if (s != null) {
                                        java.time.LocalDate date = s.getDate();
                                        String dateStr = (date != null)
                                                ? date.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"))
                                                : "N/A";
                                        out.print(dateStr);
                                    } else {
                                        out.print("N/A");
                                    }
                                %>
                            </td>
                            <td>
                                <button type="button" class="btn btn-warning btn-sm" 
                                        data-bs-toggle="modal" data-bs-target="#editClientModal"
                                        onclick="populateModal(<%= client.getId()%>, '<%= client.getNom()%>', '<%= client.getEmail()%>')">
                                    <i class="fas fa-edit"></i> Modifier
                                </button>
                                <a href="${pageContext.request.contextPath}/ClientController?op=delete&id=<%= client.getId()%>" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client ?')">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td><%= client.getId()%></td>
                            <td><%= client.getNom()%></td>
                            <td><%= client.getEmail()%></td>
                            <td colspan="2">Aucune session associée</td>
                            <td>
                                <button type="button" class="btn btn-warning btn-sm" 
                                        data-bs-toggle="modal" data-bs-target="#editClientModal"
                                        onclick="populateModal(<%= client.getId()%>, '<%= client.getNom()%>', '<%= client.getEmail()%>')">
                                    <i class="fas fa-edit"></i> Modifier
                                </button>
                                <a href="${pageContext.request.contextPath}/ClientController?op=delete&id=<%= client.getId()%>" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client ?')">
                                    <i class="fas fa-trash-alt"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </fieldset>

            <!-- Modal pour modifier un client -->
            <div class="modal fade" id="editClientModal" tabindex="-1" aria-labelledby="editClientModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editClientModalLabel">Modifier Client</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="${pageContext.request.contextPath}/ClientController" method="post">
                            <div class="modal-body">
                                <input type="hidden" name="op" value="saveUpdate">
                                <input type="hidden" name="id" id="modalClientId">
                                <div class="mb-3">
                                    <label for="modalClientNom" class="form-label">Nom</label>
                                    <input type="text" class="form-control" id="modalClientNom" name="nom" required>
                                </div>
                                <div class="mb-3">
                                    <label for="modalClientEmail" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="modalClientEmail" name="email" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                                <button type="submit" class="btn btn-primary">Enregistrer</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Bootstrap JS Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                                       function populateModal(id, nom, email) {
                                           document.getElementById('modalClientId').value = id;
                                           document.getElementById('modalClientNom').value = nom;
                                           document.getElementById('modalClientEmail').value = email;
                                       }
            </script>
        </div>
    </body>
</html>