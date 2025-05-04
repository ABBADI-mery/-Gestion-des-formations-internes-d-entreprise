<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MeryAcademi | Accueil</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #7E57C2;
                --primary-light: #B39DDB;
                --primary-dark: #5E35B1;
                --accent: #FF9800;
                --text-dark: #212121;
                --text-light: #FFFFFF;
                --bg-light: #F9F9F9;
                --card-bg: #FFFFFF;
                --card-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
                line-height: 1.6;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Header */
            .header {
                background: #FFFFFF;
                padding: 10px 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--primary);
            }

            .nav-link {
                color: var(--text-dark) !important;
                font-weight: 500;
                margin-left: 15px;
            }

            .nav-link:hover {
                color: var(--primary) !important;
            }

            /* Banner */
            .banner {
                background: #FFFFFF;
                padding: 40px 20px;
                text-align: left;
                position: relative;
                overflow: hidden;
            }

            .banner-content {
                max-width: 600px;
            }

            .banner h1 {
                font-size: 3rem;
                font-weight: 700;
                color: var(--primary-dark);
                margin-bottom: 20px;
            }

            .banner p {
                font-size: 1.1rem;
                color: #757575;
                margin-bottom: 30px;
            }

            .banner .btn {
                padding: 10px 20px;
                font-weight: 500;
                border-radius: 5px;
            }

            .banner .btn-primary {
                background-color: var(--primary);
                border-color: var(--primary);
            }

            .banner .btn-outline-primary {
                color: var(--primary);
                border-color: var(--primary);
                background-color: transparent;
            }

            .banner .btn:hover {
                opacity: 0.9;
            }

            .banner-img {
                position: absolute;
                right: 20px;
                top: 0;
                bottom: 0;
                width: 300px;
                background: url('${pageContext.request.contextPath}/imgs/your-image.jpg') no-repeat center;
                background-size: contain;
                clip-path: circle(50% at 50% 50%);
            }

            /* Collaboration Section */
            .collaboration {
                background: var(--bg-light);
                padding: 20px;
                text-align: center;
                margin-bottom: 20px;
            }

            .collaboration p {
                font-size: 1.1rem;
                color: #757575;
                margin-bottom: 15px;
            }

            .collaboration .logo-row {
                display: flex;
                justify-content: center;
                gap: 20px;
                flex-wrap: wrap;
            }

            .collaboration img {
                height: 40px;
                filter: grayscale(100%);
                transition: filter 0.3s;
            }

            .collaboration img:hover {
                filter: grayscale(0);
            }

            /* Carousel Section */
            .carousel-section {
                padding: 20px;
                background: var(--card-bg);
                border-radius: 8px;
                box-shadow: var(--card-shadow);
                margin-bottom: 20px;
            }

            .carousel-section h2 {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--primary-dark);
                margin-bottom: 20px;
            }

            .carousel-inner .carousel-item {
                display: flex;
                justify-content: center;
                gap: 20px;
            }

            .carousel-card {
                background: var(--card-bg);
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                padding: 20px;
                text-align: center;
                min-width: 250px;
                box-shadow: var(--card-shadow);
                transition: transform 0.3s;
            }

            .carousel-card:hover {
                transform: translateY(-5px);
            }

            .carousel-card img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 15px;
                object-fit: cover;
            }

            .carousel-card h4 {
                font-size: 1.1rem;
                font-weight: 600;
                color: var(--primary-dark);
                margin-bottom: 10px;
            }

            .carousel-card p {
                font-size: 0.9rem;
                color: #757575;
            }

            .carousel-card .btn {
                background-color: var(--primary);
                color: var(--text-light);
                padding: 5px 10px;
                font-size: 0.9rem;
                border-radius: 5px;
            }

            /* Certificates Section */
            .certificates-section {
                padding: 20px;
                background: var(--card-bg);
                border-radius: 8px;
                box-shadow: var(--card-shadow);
                margin-bottom: 20px;
            }

            .certificates-section h2 {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--primary-dark);
                margin-bottom: 20px;
            }

            .certificate-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
            }

            .certificate-card {
                background: var(--card-bg);
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                padding: 15px;
                text-align: center;
                box-shadow: var(--card-shadow);
            }

            .certificate-card img {
                width: 100%;
                height: 150px;
                object-fit: cover;
                border-radius: 5px;
                margin-bottom: 10px;
            }

            .certificate-card p {
                font-size: 0.9rem;
                color: #757575;
            }

            /* Footer */
            .footer {
                background: var(--primary-dark);
                color: var(--text-light);
                padding: 20px;
                text-align: center;
                margin-top: auto;
            }

            .footer a {
                color: var(--accent);
                text-decoration: none;
                margin: 0 10px;
            }

            .footer a:hover {
                text-decoration: underline;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            .carousel-inner {
                padding: 1em;
            }

            .carousel-inner .row {
                display: flex;
                flex-wrap: nowrap;
                overflow-x: auto;
                scroll-behavior: smooth;
                -webkit-overflow-scrolling: touch;
                margin-left: -15px;
                margin-right: -15px;
            }

            .carousel-inner .row::-webkit-scrollbar {
                display: none;
            }

            .carousel-inner .col-6 {
                flex: 0 0 auto;
                width: 50%;
            }

            @media (min-width: 576px) {
                .carousel-inner .col-sm-4 {
                    width: 33.333333%;
                }
            }

            @media (min-width: 768px) {
                .carousel-inner .col-md-3 {
                    width: 25%;
                }
            }

            @media (min-width: 992px) {
                .carousel-inner .col-lg-2 {
                    width: 16.666667%;
                }

            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-expand-lg header">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil.jsp">MeryAcademi</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/accueil.jsp">Accueil</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Connexion</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Inscription</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- Banner -->
        <div class="banner container-fluid">
            <div class="row align-items-center">
                <!-- Partie texte -->
                <div class="col-md-6 banner-content">
                    <h1>Apprenez sans limites</h1>
                    <p>Commencez, réorientez ou faites progresser votre carrière grâce à plus de 5 800 cours, Certificats Professionnels et diplômes d'universités et d'entreprises de renommée internationale.</p>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Inscrivez-vous gratuitement</a>
                </div>
            </div>
        </div>




        <!-- Carousel Section -->
        <div class="carousel-section container my-5">
            <h2 class="text-center mb-4">Nos formateurs</h2>

            <div id="multiCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <!-- Tous les formateurs dans une seule ligne -->
                    <div class="carousel-item active">
                        <div class="row flex-nowrap overflow-auto">
                            <!-- Formateur 1 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur1.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 1" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Jean Martin</h5>
                                        <p class="card-text">Expert en gestion</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Formateur 2 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur2.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 2" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Sophie Leroy</h5>
                                        <p class="card-text">Spécialiste AI</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Formateur 3 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur3.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 3" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Marie Dupont</h5>
                                        <p class="card-text">Éducation</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Formateur 4 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur4.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 4" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Pierre Durand</h5>
                                        <p class="card-text">Développement web</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Formateur 5 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur5.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 5" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Claire Moreau</h5>
                                        <p class="card-text">Data Science</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>

                            <!-- Formateur 6 -->
                            <div class="col-6 col-sm-4 col-md-3 col-lg-2 mb-4">
                                <div class="card h-100 text-center p-3">
                                    <img src="${pageContext.request.contextPath}/imgs/formateur6.jpg" class="card-img-top rounded-circle mx-auto" alt="Formateur 6" style="width: 120px; height: 120px; object-fit: cover;">
                                    <div class="card-body">
                                        <h5 class="card-title">Luc Bernard</h5>
                                        <p class="card-text">Bases de données</p>
                                        <a href="#" class="btn btn-sm btn-outline-primary">Voir profil</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contrôles du carrousel -->
                <button class="carousel-control-prev" type="button" data-bs-target="#multiCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
                    <span class="visually-hidden">Précédent</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#multiCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon bg-dark rounded-circle p-3" aria-hidden="true"></span>
                    <span class="visually-hidden">Suivant</span>
                </button>
            </div>
        </div>

        <!-- Certificates Section -->
        <div class="certificates-section container">
            <h2>Certificats les plus appréciés</h2>
            <div class="certificate-grid">
                <div class="certificate-card">
                    <img src="${pageContext.request.contextPath}/imgs/cert1.jpg" alt="Certificate 1">
                    <p>Certification en Marketing Digital</p>
                </div>
                <div class="certificate-card">
                    <img src="${pageContext.request.contextPath}/imgs/cert2.jpg" alt="Certificate 2">
                    <p>Certification en Analyse de Données</p>
                </div>
                <div class="certificate-card">
                    <img src="${pageContext.request.contextPath}/imgs/cert3.jpg" alt="Certificate 3">
                    <p>Certification en Développement Web</p>
                </div>
                <div class="certificate-card">
                    <img src="${pageContext.request.contextPath}/imgs/cert4.jpg" alt="Certificate 4">
                    <p>Certification en Intelligence Artificielle</p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <p>© 2025 MeryAcademi. Tous droits réservés. | <a href="#">Conditions d'utilisation</a> | <a href="#">Politique de confidentialité</a></p>
        </footer>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>