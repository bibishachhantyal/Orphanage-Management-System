<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Donate - Orphanage</title>
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
            <li><a href="${pageContext.request.contextPath}/request-resource">&#x1F4E6; Resources</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">&#x1F6AA; Logout</a></li>
        </ul>
    </div>
</nav>

<div class="form-page">
    <div class="form-card">
        <h2>&#x1F4B0; Make a Donation</h2>

        <c:if test="${not empty error}">
            <div class="alert-error"><c:out value="${error}" /></div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/donate">
            <div class="form-group">
                <label for="amount">Donation Amount</label>
                <input type="number" id="amount" name="amount" min="1" step="0.01" placeholder="Enter amount" required>
            </div>
            <div class="form-group">
                <label for="method">Payment Method</label>
                <select id="method" name="method" required>
                    <option value="CASH">Cash</option>
                    <option value="CARD">Credit / Debit Card</option>
                    <option value="UPI">UPI</option>
                    <option value="BANK">Bank Transfer</option>
                </select>
            </div>
            <div class="form-group">
                <label for="note">Note (optional)</label>
                <input type="text" id="note" name="note" placeholder="Add a message with your donation">
            </div>
            <button type="submit">Submit Donation</button>
        </form>
    </div>
</div>

<footer class="footer">
    <div class="container">&copy; 2026 Orphanage Management System. All rights reserved.</div>
</footer>

</body>
</html>
