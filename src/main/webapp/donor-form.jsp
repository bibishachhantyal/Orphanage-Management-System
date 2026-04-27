<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${not empty donor ? 'Edit Donor' : 'Add New Donor'} — Orphanage MS</title>
    <meta name="description" content="Add or edit donor information in the Orphanage Management System." />
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

<!-- Breadcrumb -->
<div class="container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/donors">&#x1F465; Donors</a>
        <span class="breadcrumb-sep">&#x203A;</span>
        <span>${not empty donor ? 'Edit Donor' : 'Add New Donor'}</span>
    </div>
</div>

<!-- Form -->
<div class="form-page">
    <div class="form-card animate-in">

        <div class="form-card-header">
            <div class="form-card-icon ${not empty donor ? 'edit' : 'add'}">
                ${not empty donor ? '&#x270F;' : '&#x2795;'}
            </div>
            <div>
                <h2>${not empty donor ? 'Edit Donor' : 'Add New Donor'}</h2>
                <p class="form-card-subtitle">
                    ${not empty donor ? 'Update the donor information below.' : 'Fill in the details to register a new donor.'}
                </p>
            </div>
        </div>

        <%-- Error messages --%>
        <c:if test="${not empty error}">
            <div class="alert-banner error">
                <span class="alert-icon">&#x26A0;</span>
                <c:out value="${error}" />
            </div>
        </c:if>

        <form id="donorForm" action="${pageContext.request.contextPath}/donors" method="post">
            <%-- Hidden ID for updates --%>
            <c:if test="${not empty donor}">
                <input type="hidden" name="id" value="${donor.id}" />
            </c:if>

            <div class="form-section">
                <h3 class="form-section-title">&#x1F464; Personal Information</h3>

                <div class="form-row">
                    <div class="form-group">
                        <label for="fullName">Full Name <span class="required">*</span></label>
                        <input type="text" id="fullName" name="fullName"
                               placeholder="e.g. Rajesh Sharma"
                               value="<c:out value='${not empty donor ? donor.fullName : param.fullName}' default='' />"
                               required />
                    </div>
                    <div class="form-group">
                        <label for="donorEmail">Email Address <span class="required">*</span></label>
                        <input type="email" id="donorEmail" name="email"
                               placeholder="e.g. rajesh@example.com"
                               value="<c:out value='${not empty donor ? donor.email : param.email}' default='' />"
                               required />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="donorPhone">Phone Number</label>
                        <input type="tel" id="donorPhone" name="phone"
                               placeholder="e.g. 9801234567"
                               value="<c:out value='${not empty donor ? donor.phone : param.phone}' default='' />" />
                    </div>
                    <div class="form-group">
                        <label for="donationType">Donation Type <span class="required">*</span></label>
                        <select id="donationType" name="donationType" required>
                            <option value="MONETARY"
                                ${(not empty donor and donor.donationType == 'MONETARY') or (empty donor and param.donationType != 'IN_KIND') ? 'selected' : ''}>
                                &#x1F4B5; Monetary
                            </option>
                            <option value="IN_KIND"
                                ${(not empty donor and donor.donationType == 'IN_KIND') or (empty donor and param.donationType == 'IN_KIND') ? 'selected' : ''}>
                                &#x1F381; In-Kind
                            </option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="form-section-title">&#x1F4CD; Additional Details</h3>

                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="3"
                              placeholder="Street address, city, country"><c:out value='${not empty donor ? donor.address : param.address}' default='' /></textarea>
                </div>

                <div class="form-group form-group--half">
                    <label for="totalDonated">Total Donated (Rs.)</label>
                    <input type="number" id="totalDonated" name="totalDonated"
                           step="0.01" min="0"
                           placeholder="0.00"
                           value="<c:out value='${not empty donor ? donor.totalDonated : param.totalDonated}' default='0' />" />
                </div>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/donors" class="btn btn-secondary">
                    &#x2715; Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <span>${not empty donor ? '&#x1F4BE; Update Donor' : '&#x2795; Add Donor'}</span>
                </button>
            </div>
        </form>

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
