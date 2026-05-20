<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Donors</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Donors</h1>
        <p class="lead">Manage individual and corporate supporters.</p>
    </div>
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <div class="actions-row">
            <a class="btn" href="${pageContext.request.contextPath}/donor/list?action=add">Add donor</a>
        </div>
    </c:if>
    <div class="table-wrap">
        <table class="data-table">
            <thead>
            <tr><th>ID</th><th>Full name</th><th>Email</th><th>Phone</th><th>Type</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach var="d" items="${donors}">
                <tr>
                    <td>${d.id}</td>
                    <td><c:out value="${d.full_name}"/></td>
                    <td><c:out value="${d.email}"/></td>
                    <td><c:out value="${d.phone}"/></td>
                    <td><c:out value="${d.donor_type}"/></td>
                    <td>
                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                            <a class="btn btn-sm btn-secondary" href="?action=edit&id=${d.id}">Edit</a>
                            <a class="btn btn-sm btn-danger" href="?action=delete&id=${d.id}" onclick="return confirm('Delete this donor?');">Delete</a>
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
