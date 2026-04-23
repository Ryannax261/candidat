<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${client.id == 0 ? "Nouveau Client" : "Modifier Client"}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>${client.id == 0 ? "Nouveau Client" : "Modifier Client"}</h1>
            <a href="${pageContext.request.contextPath}/admin/clients" class="btn btn-secondary">Retour</a>
        </div>
        
        <div class="card" style="padding: 2.5rem; max-width: 600px;">
            <form action="${pageContext.request.contextPath}/admin/clients" method="post">
                <input type="hidden" name="id" value="${client.id}">
                
                <div class="form-group">
                    <label for="nom">Nom</label>
                    <input type="text" id="nom" name="nom" value="${client.nom}" required placeholder="Ex: Jean Dupont">
                </div>
                
                <div class="form-group">
                    <label for="contact">Contact</label>
                    <input type="text" id="contact" name="contact" value="${client.contact}" required placeholder="Ex: +261 34 00 000 00">
                </div>
                
                <div class="form-group" style="margin-top: 2rem;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> ${client.id == 0 ? "Enregistrer" : "Confirmer les modifications"}
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/clients" class="btn btn-secondary">Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
