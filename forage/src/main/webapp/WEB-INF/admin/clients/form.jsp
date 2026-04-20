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
        
        <div class="card">
            <form action="${pageContext.request.contextPath}/admin/clients" method="post">
                <input type="hidden" name="id" value="${client.id}">
                
                <div class="form-group">
                    <label for="nom">Nom</label>
                    <input type="text" id="nom" name="nom" value="${client.nom}" required placeholder="Entrez le nom du client">
                </div>
                
                <div class="form-group">
                    <label for="contact">Contact</label>
                    <input type="text" id="contact" name="contact" value="${client.contact}" required placeholder="Email ou téléphone">
                </div>
                
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">${client.id == 0 ? "Enregistrer" : "Modifier"}</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
