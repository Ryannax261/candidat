<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Candidat" %>
<%
    Candidat candidat = (Candidat) request.getAttribute("candidat");
    String title = (candidat != null && candidat.getId() != null) ? "Modifier un Candidat" : "Ajouter un Candidat";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><%= title %></title>
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <style>
        body {
            background: var(--gradient-surface) !important;
            font-family: 'Space Grotesk', sans-serif !important;
            color: var(--text-main) !important;
            min-height: 100vh;
        }
        
        .page-title {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-shadow: 0 0 40px rgba(255, 107, 53, 0.4);
        }
        
        .sunset-btn {
            background: var(--gradient-primary) !important;
            color: white !important;
            border: none !important;
            padding: 0.875rem 2rem !important;
            border-radius: var(--radius) !important;
            font-weight: 600 !important;
            font-family: 'Space Grotesk', sans-serif !important;
            text-transform: uppercase !important;
            letter-spacing: 0.05em !important;
            transition: var(--transition) !important;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3) !important;
            text-decoration: none !important;
            display: inline-block !important;
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
            color: white !important;
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
        
        .sunset-btn-secondary {
            background: var(--gradient-secondary) !important;
            box-shadow: 0 4px 15px rgba(78, 205, 196, 0.3) !important;
        }
        
        .sunset-btn-secondary:hover {
            box-shadow: 0 8px 25px rgba(78, 205, 196, 0.4) !important;
            background: linear-gradient(135deg, #6ee7df, #44a3aa) !important;
        }
        
        .form-container {
            background: rgba(22, 33, 62, 0.6) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-xl) !important;
            padding: 2.5rem !important;
            border: 1px solid var(--border) !important;
            box-shadow: var(--shadow) !important;
            max-width: 600px !important;
            margin: 0 auto !important;
        }
        
        .form-label {
            color: var(--text-main) !important;
            font-weight: 600 !important;
            font-family: 'Space Grotesk', sans-serif !important;
            text-transform: uppercase !important;
            letter-spacing: 0.05em !important;
            margin-bottom: 0.8rem !important;
            font-size: 0.9rem !important;
        }
        
        .form-control {
            background: rgba(22, 33, 62, 0.4) !important;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--border) !important;
            border-radius: var(--radius) !important;
            color: var(--text-main) !important;
            padding: 1rem !important;
            font-family: 'Space Grotesk', sans-serif !important;
            transition: var(--transition) !important;
            outline: none !important;
        }
        
        .form-control:focus {
            border-color: var(--primary) !important;
            background: rgba(22, 33, 62, 0.6) !important;
            box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.2) !important;
            transform: translateY(-2px) !important;
        }
        
        .form-control::placeholder {
            color: var(--text-muted) !important;
        }
        
        .form-group {
            margin-bottom: 1.5rem !important;
        }
        
        .btn-container {
            display: flex !important;
            gap: 1rem !important;
            justify-content: center !important;
            margin-top: 2rem !important;
        }
        
        .container {
            max-width: 1400px !important;
            min-height: 100vh !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: center !important;
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
        
        .form-container {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="page-title text-center mb-4">
                <%= candidat != null && candidat.getId() != null ? "✏️ Modifier un Candidat" : "➕ Ajouter un Candidat" %>
            </h2>
            
            <form action="<%= request.getContextPath() %>/candidats/save" method="post">
                <% if (candidat != null && candidat.getId() != null) { %>
                    <input type="hidden" name="id" value="<%= candidat.getId() %>"/>
                <% } %>
                
                <div class="form-group">
                    <label for="nom" class="form-label">👤 Nom</label>
                    <input type="text" class="form-control" id="nom" name="nom" value="<%= candidat != null && candidat.getNom() != null ? candidat.getNom() : "" %>" required placeholder="Entrez le nom du candidat">
                </div>
                
                <div class="form-group">
                    <label for="prenom" class="form-label">👤 Prénom</label>
                    <input type="text" class="form-control" id="prenom" name="prenom" value="<%= candidat != null && candidat.getPrenom() != null ? candidat.getPrenom() : "" %>" required placeholder="Entrez le prénom du candidat">
                </div>
                
                <div class="form-group">
                    <label for="matricule" class="form-label">🆔 Matricule</label>
                    <input type="text" class="form-control" id="matricule" name="matricule" value="<%= candidat != null && candidat.getMatricule() != null ? candidat.getMatricule() : "" %>" required placeholder="Entrez le matricule du candidat">
                </div>
                
                <div class="btn-container">
                    <button type="submit" class="sunset-btn-success">💾 Enregistrer</button>
                    <a href="<%= request.getContextPath() %>/candidats" class="sunset-btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
