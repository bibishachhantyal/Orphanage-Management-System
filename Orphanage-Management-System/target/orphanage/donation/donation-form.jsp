<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><c:choose><c:when test="${empty donation}">Add</c:when><c:otherwise>Edit</c:otherwise></c:choose> donation</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-app.jspf" %>
<main class="page-wrap">
<div class="container narrow">
    <div class="container-card">
        <h1><c:choose><c:when test="${empty donation}">Record donation</c:when><c:otherwise>Edit donation</c:otherwise></c:choose></h1>
        <form method="post" action="${pageContext.request.contextPath}/donation/list">
            <c:if test="${empty donation}"><input type="hidden" name="action" value="create"></c:if>
            <c:if test="${not empty donation}"><input type="hidden" name="action" value="update"><input type="hidden" name="id" value="${donation.id}"></c:if>

            <div class="form-group">
                <label>Donor *</label>
                <select name="donor_id" required>
                    <option value="">Select donor</option>
                    <c:forEach var="donor" items="${donors}">
                        <option value="${donor.id}" ${donation.donor_id == donor.id ? 'selected' : ''}><c:out value="${donor.full_name}"/></option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Child (optional — active only)</label>
                <select name="orphan_id">
                    <option value="">General fund</option>
                    <c:forEach var="orphan" items="${orphans}">
                        <option value="${orphan.orphan_id}" ${donation.orphan_id == orphan.orphan_id ? 'selected' : ''}>
                            <c:out value="${orphan.first_name} ${orphan.last_name}"/>
                        </option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Amount (NRs.) *</label>
                <input type="number" step="0.01" min="1" name="amount" value="${donation.amount}" required>
            </div>
            <div class="form-group">
                <label>Date *</label>
                <input type="date" name="donation_date" value="${donation.donation_date}" required>
            </div>
            <div class="form-group">
                <label>Payment method</label>
                <select name="payment_method">
                    <option ${donation.payment_method == 'Cash' ? 'selected' : ''}>Cash</option>
                    <option ${donation.payment_method == 'Bank Transfer' ? 'selected' : ''}>Bank Transfer</option>
                    <option ${donation.payment_method == 'Online' ? 'selected' : ''}>Online</option>
                </select>
            </div>
            <div class="form-group">
                <label>Purpose</label>
                <input name="purpose" value="${donation.purpose}" placeholder="e.g. School fees">
            </div>
            <div class="form-actions">
                <button type="submit" class="btn">Save donation</button>
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/donation/list">Cancel</a>
            </div>
        </form>
    </div>
</div>
</main>
<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
