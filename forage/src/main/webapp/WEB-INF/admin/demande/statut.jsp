<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suivi Statut - ${demande.client.nom}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .status-history {
            margin-top: 2rem;
        }
        .status-form {
            background-color: #f8f9fa;
            padding: 2rem;
            border-radius: 8px;
            margin-bottom: 2rem;
        }
        .demande-info {
            background-color: #e9ecef;
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }
        .info-item label {
            font-weight: bold;
            display: block;
            color: #6c757d;
            font-size: 0.9rem;
        }
        .info-item span {
            font-size: 1.1rem;
            color: #212529;
        }
        .badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
        }
        .badge-current {
            background-color: #0d6efd;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Suivi de Statut</h1>
            <a href="${pageContext.request.contextPath}/admin/demande" class="btn btn-secondary">Retour à la liste</a>
        </div>

        <div class="demande-info">
            <div class="info-item">
                <label>Client</label>
                <span>${demande.client.nom}</span>
            </div>
            <div class="info-item">
                <label>District</label>
                <span>${demande.district}</span>
            </div>
            <div class="info-item">
                <label>Date Demande</label>
                <span>${demande.dateDemandeFormatee}</span>
            </div>
            <div class="info-item">
                <label>Description</label>
                <span>${demande.description}</span>
            </div>
        </div>

        <div class="card status-form">
            <h3>Changer le statut</h3>
            <form action="${pageContext.request.contextPath}/admin/demande/${demande.id}/statut" method="post">
                <div class="form-group">
                    <label for="statutId">Nouveau Statut</label>
                    <select name="statutId" id="statutId" class="form-control" required>
                        <c:forEach var="s" items="${statuts}">
                            <option value="${s.id}" ${demande.dernierStatut.statut.id == s.id ? 'selected' : ''}>
                                ${s.nom}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateStatut">Date et Heure du statut</label>
                    <input type="datetime-local" name="dateStatut" id="dateStatut" class="form-control">
                    <small class="text-muted">Laissez vide pour utiliser l'heure actuelle</small>
                </div>
                <div class="form-group">
                    <label for="observation">Observation</label>
                    <textarea name="observation" id="observation" class="form-control" rows="3" placeholder="Ex: Manque de budget, En attente de validation..."></textarea>
                </div>
                <div style="text-align: right; margin-top: 1rem;">
                    <button type="submit" class="btn btn-primary">Mettre à jour</button>
                </div>
            </form>
        </div>

        <div class="card status-history">
            <h3>Historique des statuts</h3>
            <table>
                <thead>
                    <tr>
                        <th>Statut</th>
                        <th>Date & Heure</th>
                        <th>Observation</th>
                        <th style="text-align: right;">Durée (Total)</th>
                        <th style="text-align: right;">Durée (Ouvrée)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="h" items="${history}">
                        <tr style="${h.current ? 'background: #f0f7ff;' : ''}">
                            <td>
                                <span class="badge ${h.current ? 'badge-current' : ''}" style="font-size: 0.8rem;">
                                    ${h.statutNom}
                                </span>
                            </td>
                            <td style="color: #666;">${h.dateStatutFormatee}</td>
                            <td><small>${not empty h.observation ? h.observation : '-'}</small></td>
                            <td style="text-align: right; font-weight: 500;">${h.durationTotal}</td>
                            <td style="text-align: right; font-weight: 600; color: #dc3545;">${h.durationWork}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
