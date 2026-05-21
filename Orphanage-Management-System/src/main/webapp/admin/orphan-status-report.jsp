<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Orphan status report</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Children status summary</h1>
        <p class="lead">Distribution of active, inactive, and adopted records for capacity and placement planning.</p>
    </div>

    <div class="stats">
        <div class="stat-card"><strong>${orphanTotal}</strong><span class="label">Total children on record</span></div>
        <div class="stat-card"><strong>${statusCounts.active}</strong><span class="label">Active in care</span></div>
        <div class="stat-card"><strong>${statusCounts.inactive}</strong><span class="label">Inactive</span></div>
        <div class="stat-card"><strong>${statusCounts.adopted}</strong><span class="label">Adopted</span></div>
    </div>

    <section class="admin-section">
        <h2>Status distribution</h2>
        <div class="chart-card">
            <div class="css-bar-chart css-bar-chart-single">
                <div class="css-bar-groups">
                    <div class="css-bar-group">
                        <div class="css-bar-cluster">
                            <div class="css-bar css-swatch-brand css-bar-wide"
                                 style="height:${statusCounts.active * 100 / chartMax}%"
                                 title="Active: ${statusCounts.active}"></div>
                        </div>
                        <span class="css-bar-label">Active</span>
                        <span class="css-bar-value">${statusCounts.active}</span>
                    </div>
                    <div class="css-bar-group">
                        <div class="css-bar-cluster">
                            <div class="css-bar css-swatch-slate css-bar-wide"
                                 style="height:${statusCounts.inactive * 100 / chartMax}%"
                                 title="Inactive: ${statusCounts.inactive}"></div>
                        </div>
                        <span class="css-bar-label">Inactive</span>
                        <span class="css-bar-value">${statusCounts.inactive}</span>
                    </div>
                    <div class="css-bar-group">
                        <div class="css-bar-cluster">
                            <div class="css-bar css-swatch-accent css-bar-wide"
                                 style="height:${statusCounts.adopted * 100 / chartMax}%"
                                 title="Adopted: ${statusCounts.adopted}"></div>
                        </div>
                        <span class="css-bar-label">Adopted</span>
                        <span class="css-bar-value">${statusCounts.adopted}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="table-wrap">
            <table class="data-table">
                <thead><tr><th>Status</th><th>Count</th><th>Percentage</th></tr></thead>
                <tbody>
                <tr><td>Active</td><td>${statusCounts.active}</td><td><c:out value="${orphanTotal > 0 ? (statusCounts.active * 100 / orphanTotal) : 0}"/>%</td></tr>
                <tr><td>Inactive</td><td>${statusCounts.inactive}</td><td><c:out value="${orphanTotal > 0 ? (statusCounts.inactive * 100 / orphanTotal) : 0}"/>%</td></tr>
                <tr><td>Adopted</td><td>${statusCounts.adopted}</td><td><c:out value="${orphanTotal > 0 ? (statusCounts.adopted * 100 / orphanTotal) : 0}"/>%</td></tr>
                </tbody>
            </table>
        </div>
    </section>

    <div class="form-actions">
        <a class="btn" href="${pageContext.request.contextPath}/admin/orphan">Manage children</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/donation-report">Donation report</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
