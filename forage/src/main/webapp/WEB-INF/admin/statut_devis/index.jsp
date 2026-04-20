<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Statuts des Devis</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1><i class="fas fa-flag"></i> Statuts des Devis</h1>
            <a href="${pageContext.request.contextPath}/admin/statut_devis/create" class="btn btn-primary">
                <i class="fas fa-plus"></i> Nouveau Statut
            </a>
        </div>

        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom du Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${statuts}">
                        <tr>
                            <td>${s.id}</td>
                            <td><span class="badge">${s.nom}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/statut_devis/edit/${s.id}" class="btn btn-sm btn-secondary">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/statut_devis/delete/${s.id}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Supprimer ce statut ?')">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty statuts}">
                        <tr><td colspan="3" style="text-align:center; opacity:0.6;">Aucun statut enregistré.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
