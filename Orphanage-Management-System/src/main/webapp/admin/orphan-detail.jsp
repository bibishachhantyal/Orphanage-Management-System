<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${orphan.first_name} ${orphan.last_name}"/> — Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<header class="site-nav">
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/admin/dashboard">Hope Haven Admin</a>
        <nav class="links">
            <a href="${pageContext.request.contextPath}/admin/orphan">All orphans</a>
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
</header>

<div class="container">
    <c:set var="ph" value="${orphan.photo_path}"/>
    <c:choose>
        <c:when test="${empty ph}"><c:set var="imgSrc" value="${pageContext.request.contextPath}/images/orphans/placeholder.svg"/></c:when>
        <c:when test="${fn:startsWith(ph, 'http://') || fn:startsWith(ph, 'https://')}"><c:set var="imgSrc" value="${ph}"/></c:when>
        <c:otherwise><c:set var="imgSrc" value="${pageContext.request.contextPath}/${ph}"/></c:otherwise>
    </c:choose>

    <div class="actions-row">
        <a class="btn btn-secondary btn-sm" href="${pageContext.request.contextPath}/admin/orphan">← Back to list</a>
        <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/orphan?action=edit&id=${orphan.orphan_id}">Edit record</a>
    </div>

    <h1><c:out value="${orphan.first_name} ${orphan.last_name}"/></h1>
    <p class="lead">Full record (staff only) — approx. age <strong>${ageYears}</strong> · Status: <c:out value="${orphan.status}"/></p>

    <div class="orphan-profile">
        <div class="orphan-photo">
            <img src="${imgSrc}" alt="Photo of <c:out value="${orphan.first_name}"/>" width="220" height="275">
        </div>
        <div>
            <h2 class="mt-0">Care &amp; education</h2>
            <div class="detail-grid">
                <div class="detail-item"><span class="label">Date of birth</span><div class="value"><c:out value="${orphan.date_of_birth}"/></div></div>
                <div class="detail-item"><span class="label">Gender</span><div class="value"><c:out value="${orphan.gender}"/></div></div>
                <div class="detail-item"><span class="label">Health</span><div class="value"><c:out value="${orphan.health_status}"/></div></div>
                <div class="detail-item"><span class="label">Education</span><div class="value"><c:out value="${orphan.education_level}"/></div></div>
                <div class="detail-item"><span class="label">Enrolled</span><div class="value"><c:out value="${empty orphan.enrollment_date ? '—' : orphan.enrollment_date}"/></div></div>
                <div class="detail-item"><span class="label">Blood group</span><div class="value"><c:out value="${empty orphan.blood_group ? '—' : orphan.blood_group}"/></div></div>
            </div>

            <h2>Identity &amp; guardian (credentials)</h2>
            <div class="detail-grid">
                <div class="detail-item"><span class="label">Birth certificate ref.</span><div class="value"><c:out value="${empty orphan.birth_certificate_ref ? '—' : orphan.birth_certificate_ref}"/></div></div>
                <div class="detail-item"><span class="label">Guardian / contact person</span><div class="value"><c:out value="${empty orphan.guardian_name ? '—' : orphan.guardian_name}"/></div></div>
                <div class="detail-item"><span class="label">Guardian phone</span><div class="value"><c:out value="${empty orphan.guardian_phone ? '—' : orphan.guardian_phone}"/></div></div>
                <div class="detail-item"><span class="label">Photo path</span><div class="value"><c:out value="${empty ph ? 'default' : ph}"/></div></div>
            </div>

            <div class="notes-block">
                <strong>Notes</strong>
                <p><c:out value="${empty orphan.notes ? '—' : orphan.notes}"/></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
