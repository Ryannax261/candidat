<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Correcteur" %>
<%
    Correcteur correcteur = (Correcteur) request.getAttribute("correcteur");
    String title = (correcteur != null && correcteur.getId() != null) ? "Modifier un Correcteur" : "Ajouter un Correcteur";
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
        
        <form action="<%= request.getContextPath() %>/correcteurs/save" method="post" class="mt-4">
            <% if (correcteur != null && correcteur.getId() != null) { %>
                <input type="hidden" name="id" value="<%= correcteur.getId() %>"/>
            <% } %>
            
            <div class="mb-3">
                <label for="nom" class="form-label">Nom</label>
                <input type="text" class="form-control" id="nom" name="nom" value="<%= correcteur != null && correcteur.getNom() != null ? correcteur.getNom() : "" %>" required>
            </div>
            
            <div class="mb-3">
                <label for="prenom" class="form-label">Prénom</label>
                <input type="text" class="form-control" id="prenom" name="prenom" value="<%= correcteur != null && correcteur.getPrenom() != null ? correcteur.getPrenom() : "" %>" required>
            </div>
            
            <div class="mb-3">
                <label for="numtel" class="form-label">Numéro de Téléphone</label>
                <input type="text" class="form-control" id="numtel" name="numtel" value="<%= correcteur != null && correcteur.getNumtel() != null ? correcteur.getNumtel() : "" %>" required>
            </div>
            
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="<%= request.getContextPath() %>/correcteurs" class="btn btn-secondary">Annuler</a>
        </form>
    </div>
</body>
</html>
