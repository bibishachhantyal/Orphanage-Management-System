<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><c:choose><c:when test="${newRecord || param.action == 'create'}">Add</c:when><c:otherwise>Edit</c:otherwise></c:choose> child</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container narrow wide-form">
    <div class="container-card">
        <h1><c:choose><c:when test="${newRecord || param.action == 'create'}">Register a new child</c:when><c:otherwise>Edit child record</c:otherwise></c:choose></h1>
        <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>

        <form method="post" action="${pageContext.request.contextPath}/admin/orphan">
            <c:choose>
                <c:when test="${newRecord || param.action == 'create'}">
                    <input type="hidden" name="action" value="create">
                </c:when>
                <c:otherwise>
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="orphan_id" value="${orphan.orphan_id}">
                </c:otherwise>
            </c:choose>

            <div class="form-row">
                <div class="form-group">
                    <label for="first_name">First name *</label>
                    <input type="text" id="first_name" name="first_name" required value="<c:out value='${orphan.first_name}'/>">
                </div>
                <div class="form-group">
                    <label for="last_name">Last name *</label>
                    <input type="text" id="last_name" name="last_name" required value="<c:out value='${orphan.last_name}'/>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="date_of_birth">Date of birth</label>
                    <input type="date" id="date_of_birth" name="date_of_birth" value="<c:out value='${orphan.date_of_birth}'/>">
                </div>
                <div class="form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender">
                        <option value="Male" ${orphan.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${orphan.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${orphan.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="health_status">Health status</label>
                    <input type="text" id="health_status" name="health_status" value="<c:out value='${orphan.health_status}'/>">
                </div>
                <div class="form-group">
                    <label for="education_level">Education level</label>
                    <input type="text" id="education_level" name="education_level" value="<c:out value='${orphan.education_level}'/>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="enrollment_date">Enrollment date</label>
                    <input type="date" id="enrollment_date" name="enrollment_date" value="<c:out value='${orphan.enrollment_date}'/>">
                    <p class="field-hint">Must be on or after date of birth.</p>
                </div>
                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status">
                        <option value="active" ${empty orphan.status || orphan.status == 'active' ? 'selected' : ''}>active</option>
                        <option value="inactive" ${orphan.status == 'inactive' ? 'selected' : ''}>inactive</option>
                        <option value="adopted" ${orphan.status == 'adopted' ? 'selected' : ''}>adopted</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label for="photo_path">Photo (path or URL)</label>
                <input type="text" id="photo_path" name="photo_path" placeholder="images/orphans/placeholder.svg" value="<c:out value='${orphan.photo_path}'/>">
                <p class="field-hint">Relative path or full https:// link.</p>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="birth_certificate_ref">Birth certificate reference</label>
                    <input type="text" id="birth_certificate_ref" name="birth_certificate_ref" value="<c:out value='${orphan.birth_certificate_ref}'/>">
                </div>
                <div class="form-group">
                    <label for="blood_group">Blood group</label>
                    <input type="text" id="blood_group" name="blood_group" placeholder="O+" value="<c:out value='${orphan.blood_group}'/>">
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="guardian_name">Guardian / contact person</label>
                    <input type="text" id="guardian_name" name="guardian_name" value="<c:out value='${orphan.guardian_name}'/>">
                </div>
                <div class="form-group">
                    <label for="guardian_phone">Guardian phone</label>
                    <input type="tel" id="guardian_phone" name="guardian_phone" value="<c:out value='${orphan.guardian_phone}'/>">
                </div>
            </div>

            <div class="form-group">
                <label for="notes">Notes</label>
                <textarea id="notes" name="notes" rows="3"><c:out value="${orphan.notes}"/></textarea>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn">Save child</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/orphan">Cancel</a>
            </div>
        </form>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
