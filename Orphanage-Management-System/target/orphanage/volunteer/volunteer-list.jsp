<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Volunteers</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Volunteers</h1>
        <p class="lead">Skills, availability, and volunteer status.</p>
    </div>
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <div class="actions-row">
            <a class="btn" href="${pageContext.request.contextPath}/volunteer/list?action=add">Add volunteer</a>
        </div>
    </c:if>
    <div class="table-wrap">
        <table class="data-table">
            <thead>
            <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Skill</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach var="v" items="${volunteers}">
                <tr>
                    <td>${v.id}</td>
                    <td><c:out value="${v.full_name}"/></td>
                    <td><c:out value="${v.email}"/></td>
                    <td><c:out value="${v.phone}"/></td>
                    <td><c:out value="${v.skill_area}"/></td>
                    <td><c:out value="${v.status}"/></td>
                    <td>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a class="btn btn-sm btn-secondary" href="?action=edit&id=${v.id}">Edit</a>
                            <a class="btn btn-sm btn-danger" href="?action=delete&id=${v.id}" onclick="return confirm('Delete this volunteer?');">Delete</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
