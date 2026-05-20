<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin dashboard</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Welcome back, <c:out value="${sessionScope.user.username}"/></h1>
        <p class="lead">Administrator dashboard — manage the full orphanage system.</p>
    </div>

    <div class="stats">
        <div class="stat-card"><strong>${totalOrphans}</strong><span class="label">Total children</span></div>
        <div class="stat-card"><strong>${totalDonors}</strong><span class="label">Donors</span></div>
        <div class="stat-card"><strong>${totalVolunteers}</strong><span class="label">Volunteers</span></div>
        <div class="stat-card"><strong>NRs. <fmt:formatNumber value="${totalDonations}" maxFractionDigits="0"/></strong><span class="label">Donations</span></div>
    </div>

    <section class="admin-section stats-flow-section">
        <h2>Statistics flow — activity by time slot</h2>
        <p class="lead">Morning (06:00–11:59) · Afternoon (12:00–17:59) · Evening (18:00–23:59)</p>

        <div class="flowchart" role="img" aria-label="Admin statistics flow from visitors to donors and volunteers">
            <div class="flow-node flow-start">Public visitors</div>
            <div class="flow-arrow">↓</div>
            <div class="flow-row">
                <div class="flow-node">Browse children</div>
                <div class="flow-node">Contact form</div>
                <div class="flow-node">Register / volunteer</div>
            </div>
            <div class="flow-arrow">↓</div>
            <div class="flow-node flow-admin">Admin dashboard (you are here)</div>
            <div class="flow-arrow">↓</div>
            <div class="flow-row">
                <div class="flow-node">Donors &amp; donations</div>
                <div class="flow-node">Volunteers</div>
                <div class="flow-node">User approvals</div>
            </div>
        </div>

        <div class="chart-grid">
            <div class="chart-card">
                <h3>Activity by time slot</h3>
                <canvas id="slotChart" height="220" aria-label="Bar chart of morning, afternoon, and evening activity"></canvas>
            </div>
            <div class="chart-card">
                <h3>Statistics flow overview</h3>
                <canvas id="flowChart" height="220" aria-label="Line chart of total activity across categories"></canvas>
            </div>
        </div>

        <div class="slot-table-wrap">
            <table class="data-table slot-table">
                <thead>
                <tr>
                    <th>Category</th>
                    <th>Morning</th>
                    <th>Afternoon</th>
                    <th>Evening</th>
                    <th>Total</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Visitors (contact + applications)</td>
                    <td>${visitorSlots.morning}</td>
                    <td>${visitorSlots.afternoon}</td>
                    <td>${visitorSlots.evening}</td>
                    <td><strong>${visitorSlots.total}</strong></td>
                </tr>
                <tr>
                    <td>Donations recorded</td>
                    <td>${donorSlots.morning}</td>
                    <td>${donorSlots.afternoon}</td>
                    <td>${donorSlots.evening}</td>
                    <td><strong>${donorSlots.total}</strong></td>
                </tr>
                <tr>
                    <td>Volunteer applications</td>
                    <td>${volunteerSlots.morning}</td>
                    <td>${volunteerSlots.afternoon}</td>
                    <td>${volunteerSlots.evening}</td>
                    <td><strong>${volunteerSlots.total}</strong></td>
                </tr>
                <tr>
                    <td>User registrations</td>
                    <td>${userRegSlots.morning}</td>
                    <td>${userRegSlots.afternoon}</td>
                    <td>${userRegSlots.evening}</td>
                    <td><strong>${userRegSlots.total}</strong></td>
                </tr>
                </tbody>
            </table>
        </div>
    </section>

    <section class="admin-section meal-schedule-section">
        <h2>Children&rsquo;s daily meal times</h2>
        <div class="meal-grid">
            <article class="meal-card meal-breakfast">
                <h3>Breakfast</h3>
                <p class="meal-time">7:00 AM – 8:00 AM</p>
            </article>
            <article class="meal-card meal-lunch">
                <h3>Lunch</h3>
                <p class="meal-time">12:30 PM – 1:30 PM</p>
            </article>
            <article class="meal-card meal-dinner">
                <h3>Dinner</h3>
                <p class="meal-time">6:30 PM – 7:30 PM</p>
            </article>
        </div>
    </section>

    <div class="feature-grid">
        <div class="feature-box">
            <h3>Children</h3>
            <p>Add, edit, and view full records with photos and credentials.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/orphan">Manage</a>
        </div>
        <div class="feature-box">
            <h3>Donors</h3>
            <p>Individual and corporate supporters.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/donor/list">Manage</a>
        </div>
        <div class="feature-box">
            <h3>Volunteers</h3>
            <p>Skills, availability, and status.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/volunteer/list">Manage</a>
        </div>
        <div class="feature-box">
            <h3>Donations</h3>
            <p>Track amounts, purposes, and linked children.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/donation/list">Manage</a>
        </div>
        <div class="feature-box">
            <h3>Reports</h3>
            <p>Summary totals for coursework demo.</p>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/admin/donation-report">View report</a>
        </div>
        <div class="feature-box">
            <h3>Public site</h3>
            <p>What visitors see (active children only).</p>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/public/orphans">Open</a>
        </div>
    </div>

    <section class="admin-section">
        <h2>Pending user approvals</h2>
        <c:choose>
            <c:when test="${empty pendingUsers}">
                <p class="lead">No accounts awaiting approval.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                        <tr><th>Username</th><th>Email</th><th>Name</th><th>Phone</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${pendingUsers}">
                            <tr>
                                <td><c:out value="${u.username}"/></td>
                                <td><c:out value="${u.email}"/></td>
                                <td><c:out value="${u.fullName}"/></td>
                                <td><c:out value="${u.phone}"/></td>
                                <td>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/approvals" class="inline-form">
                                        <input type="hidden" name="action" value="approveUser">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <button type="submit" class="btn btn-sm">Approve</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/approvals" class="inline-form">
                                        <input type="hidden" name="action" value="rejectUser">
                                        <input type="hidden" name="id" value="${u.id}">
                                        <button type="submit" class="btn btn-sm btn-danger">Reject</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="admin-section">
        <h2>Volunteer applications</h2>
        <c:choose>
            <c:when test="${empty pendingVolunteerApps}">
                <p class="lead">No pending volunteer applications.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                        <tr><th>Name</th><th>Email</th><th>Skills</th><th>Availability</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="app" items="${pendingVolunteerApps}">
                            <tr>
                                <td><c:out value="${app.fullName}"/></td>
                                <td><c:out value="${app.email}"/></td>
                                <td><c:out value="${app.skillArea}"/></td>
                                <td><c:out value="${app.availability}"/></td>
                                <td>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/approvals" class="inline-form">
                                        <input type="hidden" name="action" value="approveVolunteer">
                                        <input type="hidden" name="id" value="${app.id}">
                                        <button type="submit" class="btn btn-sm">Approve</button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/approvals" class="inline-form">
                                        <input type="hidden" name="action" value="rejectVolunteer">
                                        <input type="hidden" name="id" value="${app.id}">
                                        <button type="submit" class="btn btn-sm btn-danger">Reject</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <section class="admin-section">
        <h2>Contact messages</h2>
        <c:choose>
            <c:when test="${empty contactMessages}">
                <p class="lead">No messages yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                        <tr><th>Date</th><th>From</th><th>Subject</th><th>Status</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="msg" items="${contactMessages}">
                            <tr>
                                <td><fmt:formatDate value="${msg.submittedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td><c:out value="${msg.name}"/> &lt;<c:out value="${msg.email}"/>&gt;</td>
                                <td><c:out value="${msg.subject}"/></td>
                                <td>
                                    <span class="badge ${msg.status == 'read' ? 'badge-adopted' : 'badge-inactive'}"><c:out value="${msg.status}"/></span>
                                </td>
                                <td>
                                    <c:if test="${msg.status != 'read'}">
                                        <form method="post" action="${pageContext.request.contextPath}/admin/approvals" class="inline-form">
                                            <input type="hidden" name="action" value="markContactRead">
                                            <input type="hidden" name="id" value="${msg.id}">
                                            <button type="submit" class="btn btn-sm">Mark read</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" style="font-size:0.9rem;color:var(--muted);"><c:out value="${msg.message}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </section>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
