<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Volunteer activity report</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Volunteer activity report</h1>
        <p class="lead">Volunteer roster status and pending applications for staffing decisions.</p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <strong>
                <c:set var="volTotal" value="0"/>
                <c:forEach var="entry" items="${statusCounts}"><c:set var="volTotal" value="${volTotal + entry.value}"/></c:forEach>
                ${volTotal}
            </strong>
            <span class="label">Registered volunteers</span>
        </div>
        <div class="stat-card"><strong>${pendingApplications}</strong><span class="label">Pending applications</span></div>
    </div>

    <section class="admin-section">
        <h2>Volunteers by status</h2>
        <c:choose>
            <c:when test="${empty statusCounts}">
                <p class="lead">No volunteers on record yet.</p>
            </c:when>
            <c:otherwise>
                <div class="chart-card">
                    <div class="css-bar-chart css-bar-chart-single">
                        <div class="css-bar-groups">
                            <c:forEach var="entry" items="${statusCounts}">
                                <div class="css-bar-group">
                                    <div class="css-bar-cluster">
                                        <div class="css-bar css-swatch-teal css-bar-wide"
                                             style="height:${entry.value * 100 / chartMax}%"
                                             title="${entry.key}: ${entry.value}"></div>
                                    </div>
                                    <span class="css-bar-label"><c:out value="${entry.key}"/></span>
                                    <span class="css-bar-value">${entry.value}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead><tr><th>Status</th><th>Count</th></tr></thead>
                        <tbody>
                        <c:forEach var="entry" items="${statusCounts}">
                            <tr><td><c:out value="${entry.key}"/></td><td>${entry.value}</td></tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <div class="form-actions">
        <a class="btn" href="${pageContext.request.contextPath}/volunteer/list">Manage volunteers</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/donation-report">Donation report</a>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
