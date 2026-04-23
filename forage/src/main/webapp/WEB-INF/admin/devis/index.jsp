<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Devis</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>
                <c:choose>
                    <c:when test="${not empty filteredDemande}">
                        Historique des Devis pour la demande #${filteredDemande.id} (${filteredDemande.client.nom})
                    </c:when>
                    <c:otherwise>
                        Liste des Devis
                    </c:otherwise>
                </c:choose>
            </h1>
            <div>
                <c:if test="${not empty filteredDemande}">
                    <a href="${pageContext.request.contextPath}/admin/demande?clientId=${filteredDemande.client.id}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour aux demandes
                    </a>
                </c:if>
                <a href="${pageContext.request.contextPath}/admin/devis/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nouveau Devis
                </a>
            </div>
        </div>

        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>Date Changement</th>
                        <th>ID Devis</th>
                        <th>Demande</th>
                        <th>Type</th>
                        <th>Montant Total</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ds" items="${devisStatuts}">
                        <tr>
                            <td>
                                <fmt:parseDate value="${ds.dateStatut}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedStatutDate" type="both"/>
                                <fmt:formatDate value="${parsedStatutDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>#${ds.devis.id}</td>
                            <td>
                                #${ds.devis.demande.id} - ${ds.devis.demande.client.nom}
                            </td>
                            <td>${ds.devis.typeDevis.nom}</td>
                            <td>
                                <fmt:formatNumber value="${ds.devis.montantTotal}" type="currency" currencySymbol="Ar"/>
                            </td>
                            <td>
                                ${ds.statutDevis.nom}
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/devis/show/${ds.devis.id}" class="btn btn-sm btn-secondary">Détail</a>
                                <a href="${pageContext.request.contextPath}/admin/devis/delete/${ds.devis.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer ?')">Supprimer</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty devisStatuts}">
                        <tr><td colspan="7" style="text-align:center;">Aucun devis.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>
</body>
</html>
