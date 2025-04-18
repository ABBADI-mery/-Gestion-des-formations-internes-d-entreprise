<%@page import="services.FormationService"%>
<%@page import="entities.FormationInterne"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Formations</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9aIt2Lq7V++lGS2X5kzZG1qEfrgLZ7N1Fv7JhtEXREs8IoxFj6gXj4z8A0v8xdpz" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 20px; /* Réduire le padding global */
        }
        .form-container {
            max-width: 1000px; /* Agrandir la largeur maximale du conteneur */
            margin: 0 auto;
        }
        fieldset {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px; /* Réduire le padding du fieldset */
            margin-bottom: 20px; /* Réduire la marge inférieure */
            background-color: #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
        }
        legend {
            font-size: 1.1rem; /* Réduire la taille de la légende */
            color: #007bff;
            font-weight: bold;
            width: auto;
            padding: 0 8px; /* Réduire le padding de la légende */
            border-bottom: none;
            margin-bottom: 10px; /* Réduire la marge inférieure de la légende */
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 10px; /* Réduire la marge inférieure des groupes de formulaire */
        }
        .form-group label {
            font-weight: bold;
            color: #495057;
            width: 140px; /* Réduire la largeur du label */
            margin-right: 8px; /* Réduire la marge à droite du label */
            font-size: 0.9rem; /* Réduire la taille de la police du label */
        }
        .form-control {
            border-radius: 5px;
            border: 1px solid #ced4da;
            padding: 0.5rem 0.75rem; /* Réduire le padding de l'input */
            flex-grow: 1;
            height: 20px; /* Réduire la hauteur de l'input */
            width: 40px;
            font-size: 0.9rem; /* Réduire la taille de la police de l'input */
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            border-radius: 5px;
            padding: 0.5rem 1rem; /* Réduire le padding du bouton */
            transition: background-color 0.15s ease-in-out, border-color 0.15s ease-in-out;
            margin-top: 10px; /* Réduire la marge du bouton */
            font-size: 0.9rem; /* Réduire la taille de la police du bouton */
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .table {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
            width: 100%; /* Le tableau prend toute la largeur disponible */
        }
        .table th {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 0.75rem; /* Réduire le padding des headers */
            border-bottom: 2px solid #495057;
            font-size: 0.9rem; /* Réduire la taille de la police des headers */
        }
        .table td {
            text-align: center;
            padding: 0.5rem; /* Réduire le padding des cellules */
            border-bottom: 1px solid #dee2e6;
            font-size: 0.9rem; /* Réduire la taille de la police des cellules */
        }
        .table tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        .btn-warning, .btn-danger {
            border-radius: 5px;
            padding: 0.3rem 0.6rem; /* Réduire le padding des boutons d'action */
            color: white;
            border: none;
            transition: opacity 0.15s ease-in-out;
            text-decoration: none !important;
            font-size: 0.8rem; /* Réduire la taille de la police des boutons d'action */
        }
        .btn-warning {
            background-color: #ffc107;
        }
        .btn-warning:hover {
            opacity: 0.85;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            opacity: 0.85;
        }
        .alert {
            border-radius: 5px;
            margin-top: 15px; /* Réduire la marge du haut des alertes */
            padding: 0.75rem 1rem; /* Réduire le padding des alertes */
            font-size: 0.9rem; /* Réduire la taille de la police des alertes */
        }
        .alert-success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <div class="alert alert-success" style="display:none;" id="success-alert">Formation enregistrée avec succès!</div>
        <div class="alert alert-danger" style="display:none;" id="error-alert">Une erreur s'est produite. Veuillez réessayer.</div>

        <fieldset>
            <legend>Information Formation</legend>
            <form method="POST" action="../FormationController">
                <input type="hidden" name="id" value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>" />
                <div class="form-group">
                    <label for="titre">Titre :</label>
                    <input type="text" class="form-control" id="titre" name="titre" value="<%= request.getParameter("titre") != null ? request.getParameter("titre") : "" %>" required />
                </div>
                <div class="form-group">
                    <label for="theme">Thème :</label>
                    <input type="text" class="form-control" id="theme" name="theme" value="<%= request.getParameter("theme") != null ? request.getParameter("theme") : "" %>" required />
                </div>
                <div class="form-group">
                    <label for="duree">Durée (en heures) :</label>
                    <input type="number" class="form-control" id="duree" name="duree" value="<%= request.getParameter("duree") != null ? request.getParameter("duree") : "" %>" required />
                </div>
                <button type="submit" class="btn btn-primary">Enregistrer</button>
            </form>
        </fieldset>

        <fieldset>
            <legend>Liste des Formations</legend>
            <table class="table table-bordered table-striped">
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
                        for(FormationInterne f : fs.findAll()) {
                    %>
                    <tr>
                        <td><%= f.getId() %></td>
                        <td><%= f.getTitre() %></td>
                        <td><%= f.getTheme() %></td>
                        <td><%= f.getDuree() %></td>
                        <td>
                            <a href="../FormationController?id=<%= f.getId() %>&op=update" class="btn btn-warning">Modifier</a>
                            <a href="../FormationController?id=<%= f.getId() %>&op=delete" class="btn btn-danger">Supprimer</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </fieldset>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4%2F1p%2F4wFq8pzVAiR6p4vFbm91rxhPTz3oxsM" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0gGVO1JFq0tSInHLqJfpeQ%2F9J3w3hGb8o06g0St52jRMTb69" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-XMknnqff3OMtmMN8dB%2F0z2aEmTb0Ws9DjeMCq2uAW%2F%2Fni9%2FSmX1LvF%2FISDtm7B" crossorigin="anonymous"></script>
</body>
</html>