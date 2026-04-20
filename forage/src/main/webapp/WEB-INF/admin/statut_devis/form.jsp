<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty statut.id || statut.id == 0 ? 'Nouveau Statut Devis' : 'Modifier Statut Devis'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>
                <i class="fas fa-flag"></i>
                ${empty statut.id || statut.id == 0 ? 'Nouveau Statut Devis' : 'Modifier Statut Devis'}
            </h1>
        </div>

        <div class="card" style="max-width: 500px; padding: 30px;">
            <form method="post"
                  action="${pageContext.request.contextPath}/admin/statut_devis${statut.id != 0 ? '' : ''}">

                <div class="form-group">
                    <label for="nom"><i class="fas fa-tag"></i> Nom du statut</label>
                    <input type="text" id="nom" name="nom" value="${statut.nom}"
                           placeholder="Ex: Forage_cree" required class="form-control"/>
                    <small style="opacity:0.6;">Utilisez des noms sans espaces (ex: Forage_cree, Termine)</small>
                </div>

                <div style="display:flex; gap:10px; margin-top:20px;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Enregistrer
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/statut_devis" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
