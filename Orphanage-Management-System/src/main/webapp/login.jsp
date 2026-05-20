<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="auth-split">
        <aside class="auth-aside">
            <h2>Welcome back</h2>
            <p>Sign in to manage children, review donations, and support our mission.</p>
            <ul>
                <li><strong>Admin</strong> — manage children, donors, volunteers, donations</li>
                <li><strong>Donor</strong> — donate and view children</li>
                <li><strong>Volunteer</strong> — apply and support programs</li>
                <li><strong>User</strong> — browse children and wishlists</li>
            </ul>
        </aside>
        <div class="auth-card">
            <h1>Sign in</h1>
            <p class="login-credentials-hint">
                <strong>Demo logins</strong> (password for all: <code>Admin@123</code>)<br>
                <code>admin</code> — Administrator &nbsp;|&nbsp;
                <code>donor</code> — Donor &nbsp;|&nbsp;
                <code>volunteer</code> — Volunteer &nbsp;|&nbsp;
                <code>bibisha</code> — User
            </p>
            <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required autocomplete="username"
                           value="<c:out value='${rememberedUsername}'/>" placeholder="Your username">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="password-wrap">
                        <input type="password" id="password" name="password" required autocomplete="current-password"
                               placeholder="e.g. Admin@123">
                        <button type="button" class="password-toggle" aria-label="Show password" aria-pressed="false" title="Show password">&#128065;</button>
                    </div>
                    <p class="field-hint">Use uppercase, lowercase, number &amp; special character (min. 8).</p>
                </div>
                <label class="checkbox-row">
                    <input type="checkbox" name="remember" value="on">
                    <span>Remember me on this device</span>
                </label>
                <button type="submit" class="btn" style="width:100%;">Sign in</button>
            </form>
            <p style="margin-top:1.25rem;text-align:center;">
                No account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </p>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/password.js"></script>
</body>
</html>
