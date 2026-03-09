<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Matiere" %>
<%
    Matiere matiere = (Matiere) request.getAttribute("matiere");
    String title = (matiere != null && matiere.getId() != null) ? "Modifier une Matière" : "Ajouter une Matière";
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
        
        <form action="<%= request.getContextPath() %>/matieres/save" method="post" class="mt-4">
            <% if (matiere != null && matiere.getId() != null) { %>
                <input type="hidden" name="id" value="<%= matiere.getId() %>"/>
            <% } %>
            
            <div class="mb-3">
                <label for="nom" class="form-label">Nom</label>
                <input type="text" class="form-control" id="nom" name="nom" value="<%= matiere != null && matiere.getNom() != null ? matiere.getNom() : "" %>" required>
            </div>
            
            <div class="mb-3">
                <label for="coefficient" class="form-label">Coefficient</label>
                <input type="number" class="form-control" id="coefficient" name="coefficient" value="<%= matiere != null && matiere.getCoefficient() != null ? matiere.getCoefficient() : "" %>" required min="1">
            </div>
            
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="<%= request.getContextPath() %>/matieres" class="btn btn-secondary">Annuler</a>
        </form>
    </div>
</body>
</html>