(function () {
    var labels = ['Morning', 'Afternoon', 'Evening'];
    var visitors = [${visitorSlots.morning}, ${visitorSlots.afternoon}, ${visitorSlots.evening}];
    var donations = [${donorSlots.morning}, ${donorSlots.afternoon}, ${donorSlots.evening}];
    var volunteers = [${volunteerSlots.morning}, ${volunteerSlots.afternoon}, ${volunteerSlots.evening}];
    var registrations = [${userRegSlots.morning}, ${userRegSlots.afternoon}, ${userRegSlots.evening}];
    var brand = '#0d6e5a';
    var accent = '#f59e42';

    new Chart(document.getElementById('slotChart'), {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [
                { label: 'Visitors', data: visitors, backgroundColor: brand },
                { label: 'Donations', data: donations, backgroundColor: accent },
                { label: 'Volunteers', data: volunteers, backgroundColor: '#14a085' },
                { label: 'Registrations', data: registrations, backgroundColor: '#475569' }
            ]
        },
        options: {
            responsive: true,
            plugins: { legend: { position: 'bottom' } },
            scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
        }
    });

    new Chart(document.getElementById('flowChart'), {
        type: 'line',
        data: {
            labels: ['Visitors', 'Donations', 'Volunteers', 'Registrations'],
            datasets: [{
                label: 'Total activity',
                data: [${visitorSlots.total}, ${donorSlots.total}, ${volunteerSlots.total}, ${userRegSlots.total}],
                borderColor: brand,
                backgroundColor: 'rgba(13, 110, 90, 0.15)',
                fill: true,
                tension: 0.35
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true, ticks: { stepSize: 1 } } }
        }
    });
})();
</script>
</body>
</html>
