<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MeryAcademi | Tableau de Bord Statistique</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #7E57C2;
            --primary-light: #B39DDB;
            --primary-dark: #5E35B1;
            --accent: #FF9800;
            --text-light: #F5F5F5;
            --text-dark: #2D3748;
            --bg-light: #F8FAFC;
            --card-shadow: 0 10px 20px rgba(126, 87, 194, 0.1);
            --card-radius: 16px;
        }
        
        body {
            background-color: var(--bg-light);
            color: var(--text-dark);
            font-family: 'Poppins', sans-serif;
            display: flex;
            min-height: 100vh;
        }
        
        /* Modern Sidebar */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, var(--primary-dark), var(--primary));
            color: var(--text-light);
            height: 100vh;
            position: fixed;
            box-shadow: 5px 0 30px rgba(94, 53, 177, 0.2);
            z-index: 100;
            padding: 0;
            transition: all 0.3s ease;
        }
        
        .brand {
            padding: 30px 25px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            background: rgba(0,0,0,0.1);
        }
        
        .brand-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        
        .brand-logo i {
            margin-right: 12px;
            color: var(--accent);
            font-size: 2rem;
        }
        
        .brand-tagline {
            font-size: 0.75rem;
            opacity: 0.8;
            font-weight: 300;
            letter-spacing: 0.5px;
        }
        
        .nav-menu {
            padding: 20px 0;
        }
        
        .nav-item {
            padding: 14px 30px;
            margin: 5px 15px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            color: rgba(255,255,255,0.9);
            text-decoration: none;
            font-size: 0.95rem;
        }
        
        .nav-item i {
            width: 24px;
            margin-right: 15px;
            text-align: center;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .nav-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(5px);
            color: white;
        }
        
        .nav-item:hover i {
            color: var(--accent);
        }
        
        .nav-item.active {
            background: linear-gradient(90deg, rgba(255,152,0,0.2), transparent);
            border-left: 4px solid var(--accent);
            color: white;
            font-weight: 600;
        }
        
        /* Main Content */
        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 40px;
            background-color: var(--bg-light);
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }
        
        .page-title h1 {
            font-size: 2rem;
            color: var(--primary-dark);
            font-weight: 700;
            margin-bottom: 5px;
            letter-spacing: -0.5px;
        }
        
        .page-title p {
            font-size: 0.9rem;
            color: #64748B;
            font-weight: 400;
        }
        
        .user-profile {
            display: flex;
            align-items: center;
            background: white;
            padding: 10px 20px;
            border-radius: 50px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }
        
        .user-profile:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(126, 87, 194, 0.15);
        }
        
        .user-profile img {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            margin-right: 12px;
            object-fit: cover;
            border: 2px solid var(--primary-light);
        }
        
        .user-profile span {
            font-weight: 500;
            color: var(--text-dark);
        }
        
        /* Modern Charts Container */
        .charts-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 30px;
            margin-top: 20px;
        }
        
        .chart-card {
            background: white;
            border-radius: var(--card-radius);
            padding: 30px;
            box-shadow: var(--card-shadow);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(126, 87, 194, 0.08);
        }
        
        .chart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(126, 87, 194, 0.15);
        }
        
        .chart-title {
            text-align: center;
            margin-bottom: 25px;
            color: var(--primary-dark);
            font-size: 1.3rem;
            font-weight: 600;
            position: relative;
            display: inline-block;
            width: 100%;
        }
        
        .chart-title:after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            border-radius: 3px;
        }
        
        .chart-wrapper {
            position: relative;
            height: 350px;
            width: 100%;
        }
        
        /* Alert Modern */
        .alert-modern {
            border-radius: var(--card-radius);
            padding: 18px 25px;
            margin-bottom: 30px;
            border: none;
            box-shadow: var(--card-shadow);
            font-weight: 500;
            display: flex;
            align-items: center;
        }
        
        .alert-modern i {
            margin-right: 12px;
            font-size: 1.2rem;
        }
        
        /* Responsive */
        @media (max-width: 992px) {
            .sidebar {
                width: 240px;
            }
            .main-content {
                margin-left: 240px;
                padding: 30px;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .main-content {
                margin-left: 0;
            }
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
            <div class="brand-tagline">Excellence Éducative Digitale</div>
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
            <a href="../users/page.jsp" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Utilisateurs</span>
            </a>
            <a href="../statistique/statis.jsp" class="nav-item active">
                <i class="fas fa-chart-pie"></i>
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
                <h1>Tableau de Bord Statistique</h1>
                <p>Analyse visuelle des performances des formations</p>
            </div>
            
            <div class="user-profile">
                <img src="https://ui-avatars.com/api/?name=Admin+Mery&background=7E57C2&color=fff&bold=true" alt="Admin">
                <span>Administrateur</span>
            </div>
        </div>
        
        <div class="alert alert-danger alert-modern" style="display:none;" id="error-alert">
            <i class="fas fa-exclamation-circle"></i>
            <span id="error-message"></span>
        </div>
        
        <div class="charts-container">
            <!-- Bar Chart Card -->
            <div class="chart-card">
                <h2 class="chart-title">Participation aux Sessions</h2>
                <div class="chart-wrapper">
                    <canvas id="barChart"></canvas>
                </div>
            </div>
            
            <!-- Line Chart Card -->
            <div class="chart-card">
                <h2 class="chart-title">Tendance de Participation</h2>
                <div class="chart-wrapper">
                    <canvas id="lineChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 1. Appel au service REST pour les participations
            fetch('http://localhost:8080/GestionFormationsInternesEntreprise/SessionParticipationController')
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`Erreur HTTP! Statut: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    // 2. Extraction et préparation des données
                    const labels = data.map(item => item.sessionName);
                    const values = data.map(item => item.participantCount);
                    
                    // 3. Palette de couleurs moderne
                    const gradientColors = [
                        'rgba(126, 87, 194, 0.8)',  // Primary
                        'rgba(255, 152, 0, 0.8)',   // Accent
                        'rgba(94, 53, 177, 0.8)',   // Primary Dark
                        'rgba(179, 157, 219, 0.8)', // Primary Light
                        'rgba(255, 193, 7, 0.8)',   // Amber
                        'rgba(100, 181, 246, 0.8)'  // Blue
                    ];
                    
                    // 4. Configuration commune moderne
                    const commonOptions = {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(45, 55, 72, 0.95)',
                                titleFont: {
                                    family: 'Poppins',
                                    size: 14,
                                    weight: 'bold'
                                },
                                bodyFont: {
                                    family: 'Poppins',
                                    size: 12
                                },
                                padding: 12,
                                cornerRadius: 12,
                                displayColors: false,
                                callbacks: {
                                    label: function(context) {
                                        return ` Participants: ${context.parsed.y}`;
                                    },
                                    title: function(context) {
                                        return context[0].label;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(226, 232, 240, 0.8)',
                                    drawBorder: false
                                },
                                ticks: { 
                                    stepSize: 1,
                                    precision: 0,
                                    font: {
                                        family: 'Poppins',
                                        weight: '500'
                                    }
                                },
                                title: {
                                    display: true,
                                    text: 'Nombre de Participants',
                                    font: {
                                        family: 'Poppins',
                                        size: 14,
                                        weight: '600'
                                    },
                                    color: '#64748B'
                                }
                            },
                            x: {
                                grid: {
                                    display: false,
                                    drawBorder: false
                                },
                                ticks: {
                                    font: {
                                        family: 'Poppins',
                                        weight: '500'
                                    }
                                },
                                title: {
                                    display: true,
                                    text: 'Sessions de Formation',
                                    font: {
                                        family: 'Poppins',
                                        size: 14,
                                        weight: '600'
                                    },
                                    color: '#64748B'
                                }
                            }
                        },
                        animation: {
                            duration: 1500,
                            easing: 'easeOutQuart'
                        },
                        elements: {
                            bar: {
                                borderRadius: 8,
                                borderSkipped: 'bottom'
                            },
                            point: {
                                radius: 6,
                                hoverRadius: 8,
                                borderWidth: 2
                            }
                        }
                    };

                    // 5. Création du Bar Chart moderne
                    const barCtx = document.getElementById('barChart').getContext('2d');
                    
                    // Gradient pour les barres
                    const barGradient = barCtx.createLinearGradient(0, 0, 0, 400);
                    barGradient.addColorStop(0, 'rgba(126, 87, 194, 0.9)');
                    barGradient.addColorStop(1, 'rgba(179, 157, 219, 0.7)');
                    
                    new Chart(barCtx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Participants',
                                data: values,
                                backgroundColor: gradientColors,
                                borderColor: 'white',
                                borderWidth: 2,
                                hoverBackgroundColor: gradientColors.map(color => color.replace('0.8', '1'))
                            }]
                        },
                        options: {
                            ...commonOptions,
                            plugins: {
                                ...commonOptions.plugins,
                                subtitle: {
                                    display: true,
                                    text: 'Répartition par session',
                                    font: {
                                        size: 14,
                                        family: 'Poppins'
                                    },
                                    padding: {
                                        bottom: 20
                                    },
                                    color: '#64748B'
                                }
                            }
                        }
                    });

                    // 6. Création du Line Chart moderne
                    const lineCtx = document.getElementById('lineChart').getContext('2d');
                    
                    // Gradient pour la ligne
                    const lineGradient = lineCtx.createLinearGradient(0, 0, 0, 400);
                    lineGradient.addColorStop(0, 'rgba(255, 152, 0, 0.3)');
                    lineGradient.addColorStop(1, 'rgba(255, 152, 0, 0)');
                    
                    new Chart(lineCtx, {
                        type: 'line',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Participants',
                                data: values,
                                backgroundColor: lineGradient,
                                borderColor: 'rgba(255, 152, 0, 1)',
                                borderWidth: 3,
                                pointBackgroundColor: 'white',
                                pointBorderColor: 'rgba(255, 152, 0, 1)',
                                pointRadius: 5,
                                pointHoverRadius: 7,
                                tension: 0.4,
                                fill: true,
                                hoverBackgroundColor: 'rgba(255, 152, 0, 0.5)'
                            }]
                        },
                        options: {
                            ...commonOptions,
                            plugins: {
                                ...commonOptions.plugins,
                                subtitle: {
                                    display: true,
                                    text: 'Évolution dans le temps',
                                    font: {
                                        size: 14,
                                        family: 'Poppins'
                                    },
                                    padding: {
                                        bottom: 20
                                    },
                                    color: '#64748B'
                                }
                            }
                        }
                    });
                })
                .catch(err => {
                    console.error('Erreur de chargement des données:', err);
                    const errorAlert = document.getElementById('error-alert');
                    document.getElementById('error-message').textContent = 
                        `Erreur lors du chargement des données statistiques: ${err.message}`;
                    errorAlert.style.display = 'flex';
                });
        });
    </script>
</body>
</html>