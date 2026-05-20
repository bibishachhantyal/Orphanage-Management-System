<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User dashboard — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Welcome, <c:out value="${sessionScope.user.username}"/></h1>
        <p class="lead">Search children, manage your wishlist, and access modules below.</p>
    </div>

    <form class="search-bar" method="get" action="${pageContext.request.contextPath}/user/dashboard">
        <input type="text" name="q" placeholder="Search by name, guardian, or blood group…"
               value="<c:out value='${searchQuery}'/>">
        <button type="submit" class="btn">Search</button>
        <c:if test="${not empty searchQuery}">
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/dashboard">Clear</a>
        </c:if>
    </form>

    <c:if test="${not empty searchQuery}">
        <h2>Search results</h2>
        <c:choose>
            <c:when test="${empty searchResults}">
                <p class="lead">No active children matched &ldquo;<c:out value="${searchQuery}"/>&rdquo;.</p>
            </c:when>
            <c:otherwise>
                <div class="card-grid">
                    <c:forEach var="o" items="${searchResults}">
                        <article class="child-card">
                            <div class="body">
                                <h3><c:out value="${o.first_name} ${o.last_name}"/></h3>
                                <p class="child-meta">Guardian: <c:out value="${empty o.guardian_name ? '—' : o.guardian_name}"/> · <c:out value="${o.blood_group}"/></p>
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans?id=${o.orphan_id}">View profile</a>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        <hr style="margin:2rem 0;border:none;border-top:1px solid var(--border);">
    </c:if>

    <div class="stats">
        <div class="stat-card"><strong>${sponsoredCount}</strong><span class="label">Active children</span></div>
        <div class="stat-card"><strong>${wishlistCount}</strong><span class="label">Wishlist items</span></div>
        <div class="stat-card"><strong>${donationCount}</strong><span class="label">Donation records</span></div>
    </div>

    <div class="feature-grid">
        <div class="feature-box">
            <h3>Children in care</h3>
            <p>Browse public profiles of active children.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans">Browse</a>
        </div>
        <div class="feature-box">
            <h3>My wishlist</h3>
            <p>View children you have saved (${wishlistCount}).</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/user/wishlist">Open wishlist</a>
        </div>
        <div class="feature-box">
            <h3>Profile</h3>
            <p>Your account details.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/user/profile.jsp">Profile</a>
        </div>
        <div class="feature-box">
            <h3>Donations</h3>
            <p>View donation entries.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/donation/list">Open</a>
        </div>
        <div class="feature-box">
            <h3>Volunteers</h3>
            <p>Volunteer directory.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/volunteer/list">Open</a>
        </div>
        <div class="feature-box">
            <h3>Logout</h3>
            <p>End your session securely.</p>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
