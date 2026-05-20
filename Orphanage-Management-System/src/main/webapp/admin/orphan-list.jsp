<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Children records — Admin</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="container-card">
        <div class="page-header">
            <h1>Orphan records</h1>
            <p class="lead">Manage all children. Public website shows only <strong>active</strong> (${activeCount} currently).</p>
        </div>

        <div class="filter-tabs">
            <a href="?status=all" class="${statusFilter == 'all' ? 'active' : ''}">All</a>
            <a href="?status=active" class="${statusFilter == 'active' ? 'active' : ''}">Active</a>
            <a href="?status=inactive" class="${statusFilter == 'inactive' ? 'active' : ''}">Inactive</a>
            <a href="?status=adopted" class="${statusFilter == 'adopted' ? 'active' : ''}">Adopted</a>
        </div>

        <div class="actions-row">
            <a class="btn" href="${pageContext.request.contextPath}/admin/orphan?action=add">+ Add child</a>
            <a class="btn btn-secondary" href="${pageContext.request.contextPath}/public/orphans">View public page</a>
        </div>

        <div class="table-wrap">
            <table class="data-table">
                <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Status</th>
                    <th>Education</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${orphans}">
                    <c:set var="ph" value="${o.photo_path}"/>
                    <c:choose>
                        <c:when test="${empty ph}"><c:set var="imgSrc" value="${pageContext.request.contextPath}/images/orphans/placeholder.svg"/></c:when>
                        <c:otherwise><c:set var="imgSrc" value="${pageContext.request.contextPath}/${ph}"/></c:otherwise>
                    </c:choose>
                    <tr>
                        <td><img class="thumb-sm" src="${imgSrc}" alt=""></td>
                        <td>${o.orphan_id}</td>
                        <td><strong><c:out value="${o.first_name} ${o.last_name}"/></strong></td>
                        <td><c:out value="${o.gender}"/></td>
                        <td>
                            <span class="badge badge-${fn:toLowerCase(o.status)}"><c:out value="${o.status}"/></span>
                        </td>
                        <td><c:out value="${o.education_level}"/></td>
                        <td>
                            <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/orphan?action=view&id=${o.orphan_id}">View</a>
                            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/admin/orphan?action=edit&id=${o.orphan_id}">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
