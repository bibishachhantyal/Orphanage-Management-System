<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Donor Management — Orphanage MS</title>
    <meta name="description" content="View and manage all donors in the Orphanage Management System." />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/donor.css" />
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
            <li><a href="${pageContext.request.contextPath}/donors" class="active">&#x1F465; Donors</a></li>
            <li><a href="${pageContext.request.contextPath}/donate">&#x1F4B0; Donate</a></li>
            <li><a href="${pageContext.request.contextPath}/request-resource">&#x1F4E6; Resources</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-logout">&#x1F6AA; Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Page Header -->
<div class="container">
    <div class="page-header donor-page-header">
        <div class="page-header-content">
            <h1>&#x1F465; Donor Management</h1>
            <p>Manage all donor records — add, edit, or remove donors from the system.</p>
        </div>
        <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-primary btn-add" id="addDonorBtn">
            <span class="btn-icon">&#x2795;</span>
            Add New Donor
        </a>
    </div>

    <!-- Messages -->
    <c:if test="${param.msg == 'created'}">
        <div class="alert-banner success animate-in">
            <span class="alert-icon">&#x2705;</span>
            Donor has been added successfully!
            <button class="alert-close" onclick="this.parentElement.remove()">&#x2715;</button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert-banner success animate-in">
            <span class="alert-icon">&#x2705;</span>
            Donor information updated successfully!
            <button class="alert-close" onclick="this.parentElement.remove()">&#x2715;</button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'deleted'}">
        <div class="alert-banner success animate-in">
            <span class="alert-icon">&#x1F5D1;</span>
            Donor has been removed from the system.
            <button class="alert-close" onclick="this.parentElement.remove()">&#x2715;</button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert-banner error animate-in">
            <span class="alert-icon">&#x26A0;</span>
            <c:out value="${param.error}" />
            <button class="alert-close" onclick="this.parentElement.remove()">&#x2715;</button>
        </div>
    </c:if>

    <!-- Donor Table -->
    <div class="table-card animate-in">
        <c:choose>
            <c:when test="${empty donorList}">
                <div class="empty-state">
                    <div class="empty-icon">&#x1F4CB;</div>
                    <h3>No donors yet</h3>
                    <p>Get started by adding your first donor to the system.</p>
                    <a href="${pageContext.request.contextPath}/donors?action=new" class="btn btn-primary">
                        <span>&#x2795;</span> Add First Donor
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-header">
                    <div class="table-info">
                        <span class="table-count">${donorList.size()} donor<c:if test="${donorList.size() != 1}">s</c:if></span>
                        found
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="donorTable">
                        <thead>
                            <tr>
                                <th class="th-num">#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Type</th>
                                <th class="th-amount">Total Donated</th>
                                <th class="th-actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="donor" items="${donorList}" varStatus="loop">
                                <tr class="animate-in">
                                    <td class="td-num">${loop.index + 1}</td>
                                    <td class="td-name">
                                        <div class="donor-avatar">${donor.fullName.substring(0,1)}</div>
                                        <c:out value="${donor.fullName}" />
                                    </td>
                                    <td class="td-email"><c:out value="${donor.email}" /></td>
                                    <td class="td-phone">
                                        <c:choose>
                                            <c:when test="${not empty donor.phone}"><c:out value="${donor.phone}" /></c:when>
                                            <c:otherwise><span class="text-muted">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${donor.donationType == 'MONETARY'}">
                                                <span class="badge badge-purple">&#x1F4B5; Monetary</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-orange">&#x1F381; In-Kind</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="td-amount">
                                        <fmt:formatNumber value="${donor.totalDonated}" type="currency" currencySymbol="Rs. " />
                                    </td>
                                    <td class="td-actions">
                                        <a href="${pageContext.request.contextPath}/donors?action=edit&id=${donor.id}"
                                           class="btn-icon-action btn-edit" title="Edit">
                                            &#x270F;
                                        </a>
                                        <a href="${pageContext.request.contextPath}/donors?action=delete&id=${donor.id}"
                                           class="btn-icon-action btn-delete" title="Delete"
                                           onclick="return confirm('Are you sure you want to delete this donor?');">
                                            &#x1F5D1;
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        &copy; 2026 Orphanage Management System. All rights reserved.
    </div>
</footer>

</body>
</html>
