<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Resolution" %>
<%
    Resolution resolution = (Resolution) request.getAttribute("resolution");
    String title = (resolution != null && resolution.getId() != null) ? "Modifier une Résolution" : "Ajouter une Résolution";
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
        
        <form action="<%= request.getContextPath() %>/resolutions/save" method="post" class="mt-4">
            <% if (resolution != null && resolution.getId() != null) { %>
                <input type="hidden" name="id" value="<%= resolution.getId() %>"/>
            <% } %>
            
            <div class="mb-3">
                <label for="nom" class="form-label">Nom</label>
                <input type="text" class="form-control" id="nom" name="nom" value="<%= resolution != null && resolution.getNom() != null ? resolution.getNom() : "" %>" required>
            </div>
            
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="<%= request.getContextPath() %>/resolutions" class="btn btn-secondary">Annuler</a>
        </form>
    </div>
</body>
</html>
