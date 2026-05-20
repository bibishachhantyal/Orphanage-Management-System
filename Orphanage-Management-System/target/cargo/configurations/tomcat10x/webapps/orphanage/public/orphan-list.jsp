<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Our children — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Children in our care</h1>
        <p class="lead">Only children with <strong>active</strong> status are shown here. Adopted or inactive records are kept private.</p>
    </div>

    <div class="alert-info">
        Showing <strong>${fn:length(orphans)}</strong> active profile(s). Want to help? Contact the home after logging in as staff.
    </div>

    <c:choose>
        <c:when test="${empty orphans}">
            <div class="empty-state">
                <h2>No profiles to show</h2>
                <p>There are no active children listed right now, or the database needs to be connected.</p>
                <a class="btn" href="${pageContext.request.contextPath}/">Back to home</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card-grid">
                <c:forEach var="o" items="${orphans}">
                    <c:if test="${fn:toLowerCase(o.status) == 'active'}">
                        <c:set var="ph" value="${o.photo_path}"/>
                        <c:choose>
                            <c:when test="${empty ph}"><c:set var="imgSrc" value="${pageContext.request.contextPath}/images/orphans/placeholder.svg"/></c:when>
                            <c:when test="${fn:startsWith(ph, 'http://') || fn:startsWith(ph, 'https://')}"><c:set var="imgSrc" value="${ph}"/></c:when>
                            <c:otherwise><c:set var="imgSrc" value="${pageContext.request.contextPath}/${ph}"/></c:otherwise>
                        </c:choose>
                        <article class="child-card">
                            <div class="thumb">
                                <img src="${imgSrc}" alt="Photo of ${o.first_name}">
                            </div>
                            <div class="body">
                                <h3><c:out value="${o.first_name} ${o.last_name}"/></h3>
                                <p class="child-meta"><c:out value="${o.education_level}"/> · <c:out value="${o.health_status}"/></p>
                                <span class="badge badge-active">Active</span>
                                <div class="wishlist-actions">
                                    <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans?id=${o.orphan_id}">View profile</a>
                                    <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'USER'}">
                                        <form method="post" action="${pageContext.request.contextPath}/user/wishlist" class="inline-form">
                                            <input type="hidden" name="orphanId" value="${o.orphan_id}">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="redirect" value="${pageContext.request.contextPath}/public/orphans">
                                            <button type="submit" class="btn btn-sm btn-accent">Add to wishlist</button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </article>
                    </c:if>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
