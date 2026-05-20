<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Donations</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Donations</h1>
        <p class="lead">Track amounts, purposes, and linked children.</p>
    </div>
    <c:if test="${sessionScope.user.role == 'ADMIN'}">
        <div class="actions-row">
            <a class="btn" href="${pageContext.request.contextPath}/donation/list?action=add">Add donation</a>
        </div>
    </c:if>
    <div class="table-wrap">
        <table class="data-table">
            <thead>
            <tr><th>ID</th><th>Donor</th><th>Child</th><th>Amount</th><th>Date</th><th>Method</th><th>Purpose</th>
                <c:if test="${sessionScope.user.role == 'ADMIN'}"><th>Actions</th></c:if>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="d" items="${donations}">
                <tr>
                    <td>${d.id}</td>
                    <td><c:out value="${donorNames[d.donor_id]}"/></td>
                    <td><c:choose><c:when test="${d.orphan_id == 0}">General</c:when><c:otherwise><c:out value="${orphanNames[d.orphan_id]}"/></c:otherwise></c:choose></td>
                    <td>NRs. <fmt:formatNumber value="${d.amount}" type="number" maxFractionDigits="2"/></td>
                    <td><c:out value="${d.donation_date}"/></td>
                    <td><c:out value="${d.payment_method}"/></td>
                    <td><c:out value="${d.purpose}"/></td>
                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <td>
                            <a class="btn btn-sm btn-secondary" href="?action=edit&id=${d.id}">Edit</a>
                            <a class="btn btn-sm btn-danger" href="?action=delete&id=${d.id}" onclick="return confirm('Delete this donation?');">Delete</a>
                        </td>
                    </c:if>
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
