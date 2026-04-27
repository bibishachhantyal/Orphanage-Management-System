<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Request Resource - Orphanage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="navbar-brand">
            <div class="logo-icon">&#x1F3E0;</div>
            Orphanage MS
        </a>
        <ul class="navbar-links">
            <li><a href="${pageContext.request.contextPath}/user/dashboard.jsp">&#x1F3E0; Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/donate">&#x1F4B0; Donate</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">&#x1F6AA; Logout</a></li>
        </ul>
    </div>
</nav>

<div class="form-page">
    <div class="form-card">
        <h2>&#x1F4E6; Request Resource</h2>

        <c:if test="${not empty error}">
            <div class="alert-error"><c:out value="${error}" /></div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/request-resource">
            <div class="form-group">
                <label for="itemName">Item Name</label>
                <input type="text" id="itemName" name="itemName" placeholder="e.g. Blankets, Books, Medicines" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity" min="1" placeholder="How many?" required>
            </div>
            <div class="form-group">
                <label for="priority">Priority Level</label>
                <select id="priority" name="priority" required>
                    <option value="LOW">Low</option>
                    <option value="MEDIUM" selected>Medium</option>
                    <option value="HIGH">High — Urgent</option>
                </select>
            </div>
            <button type="submit">Submit Request</button>
        </form>
    </div>
</div>

<footer class="footer">
    <div class="container">&copy; 2026 Orphanage Management System. All rights reserved.</div>
</footer>

</body>
</html>
