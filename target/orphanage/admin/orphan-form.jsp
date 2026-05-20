<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Orphan Form</title></head>
<body>
<h2><c:if test="${empty orphan}">Add</c:if><c:if test="${not empty orphan}">Edit</c:if> Orphan</h2>
<form method="post" action="${pageContext.request.contextPath}/admin/orphan">
    <c:if test="${empty orphan}">
        <input type="hidden" name="action" value="create">
    </c:if>
    <c:if test="${not empty orphan}">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${orphan.id}">
    </c:if>
    Name: <input type="text" name="name" value="${orphan.name}" required><br>
    Age: <input type="number" name="age" value="${orphan.age}" required><br>
    <input type="submit" value="Save">
    <a href="${pageContext.request.contextPath}/admin/orphan">Cancel</a>
</form>
</body>
</html>