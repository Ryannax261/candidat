<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Demandes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Liste des Demandes</h1>
            <a href="${pageContext.request.contextPath}/admin/demande/create" class="btn btn-primary">Nouvelle Demande</a>
        </div>

        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>Client</th>
                        <th>District</th>
                        <th>Date</th>
                        <th>Description</th>
                        <th>Statut actuel</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="demande" items="${demandes}">
                        <tr>
                            <td>${demande.client.nom}</td>
                            <td>${demande.district}</td>
                            <td>${demande.dateDemandeFormatee}</td>
                            <td>${demande.description}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty demande.dernierStatut}">
                                        <span class="badge">${demande.dernierStatut.statut.nom}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-grey">Aucun</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/demande/edit/${demande.id}"
                                   class="btn btn-sm btn-primary">Modifier</a>
                                <a href="${pageContext.request.contextPath}/admin/demande/${demande.id}/statut"
                                   class="btn btn-sm btn-info">Statut</a>
                                <a href="${pageContext.request.contextPath}/admin/demande/delete/${demande.id}"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Supprimer cette demande ?')">Supprimer</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>