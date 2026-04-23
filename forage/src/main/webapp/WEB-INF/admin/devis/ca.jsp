<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Financier & Demandes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Dashboard Administrateur</h1>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-hand-holding-usd"></i></div>
                <div class="stat-label">Chiffre d'Affaire Total</div>
                <div class="stat-value">
                    <fmt:formatNumber value="${totalCA}" type="currency" currencySymbol="Ar"/>
                </div>
            </div>

            <a href="${pageContext.request.contextPath}/admin/devis" class="stat-card">
                <div class="stat-icon"><i class="fas fa-file-invoice-dollar"></i></div>
                <div class="stat-label">Nombre de Devis</div>
                <div class="stat-value">${nbDevis}</div>
            </a>

            <a href="${pageContext.request.contextPath}/admin/clients" class="stat-card">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-label">Nombre de Clients</div>
                <div class="stat-value">${nbClients}</div>
            </a>
        </div>

        <h3>Répartition par Statut</h3>
        <div class="status-grid">
            <c:forEach var="entry" items="${demandeStatutCounts}">
                <a href="${pageContext.request.contextPath}/admin/demande?statutId=${entry.key.id}" class="status-card">
                    <div class="stat-label">${entry.key.nom}</div>
                    <div class="stat-value">${entry.value}</div>
                </a>
            </c:forEach>
        </div>
    </div>
</body>
</html>
