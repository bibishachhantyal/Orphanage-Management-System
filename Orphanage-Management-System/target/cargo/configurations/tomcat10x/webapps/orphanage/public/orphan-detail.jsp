<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><c:out value="${orphan.first_name}"/> — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <c:set var="ph" value="${orphan.photo_path}"/>
    <c:choose>
        <c:when test="${empty ph}"><c:set var="imgSrc" value="${pageContext.request.contextPath}/images/orphans/placeholder.svg"/></c:when>
        <c:when test="${fn:startsWith(ph, 'http://') || fn:startsWith(ph, 'https://')}"><c:set var="imgSrc" value="${ph}"/></c:when>
        <c:otherwise><c:set var="imgSrc" value="${pageContext.request.contextPath}/${ph}"/></c:otherwise>
    </c:choose>

    <p><a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/public/orphans">← Back</a></p>

    <div class="orphan-profile">
        <div class="orphan-photo">
            <img src="${imgSrc}" alt="" width="220" height="275">
        </div>
        <div>
            <h1><c:out value="${orphan.first_name} ${orphan.last_name}"/></h1>
            <p class="lead">About <strong>${ageYears}</strong> years old · <c:out value="${orphan.gender}"/></p>

            <div class="detail-grid">
                <div class="detail-item"><span class="label">Education</span><div class="value"><c:out value="${orphan.education_level}"/></div></div>
                <div class="detail-item"><span class="label">Wellbeing</span><div class="value"><c:out value="${orphan.health_status}"/></div></div>
                <div class="detail-item"><span class="label">Blood group</span><div class="value"><c:out value="${empty orphan.blood_group ? '—' : orphan.blood_group}"/></div></div>
                <div class="detail-item"><span class="label">Family contact name</span><div class="value"><c:out value="${empty orphan.guardian_name ? 'On file at the home' : orphan.guardian_name}"/></div></div>
            </div>

            <div class="notes-block">
                <strong>About this child</strong>
                <p><c:out value="${empty orphan.notes ? '—' : orphan.notes}"/></p>
            </div>

            <p class="footer-note">Identity references and guardian phone numbers are shared only with authorised staff after login. To sponsor or volunteer, please contact the home through the office.</p>
            <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'USER'}">
                <form method="post" action="${pageContext.request.contextPath}/user/wishlist" class="wishlist-actions" style="margin-top:1rem;">
                    <input type="hidden" name="orphanId" value="${orphan.orphan_id}">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="redirect" value="${pageContext.request.contextPath}/public/orphans?id=${orphan.orphan_id}">
                    <button type="submit" class="btn btn-accent">Add to wishlist</button>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/user/wishlist">View wishlist</a>
                </form>
            </c:if>
        </div>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
