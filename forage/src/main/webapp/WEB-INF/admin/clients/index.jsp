<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Clients</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Gestion des Clients</h1>
            <a href="${pageContext.request.contextPath}/admin/clients/create" class="btn btn-primary">Nouveau Client</a>
        </div>
        
        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="client" items="${clients}">
                        <tr>
                            <td>${client.nom}</td>
                            <td>${client.contact}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/demande?clientId=${client.id}" class="btn btn-sm btn-info">
                                    <i class="fas fa-list"></i> Voir demandes
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/clients/edit/${client.id}" class="btn btn-sm btn-primary">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/clients/delete/${client.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer ?')">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
