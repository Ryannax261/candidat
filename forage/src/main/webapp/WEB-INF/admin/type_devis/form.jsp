<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${type.id == 0 ? "Nouveau Type de Devis" : "Modifier Type de Devis"}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>${type.id == 0 ? "Nouveau Type de Devis" : "Modifier Type de Devis"}</h1>
            <a href="${pageContext.request.contextPath}/admin/type_devis" class="btn btn-secondary">Retour</a>
        </div>
        
        <div class="card">
            <form action="${pageContext.request.contextPath}/admin/type_devis" method="post">
                <input type="hidden" name="id" value="${type.id}">
                
                <div class="form-group">
                    <label for="nom">Nom du Type</label>
                    <input type="text" id="nom" name="nom" value="${type.nom}" required placeholder="Ex: Devis Standard, Devis Premium">
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">${type.id == 0 ? "Enregistrer" : "Modifier"}</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
