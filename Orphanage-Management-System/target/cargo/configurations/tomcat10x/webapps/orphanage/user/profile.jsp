<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Your profile — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container narrow">
    <div class="page-header">
        <h1>Your profile</h1>
        <p class="lead">View and update your contact details and password.</p>
    </div>

    <c:if test="${param.updated == '1'}">
        <p class="success-msg">Profile updated successfully.</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error"><c:out value="${error}"/></p>
    </c:if>

    <c:choose>
        <c:when test="${empty profileUser}">
            <p class="error">Not logged in.</p>
        </c:when>
        <c:otherwise>
            <div class="container-card">
                <form method="post" action="${pageContext.request.contextPath}/user/profile">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" value="<c:out value='${profileUser.username}'/>" disabled>
                        <p class="field-hint">Username cannot be changed.</p>
                    </div>
                    <div class="form-group">
                        <label for="full_name">Full name</label>
                        <input type="text" id="full_name" name="full_name" maxlength="100"
                               value="<c:out value='${profileUser.fullName}'/>">
                    </div>
                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required maxlength="100"
                                   value="<c:out value='${profileUser.email}'/>">
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="text" id="phone" name="phone" maxlength="20"
                                   value="<c:out value='${profileUser.phone}'/>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" maxlength="255"
                               value="<c:out value='${profileUser.address}'/>">
                    </div>

                    <h2 style="margin-top:1.5rem;font-size:1.1rem;">Change password</h2>
                    <p class="field-hint">Leave blank to keep your current password.</p>
                    <div class="form-group">
                        <label for="current_password">Current password</label>
                        <input type="password" id="current_password" name="current_password" autocomplete="current-password">
                    </div>
                    <div class="form-row-2">
                        <div class="form-group">
                            <label for="new_password">New password</label>
                            <input type="password" id="new_password" name="new_password" minlength="8" autocomplete="new-password">
                        </div>
                        <div class="form-group">
                            <label for="confirm_password">Confirm new password</label>
                            <input type="password" id="confirm_password" name="confirm_password" minlength="8" autocomplete="new-password">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn">Save changes</button>
                        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/dashboard">Back to dashboard</a>
                    </div>
                </form>
            </div>
            <div class="detail-grid" style="margin-top:1.5rem;">
                <div class="detail-item"><span class="label">Role</span><div class="value"><c:out value="${profileUser.role}"/></div></div>
                <div class="detail-item"><span class="label">Account status</span>
                    <div class="value"><c:out value="${profileUser.approved ? 'Approved' : 'Pending approval'}"/></div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
