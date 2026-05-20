<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<header class="site-nav">
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/user/dashboard">Hope Haven</a>
        <nav class="links">
            <a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
</header>

<div class="container narrow">
    <h1>Your profile</h1>
    <c:if test="${empty sessionScope.user}">
        <p class="error">Not logged in.</p>
    </c:if>
    <c:if test="${not empty sessionScope.user}">
        <div class="detail-grid">
            <div class="detail-item"><span class="label">Username</span><div class="value"><c:out value="${sessionScope.user.username}"/></div></div>
            <div class="detail-item"><span class="label">Email</span><div class="value"><c:out value="${sessionScope.user.email}"/></div></div>
            <div class="detail-item"><span class="label">Role</span><div class="value"><c:out value="${sessionScope.user.role}"/></div></div>
        </div>
    </c:if>
    <p style="margin-top:1rem;"><a href="${pageContext.request.contextPath}/user/dashboard">← Dashboard</a></p>
</div>
</body>
</html>
