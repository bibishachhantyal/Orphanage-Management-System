<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Thank you — Hope Haven</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container narrow">
    <div class="container-card thankyou-panel">
        <div class="thankyou-icon" aria-hidden="true">&#10003;</div>
        <c:choose>
            <c:when test="${param.type == 'donation'}">
                <h1>Thank you for your support!</h1>
                <p class="lead thankyou-message">
                    Dear <c:out value="${param.name != null && param.name != '' ? param.name : 'friend'}"/>,
                    your generous donation to Hope Haven Children's Home means the world to us.
                    Because of supporters like you, we can provide daily breakfast, lunch, and dinner,
                    safe shelter, education, and healthcare for every child in our care.
                </p>
                <p class="lead">You will receive a confirmation email shortly. May your kindness return to you many times over.</p>
                <p class="actions-row" style="justify-content:center;margin-top:1.5rem;">
                    <a class="btn btn-accent" href="${pageContext.request.contextPath}/">Back to home</a>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/donate">Donate again</a>
                </p>
            </c:when>
            <c:when test="${param.type == 'volunteer'}">
                <h1>Application received</h1>
                <p class="lead">Thank you for offering your time. Our team will review your volunteer application and contact you by email.</p>
                <p class="actions-row" style="justify-content:center;margin-top:1.5rem;">
                    <a class="btn" href="${pageContext.request.contextPath}/">Back to home</a>
                </p>
            </c:when>
            <c:otherwise>
                <h1>Message sent</h1>
                <p class="lead">Thank you for contacting Hope Haven. We have received your message and will respond soon.</p>
                <p class="actions-row" style="justify-content:center;margin-top:1.5rem;">
                    <a class="btn" href="${pageContext.request.contextPath}/">Back to home</a>
                    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/contact.html">Send another message</a>
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
