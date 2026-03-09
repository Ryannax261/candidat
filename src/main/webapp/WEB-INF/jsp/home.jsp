<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - Note Candidat</title>
    
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <style>
        /* Override Bootstrap with Sunset Theme */
        body {
            background: var(--gradient-surface) !important;
            font-family: 'Space Grotesk', sans-serif !important;
        }
        
        .main-title {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 0 0 40px rgba(255, 107, 53, 0.4);
        }
        
        .subtitle {
            color: var(--text-muted);
            font-size: 1.2rem;
            opacity: 0.8;
        }
        
        .sunset-card {
            background: rgba(22, 33, 62, 0.6) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border) !important;
            border-radius: var(--radius-xl) !important;
            box-shadow: var(--shadow) !important;
            transition: var(--transition) !important;
            position: relative;
            overflow: hidden;
            height: 100% !important;
        }
        
        .sunset-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .sunset-card:hover {
            transform: translateY(-8px) !important;
            box-shadow: var(--shadow-xl) !important;
            border-color: var(--primary-light) !important;
        }
        
        .sunset-card:hover::before {
            opacity: 1;
        }
        
        .sunset-card .card-body {
            background: transparent !important;
            padding: 2rem !important;
            color: var(--text-main) !important;
        }
        
        .sunset-card .card-title {
            background: var(--gradient-text);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 1rem;
            font-family: 'Space Grotesk', sans-serif;
        }
        
        .sunset-card .card-text {
            color: var(--text-muted) !important;
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }
        
        .sunset-btn {
            background: var(--gradient-primary) !important;
            color: white !important;
            border: none !important;
            padding: 0.875rem 1.5rem !important;
            border-radius: var(--radius) !important;
            font-weight: 600 !important;
            font-family: 'Space Grotesk', sans-serif !important;
            text-transform: uppercase !important;
            letter-spacing: 0.05em !important;
            transition: var(--transition) !important;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3) !important;
        }
        
        .sunset-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            transition: left 0.3s ease;
        }
        
        .sunset-btn:hover {
            transform: translateY(-2px) !important;
            box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4) !important;
            background: linear-gradient(135deg, #ff8c42, #f9c851) !important;
        }
        
        .sunset-btn:hover::before {
            left: 0;
        }
        
        .sunset-btn-success {
            background: linear-gradient(135deg, #00b894, #00d2a0) !important;
            box-shadow: 0 4px 15px rgba(0, 184, 148, 0.3) !important;
        }
        
        .sunset-btn-success:hover {
            box-shadow: 0 8px 25px rgba(0, 184, 148, 0.4) !important;
            background: linear-gradient(135deg, #00d2a0, #00b894) !important;
        }
        
        .featured-card {
            background: rgba(255, 107, 53, 0.08) !important;
            border-left: 4px solid var(--primary) !important;
        }
        
        .featured-card.success {
            background: rgba(0, 184, 148, 0.08) !important;
            border-left: 4px solid var(--success) !important;
        }
        
        .featured-card .card-title {
            color: var(--primary-light) !important;
            -webkit-text-fill-color: var(--primary-light) !important;
        }
        
        .featured-card.success .card-title {
            color: var(--success-light) !important;
            -webkit-text-fill-color: var(--success-light) !important;
        }
        
        .container {
            max-width: 1400px !important;
        }
        
        .row > * {
            padding: 1rem !important;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .sunset-card {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .sunset-card:nth-child(1) { animation-delay: 0.1s; }
        .sunset-card:nth-child(2) { animation-delay: 0.2s; }
        .sunset-card:nth-child(3) { animation-delay: 0.3s; }
        .sunset-card:nth-child(4) { animation-delay: 0.4s; }
        .sunset-card:nth-child(5) { animation-delay: 0.5s; }
        .sunset-card:nth-child(6) { animation-delay: 0.6s; }
    </style>
</head>
<body>
    <div class="container mt-5 text-center">
        <h1 class="main-title animate-float">Bienvenue dans le Système de Gestion des Notes</h1>
        <p class="subtitle mb-5">Choisissez une option ci-dessous pour gérer les différentes entités du système.</p>
        
        <div class="row g-4 justify-content-center">
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">👥 Candidats</h5>
                        <p class="card-text">Gérer la liste des candidats inscrits aux examens.</p>
                        <a href="<%= request.getContextPath() %>/candidats" class="btn sunset-btn w-100">Voir les Candidats</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">📚 Matières</h5>
                        <p class="card-text">Gérer les différentes matières et leurs coefficients.</p>
                        <a href="<%= request.getContextPath() %>/matieres" class="btn sunset-btn w-100">Voir les Matières</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">👨‍🏫 Correcteurs</h5>
                        <p class="card-text">Gérer la liste des correcteurs d'examen.</p>
                        <a href="<%= request.getContextPath() %>/correcteurs" class="btn sunset-btn w-100">Voir les Correcteurs</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">🔢 Opérateurs</h5>
                        <p class="card-text">Gérer les opérateurs mathématiques pour les calculs.</p>
                        <a href="<%= request.getContextPath() %>/operateurs" class="btn sunset-btn w-100">Voir les Opérateurs</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">⚡ Résolutions</h5>
                        <p class="card-text">Gérer les différentes résolutions possibles.</p>
                        <a href="<%= request.getContextPath() %>/resolutions" class="btn sunset-btn w-100">Voir les Résolutions</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="sunset-card">
                    <div class="card-body">
                        <h5 class="card-title">⚙️ Paramètres</h5>
                        <p class="card-text">Configurer les paramètres globaux du système.</p>
                        <a href="<%= request.getContextPath() %>/parametres" class="btn sunset-btn w-100">Voir les Paramètres</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="sunset-card featured-card">
                    <div class="card-body">
                        <h4 class="card-title">📝 Saisie des Notes</h4>
                        <p class="card-text">Saisir de nouvelles notes ou associer des notes aux correcteurs.</p>
                        <a href="<%= request.getContextPath() %>/notes" class="btn sunset-btn w-100">Gérer les Notes</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mt-4">
                <div class="sunset-card featured-card success">
                    <div class="card-body">
                        <h4 class="card-title">🏆 Note Finale par Candidat/Matière</h4>
                        <p class="card-text">Consulter le récapitulatif de la note finale pour un candidat à une matière spécifique.</p>
                        <a href="<%= request.getContextPath() %>/notes/final" class="btn sunset-btn-success w-100">Voir la Note Finale</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
