<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détail Devis #${devis.id}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">

        <div class="detail-header">
            <div>
                <h1><i class="fas fa-file-invoice"></i> Devis #${devis.id}</h1>
                <div style="margin-top:6px; opacity:0.85; font-size:0.9rem;">
                    ${devis.typeDevis.nom} &mdash; ${devis.demande.district}
                </div>
            </div>
            <span class="badge">${devis.demande.client.nom}</span>
        </div>

        <%-- Informations générales du devis --%>
        <div class="info-grid">
            <div class="info-box">
                <label><i class="fas fa-user"></i> Client</label>
                <span>${devis.demande.client.nom}</span>
            </div>
            <div class="info-box">
                <label><i class="fas fa-hashtag"></i> ID Demande</label>
                <span>#${devis.demande.id}</span>
            </div>
            <div class="info-box">
                <label><i class="fas fa-calendar-alt"></i> Date Demande</label>
                <span>${devis.demande.dateDemandeFormatee}</span>
            </div>
            <div class="info-box">
                <label><i class="fas fa-map-marker-alt"></i> District</label>
                <span>${devis.demande.district}</span>
            </div>
            <div class="info-box">
                <label><i class="fas fa-tags"></i> Type de Devis</label>
                <span>${devis.typeDevis.nom}</span>
            </div>
            <div class="info-box">
                <label><i class="fas fa-clock"></i> Date Devis</label>
                <span>
                    <fmt:parseDate value="${devis.dateDevis}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>
        </div>

        <%-- Table des lignes de détail --%>
        <div class="card" style="padding: 20px;">
            <h3 style="margin-top:0;"><i class="fas fa-list"></i> Lignes du Devis</h3>
            <table class="details-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Libellé</th>
                        <th class="text-right">PU (Ar)</th>
                        <th class="text-right">Quantité</th>
                        <th class="text-right">Total (Ar)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${devis.details}" varStatus="s">
                        <tr>
                            <td>${s.index + 1}</td>
                            <td>${detail.libelle}</td>
                            <td class="text-right">
                                <fmt:formatNumber value="${detail.pu}" maxFractionDigits="2" minFractionDigits="2"/>
                            </td>
                            <td class="text-right">${detail.quantite}</td>
                            <td class="text-right">
                                <fmt:formatNumber value="${detail.pu * detail.quantite}" maxFractionDigits="2" minFractionDigits="2"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="4" class="text-right">Montant Total(avec remise 10% si il y en a):</td>
                        <td class="text-right total-amount">
                            <fmt:formatNumber value="${devis.montantTotal}" maxFractionDigits="2" minFractionDigits="2"/> Ar
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <%-- Section Statuts du Devis --%>
        <div class="card" style="padding: 20px; margin-top: 20px;">
            <h3 style="margin-top:0;"><i class="fas fa-flag"></i> Statut du Devis</h3>

            <%-- Statut actuel --%>
            <div style="margin-bottom: 20px;">
                <strong>Statut actuel : </strong>
                <c:choose>
                    <c:when test="${not empty devis.dernierStatut}">
                        <span class="badge" style="font-size:1rem;">${devis.dernierStatut.statutDevis.nom}</span>
                        <span style="opacity:0.6; font-size:0.85rem; margin-left:8px;">
                            le ${devis.dernierStatut.dateStatut}
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span style="opacity:0.5;">Aucun statut</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Formulaire de changement de statut --%>
            <form method="post" action="${pageContext.request.contextPath}/admin/devis/statut/${devis.id}"
                  style="display:flex; gap:10px; align-items:center; flex-wrap:wrap; margin-bottom:20px;">
                <label style="font-weight:600;"><i class="fas fa-exchange-alt"></i> Changer le statut :</label>
                <select name="statutDevisId" class="form-control" style="width:auto; min-width:180px;">
                    <c:forEach var="s" items="${statuts}">
                        <option value="${s.id}"
                            ${devis.dernierStatut != null && devis.dernierStatut.statutDevis.id == s.id ? 'selected' : ''}>
                            ${s.nom}
                        </option>
                    </c:forEach>
                </select>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> Valider
                </button>
            </form>

            <%-- Historique des statuts --%>
            <h4 style="margin-bottom:10px; opacity:0.8;"><i class="fas fa-history"></i> Historique des statuts</h4>
            <table class="details-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Statut</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ds" items="${devis.devisStatuts}" varStatus="s">
                        <tr>
                            <td>${s.index + 1}</td>
                            <td><span class="badge">${ds.statutDevis.nom}</span></td>
                            <td>${ds.dateStatut}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty devis.devisStatuts}">
                        <tr><td colspan="3" style="text-align:center; opacity:0.5;">Aucun historique.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="actions-bar">
            <a href="${pageContext.request.contextPath}/admin/devis" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Retour à la liste
            </a>
            <a href="${pageContext.request.contextPath}/admin/devis/delete/${devis.id}"
               class="btn btn-danger"
               onclick="return confirm('Supprimer ce devis ?')">
                <i class="fas fa-trash"></i> Supprimer
            </a>
        </div>
    </div>
</body>
</html>
