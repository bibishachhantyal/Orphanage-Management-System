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
                <div class="css-bar-chart" role="img" aria-label="Bar chart of morning, afternoon, and evening activity">
                    <div class="css-bar-legend">
                        <span class="css-legend-item"><span class="css-legend-swatch css-swatch-brand"></span> Visitors</span>
                        <span class="css-legend-item"><span class="css-legend-swatch css-swatch-accent"></span> Donations</span>
                        <span class="css-legend-item"><span class="css-legend-swatch css-swatch-teal"></span> Volunteers</span>
                        <span class="css-legend-item"><span class="css-legend-swatch css-swatch-slate"></span> Registrations</span>
                    </div>
                    <div class="css-bar-groups">
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-brand" style="height:${visitorSlots.morning * 100 / chartSlotMax}%" title="Visitors: ${visitorSlots.morning}"></div>
                                <div class="css-bar css-swatch-accent" style="height:${donorSlots.morning * 100 / chartSlotMax}%" title="Donations: ${donorSlots.morning}"></div>
                                <div class="css-bar css-swatch-teal" style="height:${volunteerSlots.morning * 100 / chartSlotMax}%" title="Volunteers: ${volunteerSlots.morning}"></div>
                                <div class="css-bar css-swatch-slate" style="height:${userRegSlots.morning * 100 / chartSlotMax}%" title="Registrations: ${userRegSlots.morning}"></div>
                            </div>
                            <span class="css-bar-label">Morning</span>
                        </div>
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-brand" style="height:${visitorSlots.afternoon * 100 / chartSlotMax}%" title="Visitors: ${visitorSlots.afternoon}"></div>
                                <div class="css-bar css-swatch-accent" style="height:${donorSlots.afternoon * 100 / chartSlotMax}%" title="Donations: ${donorSlots.afternoon}"></div>
                                <div class="css-bar css-swatch-teal" style="height:${volunteerSlots.afternoon * 100 / chartSlotMax}%" title="Volunteers: ${volunteerSlots.afternoon}"></div>
                                <div class="css-bar css-swatch-slate" style="height:${userRegSlots.afternoon * 100 / chartSlotMax}%" title="Registrations: ${userRegSlots.afternoon}"></div>
                            </div>
                            <span class="css-bar-label">Afternoon</span>
                        </div>
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-brand" style="height:${visitorSlots.evening * 100 / chartSlotMax}%" title="Visitors: ${visitorSlots.evening}"></div>
                                <div class="css-bar css-swatch-accent" style="height:${donorSlots.evening * 100 / chartSlotMax}%" title="Donations: ${donorSlots.evening}"></div>
                                <div class="css-bar css-swatch-teal" style="height:${volunteerSlots.evening * 100 / chartSlotMax}%" title="Volunteers: ${volunteerSlots.evening}"></div>
                                <div class="css-bar css-swatch-slate" style="height:${userRegSlots.evening * 100 / chartSlotMax}%" title="Registrations: ${userRegSlots.evening}"></div>
                            </div>
                            <span class="css-bar-label">Evening</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chart-card">
                <h3>Statistics flow overview</h3>
                <div class="css-bar-chart css-bar-chart-single" role="img" aria-label="Bar chart of total activity across categories">
                    <div class="css-bar-groups">
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-brand css-bar-wide" style="height:${visitorSlots.total * 100 / chartFlowMax}%" title="Visitors total: ${visitorSlots.total}"></div>
                            </div>
                            <span class="css-bar-label">Visitors</span>
                        </div>
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-accent css-bar-wide" style="height:${donorSlots.total * 100 / chartFlowMax}%" title="Donations total: ${donorSlots.total}"></div>
                            </div>
                            <span class="css-bar-label">Donations</span>
                        </div>
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-teal css-bar-wide" style="height:${volunteerSlots.total * 100 / chartFlowMax}%" title="Volunteers total: ${volunteerSlots.total}"></div>
                            </div>
                            <span class="css-bar-label">Volunteers</span>
                        </div>
                        <div class="css-bar-group">
                            <div class="css-bar-cluster">
                                <div class="css-bar css-swatch-slate css-bar-wide" style="height:${userRegSlots.total * 100 / chartFlowMax}%" title="Registrations total: ${userRegSlots.total}"></div>
                            </div>
                            <span class="css-bar-label">Registrations</span>
                        </div>
                    </div>
                </div>
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
            <h3>Reports &amp; analysis</h3>
            <p>Donation, orphan status, and volunteer reports for decision-making.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/donation-report">Donations</a>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/admin/orphan-report">Children</a>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/admin/volunteer-report">Volunteers</a>
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
</body>
</html>
