<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="navbar">
    <div class="navbar-container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            <span class="brand-text">3505</span>
        </a>
        <div class="navbar-nav">
            <a href="${pageContext.request.contextPath}/admin/devis/chiffre-affaire" 
               class="nav-link ${requestScope['javax.servlet.forward.request_uri'].contains('chiffre-affaire') ? 'active' : ''}">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/clients" 
               class="nav-link ${requestScope['javax.servlet.forward.request_uri'].contains('clients') ? 'active' : ''}">
                <i class="fas fa-users"></i> Clients
            </a>
            <a href="${pageContext.request.contextPath}/admin/demande" 
               class="nav-link ${requestScope['javax.servlet.forward.request_uri'].contains('demande') ? 'active' : ''}">
                <i class="fas fa-clipboard-list"></i> Demandes
            </a>
            <a href="${pageContext.request.contextPath}/admin/devis" 
               class="nav-link ${requestScope['javax.servlet.forward.request_uri'].contains('devis') && !requestScope['javax.servlet.forward.request_uri'].contains('chiffre-affaire') ? 'active' : ''}">
                <i class="fas fa-file-invoice-dollar"></i> Devis
            </a>
            
            <div style="margin-top: 2rem; padding: 0.5rem 1rem; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--text-muted); opacity: 0.5;">Settings</div>
            
            <a href="${pageContext.request.contextPath}/admin/type_devis" class="nav-link">
                <i class="fas fa-tags"></i> Types Devis
            </a>
            <a href="${pageContext.request.contextPath}/admin/statut" class="nav-link">
                <i class="fas fa-tasks"></i> Statuts Demande
            </a>
            <a href="${pageContext.request.contextPath}/admin/statut_devis" class="nav-link">
                <i class="fas fa-flag"></i> Statuts Devis
            </a>
        </div>
    </div>
</nav>