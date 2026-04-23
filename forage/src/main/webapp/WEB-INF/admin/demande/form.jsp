<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${demande.id == 0 ? "Nouvelle Demande" : "Modifier Demande"}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>${demande.id == 0 ? "Nouvelle Demande" : "Modifier Demande"}</h1>
            <a href="${pageContext.request.contextPath}/admin/demande" class="btn btn-secondary">Retour</a>
        </div>

        <div class="card">
            <c:choose>
                <c:when test="${demande.id == 0}">
                    <form action="${pageContext.request.contextPath}/admin/demande" method="post">
                </c:when>
                <c:otherwise>
                    <form action="${pageContext.request.contextPath}/admin/demande/update/${demande.id}" method="post">
                </c:otherwise>
            </c:choose>

                <input type="hidden" name="id" value="${demande.id}">

                <div class="form-group">
                    <label for="client">Client bénéficiaire</label>
                    <select id="client" name="client.id" required>
                        <option value="">Sélectionnez un client</option>
                        <c:forEach var="c" items="${clients}">
                            <option value="${c.id}" ${demande.client.id == c.id ? 'selected' : ''}>
                                ${c.nom} (${c.contact})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="district">District / Localisation</label>
                    <input type="text" id="district" name="district"
                           value="${demande.district}" required>
                </div>

                <div class="form-group">
                    <label for="description">Description détaillée du besoin</label>
                    <textarea id="description" name="description"
                                rows="5" required>${demande.description}</textarea>
                </div>

                <c:if test="${demande.id != 0}">
                    <div class="form-group">
                        <label for="statutId">Statut</label>
                        <select id="statutId" name="statutId" required>
                            <c:forEach var="statut" items="${statuts}">
                                <option value="${statut.id}"
                                    ${demande.dernierStatut.statut.id == statut.id ? 'selected' : ''}>
                                    ${statut.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </c:if>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">
                        ${demande.id == 0 ? "Enregistrer" : "Modifier"}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/demande" class="btn btn-secondary">
                        Annuler
                    </a>
                </div>

            </form>
        </div>
    </div>
</body>
</html>
