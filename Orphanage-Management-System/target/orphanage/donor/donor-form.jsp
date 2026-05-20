<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><c:choose><c:when test="${empty donor}">Add</c:when><c:otherwise>Edit</c:otherwise></c:choose> donor</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container narrow">
    <div class="container-card">
        <h1><c:choose><c:when test="${empty donor}">Add donor</c:when><c:otherwise>Edit donor</c:otherwise></c:choose></h1>
        <form method="post" action="${pageContext.request.contextPath}/donor/list">
            <c:if test="${empty donor}"><input type="hidden" name="action" value="create"></c:if>
            <c:if test="${not empty donor}"><input type="hidden" name="action" value="update"><input type="hidden" name="id" value="${donor.id}"></c:if>

            <div class="form-group">
                <label for="full_name">Full name *</label>
                <input type="text" id="full_name" name="full_name" value="<c:out value='${donor.full_name}'/>" required maxlength="100">
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" value="<c:out value='${donor.email}'/>" required maxlength="100">
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="<c:out value='${donor.phone}'/>" maxlength="20">
            </div>
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" id="address" name="address" value="<c:out value='${donor.address}'/>">
            </div>
            <div class="form-group">
                <label for="donor_type">Donor type</label>
                <select id="donor_type" name="donor_type">
                    <option value="Individual" ${donor.donor_type == 'Individual' || empty donor.donor_type ? 'selected' : ''}>Individual</option>
                    <option value="Corporate" ${donor.donor_type == 'Corporate' ? 'selected' : ''}>Corporate</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save donor</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/donor/list">Cancel</a>
            </div>
        </form>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
