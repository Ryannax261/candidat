<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <span class="brand-text">ETU003505</span>
            </a>
            <div class="navbar-nav">
                <a href="${pageContext.request.contextPath}/admin/clients" class="nav-link admin">
                    <i class="fas fa-users"></i> Clients
                </a>
                <a href="${pageContext.request.contextPath}/admin/demande" class="nav-link admin">
                    <i class="fas fa-clipboard-list"></i> Demandes
                </a>
                <a href="${pageContext.request.contextPath}/admin/statut" class="nav-link admin">
                    <i class="fas fa-tasks"></i> Statuts
                </a>
                <a href="${pageContext.request.contextPath}/admin/type_devis" class="nav-link admin">
                    <i class="fas fa-tags"></i> Types Devis
                </a>
                <a href="${pageContext.request.contextPath}/admin/devis" class="nav-link admin">
                    <i class="fas fa-file-invoice-dollar"></i> Devis
                </a>
                <a href="${pageContext.request.contextPath}/admin/statut_devis" class="nav-link admin">
                    <i class="fas fa-flag"></i> Statuts Devis
                </a>
            </div>
        </div>
    </nav>

    <style>
        .navbar-brand {
            font-size: 3.0rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

    </style>