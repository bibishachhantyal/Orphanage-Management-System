<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Donate — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <div class="page-header">
        <h1>Support our children</h1>
        <p class="lead">Your generosity provides meals, education, and a safe home. Every contribution is recorded and acknowledged.</p>
    </div>

    <div class="donate-layout">
        <aside class="donate-aside">
            <img src="${pageContext.request.contextPath}/images/home/children-group.png" alt="Children at Hope Haven" class="donate-side-img">
            <h3>Where your gift goes</h3>
            <ul class="donate-benefits">
                <li>Daily breakfast, lunch &amp; dinner</li>
                <li>School fees and supplies</li>
                <li>Healthcare and clothing</li>
            </ul>
        </aside>

        <div class="container-card donate-form-card">
            <c:if test="${not empty error}"><p class="error"><c:out value="${error}"/></p></c:if>
            <form method="post" action="${pageContext.request.contextPath}/donate">
                <div class="form-group">
                    <label for="full_name">Your full name</label>
                    <input type="text" id="full_name" name="full_name" required maxlength="100" autocomplete="name">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required maxlength="100" autocomplete="email">
                </div>
                <div class="form-group">
                    <label for="phone">Phone (optional)</label>
                    <input type="tel" id="phone" name="phone" maxlength="20" autocomplete="tel">
                </div>
                <div class="form-group">
                    <label for="amount">Amount (NRs.)</label>
                    <input type="number" id="amount" name="amount" required min="1" step="1" placeholder="e.g. 5000">
                </div>
                <div class="form-group">
                    <label for="payment_method">Payment method</label>
                    <select id="payment_method" name="payment_method" required>
                        <option value="Online">Online transfer</option>
                        <option value="Bank Transfer">Bank transfer</option>
                        <option value="Cash">Cash / in person</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="orphan_id">Support a specific child (optional)</label>
                    <select id="orphan_id" name="orphan_id">
                        <option value="">General orphanage fund</option>
                        <c:forEach var="o" items="${orphans}">
                            <option value="${o.orphan_id}"><c:out value="${o.first_name} ${o.last_name}"/></option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="purpose">Purpose / message</label>
                    <textarea id="purpose" name="purpose" rows="3" placeholder="e.g. Education fund, festival support…"></textarea>
                </div>
                <button type="submit" class="btn btn-accent" style="width:100%;">Donate now</button>
            </form>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
