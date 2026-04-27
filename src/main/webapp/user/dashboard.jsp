<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard — Orphanage MS</title>
    <meta name="description" content="Overview of the Orphanage Management System." />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css" />
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/user/dashboard" class="navbar-brand">
            <div class="logo-icon">&#x1F3E0;</div>
            Orphanage MS
        </a>
        <ul class="navbar-links">
            <li><a href="${pageContext.request.contextPath}/user/dashboard" class="active">&#x1F4CA; Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/donors">&#x1F465; Donors</a></li>
            <li><a href="${pageContext.request.contextPath}/donate">&#x1F4B0; Donate</a></li>
            <li><a href="${pageContext.request.contextPath}/request-resource">&#x1F4E6; Resources</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">&#x1F6AA; Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">

    <!-- ======== Welcome Banner ======== -->
    <div class="welcome-banner animate-in">
        <div class="welcome-text">
            <h1>Welcome back, <span class="highlight"><c:out value="${sessionScope.user.fullName}" /></span> &#x1F44B;</h1>
            <p>Here's what's happening in your orphanage management system.</p>
        </div>
        <div class="welcome-meta">
            <span class="role-badge"><c:out value="${sessionScope.user.role}" /></span>
        </div>
    </div>

    <!-- ======== Stat Cards ======== -->
    <div class="stats-grid">
        <div class="stat-card animate-in" style="--delay:.05s">
            <div class="stat-icon icon-donors">&#x1F465;</div>
            <div class="stat-body">
                <span class="stat-label">Total Donors</span>
                <span class="stat-value">${totalDonors}</span>
            </div>
        </div>
        <div class="stat-card animate-in" style="--delay:.1s">
            <div class="stat-icon icon-amount">&#x1F4B0;</div>
            <div class="stat-body">
                <span class="stat-label">Total Donated</span>
                <span class="stat-value">Rs. <fmt:formatNumber value="${totalDonatedAmount}" pattern="#,##0.00" /></span>
            </div>
        </div>
        <div class="stat-card animate-in" style="--delay:.15s">
            <div class="stat-icon icon-txns">&#x1F4DD;</div>
            <div class="stat-body">
                <span class="stat-label">Donations Made</span>
                <span class="stat-value">${totalDonations}</span>
            </div>
        </div>
        <div class="stat-card animate-in" style="--delay:.2s">
            <div class="stat-icon icon-users">&#x1F464;</div>
            <div class="stat-body">
                <span class="stat-label">System Users</span>
                <span class="stat-value">${totalUsers}</span>
            </div>
        </div>
    </div>

    <!-- ======== My Activity (personal stats) ======== -->
    <div class="my-activity animate-in" style="--delay:.25s">
        <div class="activity-item">
            <span class="activity-icon">&#x1F4B5;</span>
            <div>
                <span class="activity-label">My Donations</span>
                <span class="activity-value">${myDonationCount} donation<c:if test="${myDonationCount != 1}">s</c:if></span>
            </div>
        </div>
        <div class="activity-divider"></div>
        <div class="activity-item">
            <span class="activity-icon">&#x1F4B8;</span>
            <div>
                <span class="activity-label">My Total Contributed</span>
                <span class="activity-value">Rs. <fmt:formatNumber value="${myDonationTotal}" pattern="#,##0.00" /></span>
            </div>
        </div>
    </div>

    <!-- ======== Quick Actions ======== -->
    <div class="section-header animate-in" style="--delay:.3s">
        <h2>Quick Actions</h2>
    </div>
    <div class="actions-grid animate-in" style="--delay:.35s">
        <a href="${pageContext.request.contextPath}/donors?action=new" class="action-card">
            <span class="action-icon">&#x2795;</span>
            <span class="action-text">Add Donor</span>
        </a>
        <a href="${pageContext.request.contextPath}/donors" class="action-card">
            <span class="action-icon">&#x1F4CB;</span>
            <span class="action-text">View Donors</span>
        </a>
        <a href="${pageContext.request.contextPath}/donate" class="action-card">
            <span class="action-icon">&#x1F4B5;</span>
            <span class="action-text">Make Donation</span>
        </a>
        <a href="${pageContext.request.contextPath}/request-resource" class="action-card">
            <span class="action-icon">&#x1F4E6;</span>
            <span class="action-text">Request Resource</span>
        </a>
    </div>

    <!-- ======== Two-Column: Recent Donations + Breakdown ======== -->
    <div class="dashboard-grid">

        <!-- Recent Donations -->
        <div class="card animate-in" style="--delay:.4s">
            <div class="card-top">
                <h2>&#x1F4CB; Recent Donations</h2>
            </div>
            <div class="card-content">
                <c:choose>
                    <c:when test="${not empty recentDonations}">
                        <table class="dash-table">
                            <thead>
                            <tr>
                                <th>Donor</th>
                                <th>Amount</th>
                                <th>Method</th>
                                <th>Date</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="d" items="${recentDonations}">
                                <tr>
                                    <td class="cell-name">
                                        <div class="avatar">${d.donorName.substring(0,1)}</div>
                                        <c:out value="${d.donorName}" />
                                    </td>
                                    <td class="cell-amount">Rs. <fmt:formatNumber value="${d.amount}" pattern="#,##0.00" /></td>
                                    <td><span class="badge badge-method">${d.method}</span></td>
                                    <td class="cell-muted"><fmt:formatDate value="${d.date}" pattern="dd MMM yyyy" /></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-box">
                            <span>&#x1F4AD;</span>
                            <p>No donations recorded yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Donation Breakdown by Type -->
        <div class="card animate-in" style="--delay:.45s">
            <div class="card-top">
                <h2>&#x1F4CA; Donation Breakdown</h2>
            </div>
            <div class="card-content">
                <c:choose>
                    <c:when test="${not empty donationBreakdown}">
                        <div class="breakdown-list">
                            <c:forEach var="b" items="${donationBreakdown}">
                                <div class="breakdown-row">
                                    <div class="breakdown-left">
                                        <div class="dot ${b.type == 'MONETARY' ? 'dot-monetary' : 'dot-inkind'}"></div>
                                        <div>
                                            <div class="breakdown-type">${b.type}</div>
                                            <div class="breakdown-count">${b.count} donor<c:if test="${b.count != 1}">s</c:if></div>
                                        </div>
                                    </div>
                                    <div class="breakdown-amt">
                                        Rs. <fmt:formatNumber value="${b.total}" pattern="#,##0.00" />
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-box">
                            <span>&#x1F4AD;</span>
                            <p>No data available yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

    <!-- ======== Top Donors ======== -->
    <div class="card animate-in" style="--delay:.5s">
        <div class="card-top">
            <h2>&#x1F3C6; Top Donors</h2>
            <a href="${pageContext.request.contextPath}/donors" class="card-link">View All &rarr;</a>
        </div>
        <div class="card-content">
            <c:choose>
                <c:when test="${not empty topDonors}">
                    <table class="dash-table">
                        <thead>
                        <tr>
                            <th class="th-rank">Rank</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Type</th>
                            <th>Total Donated</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="td" items="${topDonors}" varStatus="loop">
                            <tr>
                                <td class="cell-rank">
                                    <c:choose>
                                        <c:when test="${loop.index == 0}"><span class="medal">&#x1F947;</span></c:when>
                                        <c:when test="${loop.index == 1}"><span class="medal">&#x1F948;</span></c:when>
                                        <c:when test="${loop.index == 2}"><span class="medal">&#x1F949;</span></c:when>
                                        <c:otherwise>#${loop.index + 1}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="cell-name">
                                    <div class="avatar">${td.name.substring(0,1)}</div>
                                    <c:out value="${td.name}" />
                                </td>
                                <td class="cell-muted"><c:out value="${td.email}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${td.type == 'MONETARY'}">
                                            <span class="badge badge-purple">&#x1F4B5; Monetary</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-orange">&#x1F381; In-Kind</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="cell-amount">Rs. <fmt:formatNumber value="${td.totalDonated}" pattern="#,##0.00" /></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-box">
                        <span>&#x1F4AD;</span>
                        <p>No donors registered yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        &copy; 2026 Orphanage Management System. All rights reserved.
    </div>
</footer>

</body>
</html>
