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

        <div class="header-actions">
            <div>
                <span class="stat-label" style="display: block; margin-bottom: 0.5rem; text-align: left;">Détail du Document</span>
                <h1>Devis #${devis.id}</h1>
            </div>
            <div style="display: flex; gap: 1rem;">
                <a href="${pageContext.request.contextPath}/admin/devis" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Retour
                </a>
                <a href="${pageContext.request.contextPath}/admin/devis/delete/${devis.id}"
                   class="btn btn-danger"
                   onclick="return confirm('Supprimer ce devis ?')">
                    <i class="fas fa-trash"></i> Supprimer
                </a>
            </div>
        </div>

        <div class="info-grid">
            <div class="info-box">
                <label>Client</label>
                <span>${devis.demande.client.nom}</span>
            </div>
            <div class="info-box">
                <label>District / Lieu</label>
                <span>${devis.demande.district}</span>
            </div>
            <div class="info-box">
                <label>Type de Devis</label>
                <span>${devis.typeDevis.nom}</span>
            </div>
            <div class="info-box">
                <label>Date de Création</label>
                <span>
                    <fmt:parseDate value="${devis.dateDevis}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                </span>
            </div>
        </div>

        <div class="section-title">Détails des Prestations</div>
        <div class="card">
            <table class="details-table">
                <thead>
                    <tr>
                        <th>Libellé</th>
                        <th style="text-align: right;">Prix Unitaire</th>
                        <th style="text-align: right;">Quantité</th>
                        <th style="text-align: right;">Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="detail" items="${devis.details}">
                        <tr>
                            <td><strong>${detail.libelle}</strong></td>
                            <td style="text-align: right;">
                                <fmt:formatNumber value="${detail.pu}" maxFractionDigits="2" minFractionDigits="2"/> Ar
                            </td>
                            <td style="text-align: right;">${detail.quantite}</td>
                            <td style="text-align: right; font-weight: 500;">
                                <fmt:formatNumber value="${detail.pu * detail.quantite}" maxFractionDigits="2" minFractionDigits="2"/> Ar
                            </td>
                        </tr>
                    </c:forEach>
                    <tr style="background: var(--bg-subtle);">
                        <td colspan="3" style="text-align: right; font-weight: 600; padding: 1.5rem;">Total Général (Remise incluse si applicable) :</td>
                        <td style="text-align: right; font-size: 1.2rem; font-weight: 700; color: var(--accent); padding: 1.5rem;">
                            <fmt:formatNumber value="${devis.montantTotal}" maxFractionDigits="2" minFractionDigits="2"/> Ar
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="section-title">Suivi & État du Dossier</div>
        <div class="grid" style="display: grid; grid-template-columns: 1fr 1.5fr; gap: 2rem; align-items: start;">
            
            <div class="card" style="padding: 2rem;">
                <h3 style="margin-bottom: 1.5rem; font-weight: 500;">Changer le statut</h3>
                <form method="post" action="${pageContext.request.contextPath}/admin/devis/statut/${devis.id}">
                    <div class="form-group">
                        <label>Choisir un nouvel état</label>
                        <select name="statutDevisId" style="margin-bottom: 1rem;">
                            <c:forEach var="s" items="${statuts}">
                                <option value="${s.id}"
                                    ${devis.dernierStatut != null && devis.dernierStatut.statutDevis.id == s.id ? 'selected' : ''}>
                                    ${s.nom}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Date et Heure du statut</label>
                        <input type="datetime-local" name="dateStatut" class="form-control" style="margin-bottom: 1.5rem;">
                        <small style="display: block; margin-top: -1rem; margin-bottom: 1.5rem; color: var(--text-muted); font-size: 0.75rem;">Laissez vide pour utiliser l'heure actuelle</small>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; justify-content: center;">
                        <i class="fas fa-sync-alt"></i> Mettre à jour le statut
                    </button>
                </form>
            </div>

            <div class="card" style="padding: 2rem;">
                <h3 style="margin-bottom: 1.5rem; font-weight: 500;">Historique des interventions</h3>
                <div class="history-list">
                    <table style="width: 100%; border-collapse: collapse; font-size: 0.85rem;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--bg-subtle);">
                                <th style="text-align: left; padding: 0.5rem;">Statut</th>
                                <th style="text-align: left; padding: 0.5rem;">Date</th>
                                <th style="text-align: right; padding: 0.5rem;">Écart (Total)</th>
                                <th style="text-align: right; padding: 0.5rem;">Écart (Ouvré)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="h" items="${history}">
                                <tr style="border-bottom: 1px solid var(--bg-subtle); ${h.current ? 'background: #fdf8f3;' : ''}">
                                    <td style="padding: 1rem 0.5rem;">
                                        <span class="badge" style="background: ${h.current ? 'var(--accent)' : 'var(--text-muted)'}; color: white; border: none; font-size: 0.7rem;">
                                            ${h.statutNom}
                                        </span>
                                    </td>
                                    <td style="padding: 1rem 0.5rem; color: var(--text-muted);">
                                        ${h.dateStatutFormatee}
                                    </td>
                                    <td style="padding: 1rem 0.5rem; text-align: right; font-weight: 500;">
                                        ${h.durationTotal}
                                    </td>
                                    <td style="padding: 1rem 0.5rem; text-align: right; font-weight: 600; color: var(--accent);">
                                        ${h.durationWork}
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${empty history}">
                        <p style="opacity: 0.5; font-style: italic; padding: 1rem; text-align: center;">Aucun historique disponible.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
