<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Candidat" %>
<%
    List<Candidat> candidats = (List<Candidat>) request.getAttribute("candidats");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des Candidats</title>
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
    <style>
        body {
            background: var(--gradient-surface) !important;
            font-family: 'Space Grotesk', sans-serif !important;
            color: var(--text-main) !important;
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
            padding: 0.75rem 1.5rem !important;
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
        
        .sunset-btn-secondary {
            background: var(--gradient-secondary) !important;
            box-shadow: 0 4px 15px rgba(78, 205, 196, 0.3) !important;
        }
        
        .sunset-btn-secondary:hover {
            box-shadow: 0 8px 25px rgba(78, 205, 196, 0.4) !important;
            background: linear-gradient(135deg, #6ee7df, #44a3aa) !important;
        }
        
        .sunset-btn-warning {
            background: linear-gradient(135deg, #fdcb6e, #ffeaa7) !important;
            color: #2d3436 !important;
            box-shadow: 0 4px 15px rgba(253, 203, 110, 0.3) !important;
        }
        
        .sunset-btn-warning:hover {
            box-shadow: 0 8px 25px rgba(253, 203, 110, 0.4) !important;
            background: linear-gradient(135deg, #ffeaa7, #fdcb6e) !important;
            color: #2d3436 !important;
        }
        
        .sunset-btn-danger {
            background: linear-gradient(135deg, #d63031, #ff7675) !important;
            box-shadow: 0 4px 15px rgba(214, 48, 49, 0.3) !important;
        }
        
        .sunset-btn-danger:hover {
            box-shadow: 0 8px 25px rgba(214, 48, 49, 0.4) !important;
            background: linear-gradient(135deg, #ff7675, #d63031) !important;
        }
        
        .sunset-table {
            background: rgba(22, 33, 62, 0.6) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-xl) !important;
            border: 1px solid var(--border) !important;
            overflow: hidden;
            box-shadow: var(--shadow) !important;
        }
        
        .sunset-table thead th {
            background: rgba(255, 107, 53, 0.1) !important;
            color: var(--text-main) !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.05em !important;
            font-family: 'Space Grotesk', sans-serif !important;
            border: none !important;
            padding: 1rem !important;
        }
        
        .sunset-table tbody td {
            color: var(--text-secondary) !important;
            border-top: 1px solid var(--border-light) !important;
            padding: 1rem !important;
            vertical-align: middle !important;
        }
        
        .sunset-table tbody tr:hover {
            background: rgba(255, 107, 53, 0.05) !important;
            transform: scale(1.01) !important;
            transition: var(--transition) !important;
        }
        
        .header-container {
            background: rgba(22, 33, 62, 0.4) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-xl) !important;
            padding: 2rem !important;
            margin-bottom: 2rem !important;
            border: 1px solid var(--border) !important;
            box-shadow: var(--shadow) !important;
        }
        
        .container {
            max-width: 1400px !important;
        }
        
        .btn-sm {
            padding: 0.5rem 1rem !important;
            font-size: 0.8rem !important;
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
        
        .sunset-table tbody tr {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .sunset-table tbody tr:nth-child(1) { animation-delay: 0.1s; }
        .sunset-table tbody tr:nth-child(2) { animation-delay: 0.2s; }
        .sunset-table tbody tr:nth-child(3) { animation-delay: 0.3s; }
        .sunset-table tbody tr:nth-child(4) { animation-delay: 0.4s; }
        .sunset-table tbody tr:nth-child(5) { animation-delay: 0.5s; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="header-container d-flex justify-content-between align-items-center">
            <h2 class="page-title mb-0">👥 Liste des Candidats</h2>
            <a href="<%= request.getContextPath() %>/candidats/new" class="sunset-btn">➕ Ajouter un Candidat</a>
        </div>
        
        <div class="table-container">
            <table class="sunset-table table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Matricule</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (candidats != null) {
                            for (Candidat c : candidats) {
                    %>
                        <tr>
                            <td><%= c.getId() %></td>
                            <td><%= c.getNom() %></td>
                            <td><%= c.getPrenom() %></td>
                            <td><%= c.getMatricule() %></td>
                            <td>
                                <a href="<%= request.getContextPath() %>/candidats/edit/<%= c.getId() %>" class="sunset-btn-warning btn-sm">✏️ Éditer</a>
                                <a href="<%= request.getContextPath() %>/candidats/delete/<%= c.getId() %>" class="sunset-btn-danger btn-sm" onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce candidat ?');">🗑️ Supprimer</a>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/" class="sunset-btn-secondary">🏠 Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
