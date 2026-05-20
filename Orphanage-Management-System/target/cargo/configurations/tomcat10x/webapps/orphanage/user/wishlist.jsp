<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My wishlist — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>My wishlist</h1>
        <p class="lead">Children you have saved for follow-up. Wishlist is stored in your session.</p>
    </div>

    <c:choose>
        <c:when test="${empty orphans}">
            <div class="empty-state">
                <h2>Your wishlist is empty</h2>
                <p>Browse active children and use &ldquo;Add to wishlist&rdquo; on any profile.</p>
                <a class="btn" href="${pageContext.request.contextPath}/public/orphans">Browse children</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-grid">
                <c:forEach var="o" items="${orphans}">
                    <c:set var="ph" value="${o.photo_path}"/>
                    <c:choose>
                        <c:when test="${empty ph}"><c:set var="imgSrc" value="${pageContext.request.contextPath}/images/orphans/placeholder.svg"/></c:when>
                        <c:when test="${fn:startsWith(ph, 'http://') || fn:startsWith(ph, 'https://')}"><c:set var="imgSrc" value="${ph}"/></c:when>
                        <c:otherwise><c:set var="imgSrc" value="${pageContext.request.contextPath}/${ph}"/></c:otherwise>
                    </c:choose>
                    <article class="child-card">
                        <div class="thumb"><img src="${imgSrc}" alt=""></div>
                        <div class="body">
                            <h3><c:out value="${o.first_name} ${o.last_name}"/></h3>
                            <p class="child-meta"><c:out value="${o.education_level}"/> · <c:out value="${o.blood_group}"/></p>
                            <div class="wishlist-actions">
                                <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans?id=${o.orphan_id}">View</a>
                                <form method="post" action="${pageContext.request.contextPath}/user/wishlist" class="inline-form">
                                    <input type="hidden" name="orphanId" value="${o.orphan_id}">
                                    <input type="hidden" name="action" value="remove">
                                    <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                                </form>
                            </div>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
