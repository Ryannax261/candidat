<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Candidat" %>
<%@ page import="com.example.model.Matiere" %>
<%
    List<Candidat> candidats = (List<Candidat>) request.getAttribute("candidats");
    List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
    Double finalNote = (Double) request.getAttribute("finalNote");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Saisie Note Finale</title>
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
        
        .subtitle {
            color: var(--text-muted) !important;
            font-size: 1.1rem;
            opacity: 0.8;
            margin-bottom: 2rem;
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
            max-width: 800px !important;
            margin: 0 auto 2rem !important;
        }
        
        .result-container {
            background: rgba(0, 184, 148, 0.1) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-xl) !important;
            padding: 2.5rem !important;
            border: 1px solid rgba(0, 184, 148, 0.3) !important;
            box-shadow: 0 8px 25px rgba(0, 184, 148, 0.3) !important;
            text-align: center !important;
        }
        
        .result-title {
            background: linear-gradient(135deg, #00b894, #00d2a0) !important;
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            font-family: 'Space Grotesk', sans-serif !important;
        }
        
        .result-score {
            font-size: 3rem !important;
            font-weight: 700 !important;
            color: var(--accent-light) !important;
            margin: 1rem 0 !important;
            text-shadow: 0 0 30px rgba(247, 183, 49, 0.4) !important;
        }
        
        .error-container {
            background: rgba(214, 48, 49, 0.1) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius) !important;
            padding: 1rem 1.5rem !important;
            border: 1px solid rgba(214, 48, 49, 0.3) !important;
            margin-bottom: 2rem !important;
            color: #ff7675 !important;
            font-weight: 600 !important;
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
        
        .form-select {
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
        
        .form-select:focus {
            border-color: var(--primary) !important;
            background: rgba(22, 33, 62, 0.6) !important;
            box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.2) !important;
            transform: translateY(-1px) !important;
        }
        
        .form-select option {
            background: var(--surface) !important;
            color: var(--text-main) !important;
        }
        
        .form-row {
            display: flex !important;
            gap: 1.5rem !important;
            align-items: flex-end !important;
        }
        
        .form-col {
            flex: 1 !important;
        }
        
        .container {
            max-width: 1400px !important;
            padding: 2rem !important;
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
        
        .result-container {
            animation: fadeInUp 0.8s ease-out;
        }
        
        .error-container {
            animation: fadeInUp 0.4s ease-out;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="page-title text-center">🏆 Calcul de la Note Finale</h2>
        <p class="subtitle text-center">Sélectionnez un candidat et une matière pour calculer la note finale en fonction des notes des correcteurs et des paramètres définis.</p>

        <% if (error != null) { %>
            <div class="error-container">
                ⚠️ <%= error %>
            </div>
        <% } %>

        <div class="form-container">
            <form action="<%= request.getContextPath() %>/notes/final/compute" method="post">
                <div class="form-row">
                    <div class="form-col">
                        <label for="candidat" class="form-label">👥 Candidat</label>
                        <select class="form-select" id="candidat" name="candidatId" required>
                            <option value="">Sélectionnez un candidat</option>
                            <%
                                if (candidats != null) {
                                    for (Candidat c : candidats) {
                            %>
                                <option value="<%= c.getId() %>"><%= c.getNom() %> <%= c.getPrenom() %> (<%= c.getMatricule() %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-col">
                        <label for="matiere" class="form-label">📚 Matière</label>
                        <select class="form-select" id="matiere" name="matiereId" required>
                            <option value="">Sélectionnez une matière</option>
                            <%
                                if (matieres != null) {
                                    for (Matiere m : matieres) {
                            %>
                                <option value="<%= m.getId() %>"><%= m.getNom() %> (Coeff: <%= m.getCoefficient() %>)</option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-col">
                        <button type="submit" class="sunset-btn w-100">🧮 Calculer</button>
                    </div>
                </div>
            </form>
        </div>

        <% if (finalNote != null) { %>
            <div class="result-container">
                <h3 class="result-title">🎯 Résultat du Calcul</h3>
                <div class="result-score"><%= String.format("%.2f", finalNote) %></div>
                <p>Note finale après application des règles et résolutions.</p>
            </div>
        <% } %>

        <div class="text-center mt-4">
            <a href="<%= request.getContextPath() %>/" class="sunset-btn-secondary">🏠 Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
