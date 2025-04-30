<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MeryAcademi | Sessions Disponibles</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            font-family: 'Poppins', sans-serif;
        }

        .sidebar {
            background: linear-gradient(145deg, var(--primary-dark), var(--primary));
            color: white;
        }

        .session-card {
            transition: all 0.3s ease;
            border-radius: 8px;
            overflow: hidden;
            border: none;
            box-shadow: var(--card-shadow);
        }

        .session-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .session-theme {
            color: var(--primary);
            font-weight: 600;
        }

        .btn-inscription {
            background: var(--primary);
            color: white;
            border-radius: 20px;
            padding: 8px 20px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-inscription:hover {
            background: var(--primary-dark);
            color: white;
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar vh-100 position-fixed" style="width: 280px;">
            <div class="brand p-4 text-center">
                <div class="brand-logo">
                    <i class="fas fa-graduation-cap"></i>
                    <span>MeryAcademi</span>
                </div>
                <div class="brand-tagline small">Plateforme d'éducation digitale</div>
            </div>

            <nav class="nav-menu">
                <a href="ClientController" class="nav-item active">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Sessions</span>
                </a>
                <a href="ClientController?op=mesSessions" class="nav-item">
                    <i class="fas fa-list-check"></i>
                    <span>Mes Inscriptions</span>
                </a>
                <a href="../logout" class="nav-item">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content flex-grow-1" style="margin-left: 280px; padding: 30px;">
            <div class="header d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h1 class="h2 mb-1">Sessions Disponibles</h1>
                    <p class="text-muted mb-0">Inscrivez-vous aux prochaines sessions de formation</p>
                </div>
                <div class="user-profile bg-white p-2 rounded-pill shadow-sm">
                    <img src="https://ui-avatars.com/api/?name=${sessionScope.client.nom}+${sessionScope.client.prenom}&background=7E57C2&color=fff" 
                         alt="Profile" class="rounded-circle me-2" width="40">
                    <span>${sessionScope.client.prenom}</span>
                </div>
            </div>

            <!-- Messages d'alerte -->
            <c:if test="${not empty param.success}">
                <div class="alert alert-success alert-dismissible fade show">
                    <c:choose>
                        <c:when test="${param.success == 'inscrit'}">
                            <i class="fas fa-check-circle me-2"></i> Inscription confirmée!
                        </c:when>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Liste des sessions -->
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach items="${sessions}" var="session">
                    <div class="col">
                        <div class="card h-100 session-card">
                            <div class="card-body">
                                <span class="badge bg-primary-light text-primary mb-2">
                                    <fmt:formatDate value="${session.date}" pattern="dd MMM yyyy"/>
                                </span>
                                <h3 class="h5 session-theme">${session.formation.theme}</h3>
                                <h4 class="h6 mb-3">${session.formation.titre}</h4>
                                
                                <div class="d-flex align-items-center mb-3">
                                    <i class="fas fa-user-tie me-2 text-muted"></i>
                                    <span>${session.formateur}</span>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted small">
                                        <i class="fas fa-users me-1"></i>
                                        ${session.participations.size()} inscrits
                                    </span>
                                    <a href="ClientController?op=inscrire&id=${session.id}" 
                                       class="btn-inscription btn-sm">
                                        <i class="fas fa-user-plus me-1"></i> S'inscrire
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-dismiss alerts after 5 seconds
        setTimeout(() => {
            document.querySelectorAll('.alert').forEach(alert => {
                new bootstrap.Alert(alert).close();
            });
        }, 5000);
    </script>
</body>
</html>