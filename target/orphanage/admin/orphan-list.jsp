<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Orphan List</title></head>
<body>
<h2>All Orphans</h2>
<a href="${pageContext.request.contextPath}/admin/orphan?action=add">Add New Orphan</a>
<table border="1">
    <tr><th>ID</th><th>Name</th><th>Age</th><th>Actions</th></tr>
    <c:forEach var="o" items="${orphans}">
        <tr>
            <td>${o.id}</td>
            <td>${o.name}</td>
            <td>${o.age}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/orphan?action=edit&id=${o.id}">Edit</a>
                <a href="${pageContext.request.contextPath}/admin/orphan?action=delete&id=${o.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>