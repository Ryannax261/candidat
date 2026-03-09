<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Operateur" %>
<%
    Operateur operateur = (Operateur) request.getAttribute("operateur");
    String title = (operateur != null && operateur.getId() != null) ? "Modifier un Opérateur" : "Ajouter un Opérateur";
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
        
        <form action="<%= request.getContextPath() %>/operateurs/save" method="post" class="mt-4">
            <% if (operateur != null && operateur.getId() != null) { %>
                <input type="hidden" name="id" value="<%= operateur.getId() %>"/>
            <% } %>
            
            <div class="mb-3">
                <label for="operateur" class="form-label">Opérateur</label>
                <input type="text" class="form-control" id="operateur" name="operateur" value="<%= operateur != null && operateur.getOperateur() != null ? operateur.getOperateur() : "" %>" required>
            </div>
            
            <button type="submit" class="btn btn-success">Enregistrer</button>
            <a href="<%= request.getContextPath() %>/operateurs" class="btn btn-secondary">Annuler</a>
        </form>
    </div>
</body>
</html>
