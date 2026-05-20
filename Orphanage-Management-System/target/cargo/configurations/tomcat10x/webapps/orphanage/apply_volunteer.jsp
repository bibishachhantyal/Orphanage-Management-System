<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Volunteer application — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Apply to volunteer</h1>
        <p class="lead">Share your skills and availability. Applications are reviewed by our admin team.</p>
    </div>

    <div class="container-card" style="max-width:640px;margin:0 auto;">
        <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>
        <form method="post" action="${pageContext.request.contextPath}/apply-volunteer">
            <div class="form-group">
                <label for="full_name">Full name</label>
                <input type="text" id="full_name" name="full_name" required maxlength="100">
            </div>
            <div class="form-row-2">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required maxlength="100">
                </div>
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" name="phone" maxlength="20">
                </div>
            </div>
            <div class="form-row-2">
                <div class="form-group">
                    <label for="skill_area">Skill area</label>
                    <input type="text" id="skill_area" name="skill_area" placeholder="e.g. Teaching, Healthcare" maxlength="100">
                </div>
                <div class="form-group">
                    <label for="availability">Availability</label>
                    <input type="text" id="availability" name="availability" placeholder="e.g. Weekends" maxlength="100">
                </div>
            </div>
            <div class="form-group">
                <label for="message">Message (optional)</label>
                <textarea id="message" name="message" placeholder="Tell us why you want to help"></textarea>
            </div>
            <button type="submit" class="btn" style="width:100%;">Submit application</button>
        </form>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
