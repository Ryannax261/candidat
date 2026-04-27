<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier l'historique - ${statusEntry.demande.client.nom}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .edit-card {
            max-width: 600px;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Modifier l'entrée d'historique</h1>
            <a href="${pageContext.request.contextPath}/admin/demande/${statusEntry.demande.id}/statut" class="btn btn-secondary">Retour au suivi</a>
        </div>

        <div class="edit-card">
            <form action="${pageContext.request.contextPath}/admin/demande/statut/update/${statusEntry.id}" method="post">
                <div class="form-group">
                    <label for="statutId">Statut</label>
                    <select name="statutId" id="statutId" class="form-control" required>
                        <c:forEach var="s" items="${statuts}">
                            <option value="${s.id}" ${statusEntry.statut.id == s.id ? 'selected' : ''}>
                                ${s.nom}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateStatut">Date et Heure du statut</label>
                    <input type="datetime-local" name="dateStatut" id="dateStatut" class="form-control" 
                           value="${statusEntry.dateStatutForInput}" required>
                </div>
                <div class="form-group">
                    <label for="observation">Observation</label>
                    <textarea name="observation" id="observation" class="form-control" rows="4">${statusEntry.observation}</textarea>
                </div>
                <div style="text-align: right; margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
