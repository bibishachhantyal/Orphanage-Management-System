<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Donation analysis report</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Donation analysis report</h1>
        <p class="lead">Financial overview and payment breakdown to support fundraising decisions.</p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <strong>${totalDonations}</strong>
            <span class="label">Total donations recorded</span>
        </div>
        <div class="stat-card">
            <strong>NRs. <fmt:formatNumber value="${totalAmount}" maxFractionDigits="0"/></strong>
            <span class="label">Total amount raised</span>
        </div>
        <div class="stat-card">
            <strong>NRs. <fmt:formatNumber value="${totalDonations > 0 ? totalAmount / totalDonations : 0}" maxFractionDigits="0"/></strong>
            <span class="label">Average per donation</span>
        </div>
    </div>

    <section class="admin-section">
        <h2>Amount by payment method</h2>
        <c:choose>
            <c:when test="${empty paymentBreakdown}">
                <p class="lead">No donation data recorded yet.</p>
            </c:when>
            <c:otherwise>
                <div class="chart-card">
                    <div class="css-bar-chart css-bar-chart-single">
                        <div class="css-bar-groups">
                            <c:forEach var="entry" items="${paymentBreakdown}">
                                <div class="css-bar-group">
                                    <div class="css-bar-cluster">
                                        <div class="css-bar css-swatch-brand css-bar-wide"
                                             style="height:${entry.value * 100 / chartMax}%"
                                             title="${entry.key}: NRs. ${entry.value}"></div>
                                    </div>
                                    <span class="css-bar-label"><c:out value="${entry.key}"/></span>
                                    <span class="css-bar-value">NRs. <fmt:formatNumber value="${entry.value}" maxFractionDigits="0"/></span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead><tr><th>Payment method</th><th>Total (NRs.)</th><th>Share</th></tr></thead>
                        <tbody>
                        <c:forEach var="entry" items="${paymentBreakdown}">
                            <tr>
                                <td><c:out value="${entry.key}"/></td>
                                <td><fmt:formatNumber value="${entry.value}" maxFractionDigits="0"/></td>
                                <td><fmt:formatNumber value="${totalAmount > 0 ? (entry.value / totalAmount) * 100 : 0}" maxFractionDigits="1"/>%</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="admin-section">
        <h2>Recent donations</h2>
        <c:choose>
            <c:when test="${empty recentDonations}">
                <p class="lead">No recent entries.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                        <tr><th>Date</th><th>Amount (NRs.)</th><th>Payment</th><th>Purpose</th><th>Child ID</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="d" items="${recentDonations}">
                            <tr>
                                <td><c:out value="${d.donation_date}"/></td>
                                <td><fmt:formatNumber value="${d.amount}" maxFractionDigits="0"/></td>
                                <td><c:out value="${d.payment_method}"/></td>
                                <td><c:out value="${d.purpose}"/></td>
                                <td><c:out value="${d.orphan_id > 0 ? d.orphan_id : 'General'}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <div class="form-actions">
        <a class="btn" href="${pageContext.request.contextPath}/admin/orphan-report">Orphan status report</a>
        <a class="btn" href="${pageContext.request.contextPath}/admin/volunteer-report">Volunteer report</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/dashboard">Admin dashboard</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/donation/list">Donation list</a>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
