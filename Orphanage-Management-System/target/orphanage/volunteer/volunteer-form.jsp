<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><c:choose><c:when test="${empty volunteer}">Add</c:when><c:otherwise>Edit</c:otherwise></c:choose> volunteer</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container narrow">
    <div class="container-card">
        <h1><c:choose><c:when test="${empty volunteer}">Add volunteer</c:when><c:otherwise>Edit volunteer</c:otherwise></c:choose></h1>
        <form method="post" action="${pageContext.request.contextPath}/volunteer/list">
            <c:if test="${empty volunteer}"><input type="hidden" name="action" value="create"></c:if>
            <c:if test="${not empty volunteer}"><input type="hidden" name="action" value="update"><input type="hidden" name="id" value="${volunteer.id}"></c:if>

            <div class="form-group">
                <label for="full_name">Full name *</label>
                <input type="text" id="full_name" name="full_name" value="<c:out value='${volunteer.full_name}'/>" required maxlength="100">
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" value="<c:out value='${volunteer.email}'/>" required maxlength="100">
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" value="<c:out value='${volunteer.phone}'/>" maxlength="20">
            </div>
            <div class="form-group">
                <label for="skill_area">Skill area</label>
                <input type="text" id="skill_area" name="skill_area" value="<c:out value='${volunteer.skill_area}'/>" placeholder="e.g. Teaching, Healthcare">
            </div>
            <div class="form-group">
                <label for="availability">Availability</label>
                <input type="text" id="availability" name="availability" value="<c:out value='${volunteer.availability}'/>" placeholder="e.g. Weekends, Evenings">
            </div>
            <div class="form-group">
                <label for="joined_date">Joined date</label>
                <input type="date" id="joined_date" name="joined_date" value="<c:out value='${volunteer.joined_date}'/>">
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="Active" ${volunteer.status == 'Active' || empty volunteer.status ? 'selected' : ''}>Active</option>
                    <option value="Inactive" ${volunteer.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save volunteer</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/volunteer/list">Cancel</a>
            </div>
        </form>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
