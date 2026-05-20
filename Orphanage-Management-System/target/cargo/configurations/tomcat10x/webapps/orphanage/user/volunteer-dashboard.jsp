<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Volunteer dashboard — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Welcome, <c:out value="${sessionScope.user.username}"/></h1>
        <p class="lead">Volunteer portal — help with teaching, care, and community events.</p>
    </div>
    <div class="stats">
        <div class="stat-card"><strong>${sponsoredCount}</strong><span class="label">Children in care</span></div>
        <div class="stat-card"><strong>${volunteerHours}</strong><span class="label">Active volunteers</span></div>
    </div>
    <div class="feature-grid">
        <div class="feature-box">
            <h3>Apply to volunteer</h3>
            <p>Submit your skills and availability to our team.</p>
            <a class="btn btn-sm btn-accent" href="${pageContext.request.contextPath}/apply-volunteer">Apply now</a>
        </div>
        <div class="feature-box">
            <h3>Children in care</h3>
            <p>See who you can support during your visits.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans">View children</a>
        </div>
        <div class="feature-box">
            <h3>Volunteer directory</h3>
            <p>View registered volunteers and their roles.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/volunteer/list">Open directory</a>
        </div>
        <div class="feature-box">
            <h3>Your profile</h3>
            <p>Account details and contact information.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/user/profile.jsp">Profile</a>
        </div>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
