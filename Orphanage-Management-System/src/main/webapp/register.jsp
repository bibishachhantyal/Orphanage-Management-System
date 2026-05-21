<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="auth-split">
        <aside class="auth-aside">
            <h2>Join our community</h2>
            <p>Create a user account to browse children, save wishlists, and access staff tools after approval.</p>
            <ul>
                <li>Strong password required (e.g. Admin@123)</li>
                <li>Passwords are stored with BCrypt</li>
                <li>Role is set to USER automatically</li>
                <li>An administrator must approve your account</li>
                <li>Phone number must be unique if provided</li>
            </ul>
        </aside>
        <div class="auth-card">
            <h1>Create account</h1>
            <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>
            <c:if test="${not empty success}"><p class="success-msg"><c:out value="${success}"/></p></c:if>
            <form method="post" action="${pageContext.request.contextPath}/register" data-validate-password>
                <div class="form-row-2">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" required maxlength="50" autocomplete="username">
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required maxlength="100" autocomplete="email">
                    </div>
                </div>
                <div class="form-group">
                    <label for="full_name">Full name</label>
                    <input type="text" id="full_name" name="full_name" maxlength="100" autocomplete="name">
                </div>
                <div class="form-row-2">
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="text" id="phone" name="phone" maxlength="20" autocomplete="tel">
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" maxlength="255" autocomplete="street-address">
                    </div>
                </div>
                <div class="form-row-2">
                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="password-wrap">
                            <input type="password" id="password" name="password" required minlength="8" autocomplete="new-password"
                                   data-strong placeholder="e.g. Admin@123">
                            <button type="button" class="password-toggle" aria-label="Show password" aria-pressed="false" title="Show password">&#128065;</button>
                        </div>
                        <p class="field-hint">Min. 8 chars: upper, lower, number &amp; symbol.</p>
                    </div>
                    <div class="form-group">
                        <label for="confirm_password">Confirm password</label>
                        <div class="password-wrap">
                            <input type="password" id="confirm_password" name="confirm_password" required minlength="8" autocomplete="new-password" data-confirm>
                            <button type="button" class="password-toggle" aria-label="Show password" aria-pressed="false" title="Show password">&#128065;</button>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn" style="width:100%;">Submit registration</button>
            </form>
            <p style="margin-top:1rem;text-align:center;">
                Already registered? <a href="${pageContext.request.contextPath}/login">Sign in</a>
            </p>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
<script src="${pageContext.request.contextPath}/js/password.js"></script>
</body>
</html>
