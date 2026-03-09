<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Parametre" %>
<%@ page import="com.example.model.Matiere" %>
<%@ page import="com.example.model.Resolution" %>
<%@ page import="com.example.model.Operateur" %>
<%
    Parametre parametre = (Parametre) request.getAttribute("parametre");
    List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
    List<Resolution> resolutions = (List<Resolution>) request.getAttribute("resolutions");
    List<Operateur> operateurs = (List<Operateur>) request.getAttribute("operateurs");
    String title = (parametre != null && parametre.getId() != null) ? "Modifier un Paramètre" : "Ajouter un Paramètre";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title><%= title %></title>
    <link href="<%= request.getContextPath() %>/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2><%= title %></h2>
        
        <form action="<%= request.getContextPath() %>/parametres/save" method="post" class="mt-4">
            <% if (parametre != null && parametre.getId() != null) { %>
                <input type="hidden" name="id" value="<%= parametre.getId() %>"/>
            <% } %>
            
            <div class="mb-3">
                <label for="matiere" class="form-label">Matière</label>
                <select class="form-select" id="matiere" name="matiere.id" required>
                    <option value="">Sélectionnez une matière</option>
                    <%
                        if (matieres != null) {
                            for (Matiere m : matieres) {
                                String selected = (parametre != null && parametre.getMatiere() != null && parametre.getMatiere().getId().equals(m.getId())) ? "selected" : "";
                    %>
                        <option value="<%= m.getId() %>" <%= selected %>><%= m.getNom() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="resolution" class="form-label">Résolution</label>
                <select class="form-select" id="resolution" name="resolution.id" required>
                    <option value="">Sélectionnez une résolution</option>
                    <%
                        if (resolutions != null) {
                            for (Resolution r : resolutions) {
                                String selected = (parametre != null && parametre.getResolution() != null && parametre.getResolution().getId().equals(r.getId())) ? "selected" : "";
                    %>
                        <option value="<%= r.getId() %>" <%= selected %>><%= r.getNom() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="operateur" class="form-label">Opérateur</label>
                <select class="form-select" id="operateur" name="operateur.id" required>
                    <option value="">Sélectionnez un opérateur</option>
                    <%
                        if (operateurs != null) {
                            for (Operateur o : operateurs) {
                                String selected = (parametre != null && parametre.getOperateur() != null && parametre.getOperateur().getId().equals(o.getId())) ? "selected" : "";
                    %>
                        <option value="<%= o.getId() %>" <%= selected %>><%= o.getOperateur() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="seuil" class="form-label">Seuil</label>
                <input type="number" step="0.01" class="form-control" id="seuil" name="seuil" value="<%= parametre != null && parametre.getSeuil() != null ? parametre.getSeuil() : "" %>" required>
            </div>
            
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="<%= request.getContextPath() %>/parametres" class="btn btn-secondary">Annuler</a>
        </form>
    </div>
</body>
</html>
