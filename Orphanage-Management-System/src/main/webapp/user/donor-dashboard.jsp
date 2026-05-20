<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Donor dashboard — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Welcome, <c:out value="${sessionScope.user.username}"/></h1>
        <p class="lead">Donor portal — support children through donations and sponsorship.</p>
    </div>
    <div class="stats">
        <div class="stat-card"><strong>${sponsoredCount}</strong><span class="label">Children in care</span></div>
        <div class="stat-card"><strong>${donationCount}</strong><span class="label">Donation records</span></div>
    </div>
    <div class="feature-grid">
        <div class="feature-box">
            <h3>Make a donation</h3>
            <p>Contribute to meals, education, or a specific child.</p>
            <a class="btn btn-sm btn-accent" href="${pageContext.request.contextPath}/donate">Donate now</a>
        </div>
        <div class="feature-box">
            <h3>Meet our children</h3>
            <p>Browse active profiles and choose who to support.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans">View children</a>
        </div>
        <div class="feature-box">
            <h3>Donation history</h3>
            <p>View recorded donations in the system.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/donation/list">Open donations</a>
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
