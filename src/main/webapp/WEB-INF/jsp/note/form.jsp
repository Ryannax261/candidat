<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Note" %>
<%@ page import="com.example.model.Candidat" %>
<%@ page import="com.example.model.Matiere" %>
<%@ page import="com.example.model.Correcteur" %>
<%
    Note note = (Note) request.getAttribute("note");
    List<Candidat> candidats = (List<Candidat>) request.getAttribute("candidats");
    List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
    List<Correcteur> correcteurs = (List<Correcteur>) request.getAttribute("correcteurs");
    String title = (note != null && note.getId() != null) ? "Modifier une Note" : "Saisir des Notes";
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
        
        .sunset-btn-info {
            background: linear-gradient(135deg, #74b9ff, #0984e3) !important;
            box-shadow: 0 4px 15px rgba(116, 185, 255, 0.3) !important;
        }
        
        .sunset-btn-info:hover {
            box-shadow: 0 8px 25px rgba(116, 185, 255, 0.4) !important;
            background: linear-gradient(135deg, #0984e3, #74b9ff) !important;
        }
        
        .sunset-btn-danger {
            background: linear-gradient(135deg, #ff7675, #d63031) !important;
            box-shadow: 0 4px 15px rgba(255, 118, 117, 0.3) !important;
            padding: 0.5rem 1rem !important;
            font-size: 0.8rem !important;
        }
        
        .sunset-btn-danger:hover {
            box-shadow: 0 8px 25px rgba(255, 118, 117, 0.4) !important;
            background: linear-gradient(135deg, #d63031, #ff7675) !important;
        }
        
        .form-container {
            background: rgba(22, 33, 62, 0.6) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: var(--radius-xl) !important;
            padding: 2.5rem !important;
            border: 1px solid var(--border) !important;
            box-shadow: var(--shadow) !important;
            max-width: 900px !important;
            margin: 0 auto !important;
        }
        
        .correcteur-row {
            background: rgba(22, 33, 62, 0.3) !important;
            border-radius: var(--radius) !important;
            padding: 1.5rem !important;
            margin-bottom: 1rem !important;
            border: 1px solid var(--border-light) !important;
            transition: var(--transition) !important;
        }
        
        .correcteur-row:hover {
            background: rgba(255, 107, 53, 0.05) !important;
            border-color: var(--primary-light) !important;
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
        
        .form-control, .form-select {
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
        
        .form-control:focus, .form-select:focus {
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
            gap: 1rem !important;
            align-items: flex-end !important;
        }
        
        .form-col {
            flex: 1 !important;
        }
        
        .btn-container {
            display: flex !important;
            gap: 1rem !important;
            justify-content: center !important;
            margin-top: 2rem !important;
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
        
        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .correcteur-row:nth-child(1) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2 class="page-title text-center mb-4">
                <%= note != null && note.getId() != null ? "✏️ Modifier une Note" : "📝 Saisir des Notes" %>
            </h2>
            
            <form action="<%= request.getContextPath() %>/notes/save" method="post">
                <% if (note != null && note.getId() != null) { %>
                    <input type="hidden" name="id" value="<%= note.getId() %>"/>
                <% } %>
                
                <div class="form-row mb-4">
                    <div class="form-col">
                        <label for="candidat" class="form-label">👥 Candidat</label>
                        <select class="form-select" id="candidat" name="candidatId" required>
                            <option value="">Sélectionnez un candidat</option>
                            <%
                                if (candidats != null) {
                                    for (Candidat c : candidats) {
                                        String selected = (note != null && note.getCandidat() != null && note.getCandidat().getId().equals(c.getId())) ? "selected" : "";
                            %>
                                <option value="<%= c.getId() %>" <%= selected %>><%= c.getMatricule() %> - <%= c.getNom() %> <%= c.getPrenom() %></option>
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
                                        String selected = (note != null && note.getMatiere() != null && note.getMatiere().getId().equals(m.getId())) ? "selected" : "";
                            %>
                                <option value="<%= m.getId() %>" <%= selected %>><%= m.getNom() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                
                <div id="correcteurs-container">
                    <% if (note != null && note.getId() != null) { %>
                        <div class="correcteur-row">
                            <div class="form-row">
                                <div class="form-col">
                                    <label class="form-label">👨‍🏫 Correcteur</label>
                                    <select class="form-select" name="correcteurIds" required>
                                        <option value="">Sélectionnez un correcteur</option>
                                        <%
                                            if (correcteurs != null) {
                                                for (Correcteur cor : correcteurs) {
                                                    String selected = (note != null && note.getCorrecteur() != null && note.getCorrecteur().getId().equals(cor.getId())) ? "selected" : "";
                                        %>
                                        <option value="<%= cor.getId() %>" <%= selected %>><%= cor.getNom() %> <%= cor.getPrenom() %></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-col">
                                    <label class="form-label">📊 Note (sur 20)</label>
                                    <input type="number" step="0.001" min="0" max="20" class="form-control" name="noteValues" value="<%= note.getNote() != null ? note.getNote() : "" %>" required placeholder="0.00">
                                </div>
                            </div>
                        </div>
                    <% } else { %>
                        <div class="correcteur-row">
                            <div class="form-row">
                                <div class="form-col">
                                    <label class="form-label">👨‍🏫 Correcteur</label>
                                    <select class="form-select" name="correcteurIds" required>
                                        <option value="">Sélectionnez un correcteur</option>
                                        <%
                                            if (correcteurs != null) {
                                                for (Correcteur cor : correcteurs) {
                                        %>
                                        <option value="<%= cor.getId() %>"><%= cor.getNom() %> <%= cor.getPrenom() %></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-col">
                                    <label class="form-label">📊 Note (sur 20)</label>
                                    <input type="number" step="0.001" min="0" max="20" class="form-control" name="noteValues" required placeholder="0.00">
                                </div>
                                <div class="form-col" style="display:none;">
                                    <button type="button" class="sunset-btn-danger remove-btn w-100">🗑️</button>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
                
                <% if (note == null || note.getId() == null) { %>
                    <button type="button" id="add-btn" class="sunset-btn-info mb-4">➕ Ajouter une autre note</button>
                <% } %>
                
                <div class="btn-container">
                    <button type="submit" class="sunset-btn-success">💾 Enregistrer</button>
                    <a href="<%= request.getContextPath() %>/notes" class="sunset-btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const addBtn = document.getElementById('add-btn');
            if (addBtn) {
                addBtn.addEventListener('click', function() {
                    const container = document.getElementById('correcteurs-container');
                    const rows = container.querySelectorAll('.correcteur-row');
                    const clone = rows[0].cloneNode(true);
                    
                    // Reset input
                    clone.querySelector('select').selectedIndex = 0;
                    clone.querySelector('input').value = '';
                    
                    // Show delete button
                    const removeCol = clone.querySelector('.form-col[style*="display:none"]');
                    if(removeCol) {
                        removeCol.style.display = 'block';
                        clone.querySelector('.remove-btn').addEventListener('click', function() {
                            clone.remove();
                        });
                    }
                    
                    container.appendChild(clone);
                });
            }
        });
    </script>
</body>
</html>
