<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Types de Devis</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container">
        <div class="header-actions">
            <h1>Types de Devis</h1>
            <a href="${pageContext.request.contextPath}/admin/type_devis/create" class="btn btn-primary">Nouveau Type</a>
        </div>
        
        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${types}">
                        <tr>
                            <td>${t.id}</td>
                            <td>${t.nom}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/type_devis/edit/${t.id}" class="btn btn-sm btn-primary">Modifier</a>
                                <a href="${pageContext.request.contextPath}/admin/type_devis/delete/${t.id}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer ?')">Supprimer</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
