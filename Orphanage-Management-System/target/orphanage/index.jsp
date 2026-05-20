<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="orphanage.dao.DonationDAO,orphanage.dao.DonorDAO,orphanage.dao.OrphanDAO,orphanage.dao.VolunteerDAO" %>
<%
    if (request.getAttribute("activeChildren") == null) {
        request.setAttribute("activeChildren", new OrphanDAO().getActiveCount());
        request.setAttribute("totalDonors", new DonorDAO().getTotalCount());
        request.setAttribute("totalVolunteers", new VolunteerDAO().getTotalCount());
        request.setAttribute("totalDonations", new DonationDAO().getTotalAmount());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Hope Haven Children's Home</title>
    <%@ include file="/WEB-INF/jspf/head.jspf" %>
</head>
<body>
<%@ include file="/WEB-INF/jspf/nav-public.jspf" %>

<main class="page-wrap">
<div class="container">
    <section class="hero hero-with-media">
        <div class="hero-media">
            <img src="${pageContext.request.contextPath}/images/home/children-group.png" alt="Children smiling together at Hope Haven" class="hero-photo hero-photo-main">
        </div>
        <div class="hero-content">
            <h1>Every child deserves a safe tomorrow</h1>
            <p>
                Hope Haven connects caring donors and volunteers with children in our home.
                Staff use this portal to keep records accurate, private, and up to date.
            </p>
            <div class="hero-actions">
                <a class="btn btn-accent" href="${pageContext.request.contextPath}/donate">Donate now</a>
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/public/orphans">Meet our children</a>
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/about.html">About us</a>
            </div>
        </div>
    </section>

    <section class="home-gallery">
        <div class="home-gallery-card">
            <img src="${pageContext.request.contextPath}/images/home/children-outdoor.png" alt="Children standing outside the home" loading="lazy">
            <div class="home-gallery-caption">
                <h3>Life at Hope Haven</h3>
                <p>Safe shelter, daily meals, and a caring community in Pokhara.</p>
            </div>
        </div>
    </section>

    <div class="stats">
        <div class="stat-card">
            <strong>${activeChildren}</strong>
            <span class="label">Children in active care</span>
        </div>
        <div class="stat-card">
            <strong>${totalDonors}</strong>
            <span class="label">Registered donors</span>
        </div>
        <div class="stat-card">
            <strong>${totalVolunteers}</strong>
            <span class="label">Volunteers</span>
        </div>
        <div class="stat-card">
            <strong>NRs. <fmt:formatNumber value="${totalDonations}" maxFractionDigits="0"/></strong>
            <span class="label">Total donations</span>
        </div>
    </div>

    <section class="content-section meal-schedule-section">
        <h2>Daily meal schedule</h2>
        <p class="lead">Nutritious meals are served on time every day for all children in our care.</p>
        <div class="meal-grid">
            <article class="meal-card meal-breakfast">
                <span class="meal-icon" aria-hidden="true">&#9728;</span>
                <h3>Breakfast</h3>
                <p class="meal-time">7:00 AM – 8:00 AM</p>
                <p>Warm porridge, eggs, fruit, and tea to start the day with energy.</p>
            </article>
            <article class="meal-card meal-lunch">
                <span class="meal-icon" aria-hidden="true">&#9728;</span>
                <h3>Lunch</h3>
                <p class="meal-time">12:30 PM – 1:30 PM</p>
                <p>Dal, bhat, seasonal vegetables, and protein for growing bodies.</p>
            </article>
            <article class="meal-card meal-dinner">
                <span class="meal-icon" aria-hidden="true">&#9790;</span>
                <h3>Dinner</h3>
                <p class="meal-time">6:30 PM – 7:30 PM</p>
                <p>Hearty evening meal followed by study time and rest.</p>
            </article>
        </div>
    </section>

    <h2>How the system works</h2>
    <p class="lead">Visitors see only active children. Administrators manage full records, donations, time-slot analytics, and reports.</p>

    <div class="feature-grid">
        <div class="feature-box">
            <h3>Public profiles</h3>
            <p>Browse children currently in care with photos, education, and wellbeing notes.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/public/orphans">View children</a>
        </div>
        <div class="feature-box">
            <h3>Donate</h3>
            <p>Support meals, education, and healthcare. You receive a thank-you confirmation.</p>
            <a class="btn btn-sm btn-accent" href="${pageContext.request.contextPath}/donate">Give today</a>
        </div>
        <div class="feature-box">
            <h3>Administration</h3>
            <p>Dashboard with statistics flow, charts, and time-slot activity tracking.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/login">Admin login</a>
        </div>
        <div class="feature-box">
            <h3>Volunteers</h3>
            <p>Track donor skills, volunteer availability, and every contribution.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/apply-volunteer">Volunteer</a>
        </div>
        <div class="feature-box">
            <h3>About &amp; contact</h3>
            <p>Meet our leadership team or send a message.</p>
            <a class="btn btn-sm" href="${pageContext.request.contextPath}/about.html">About</a>
            <a class="btn btn-sm btn-secondary" href="${pageContext.request.contextPath}/contact.html">Contact</a>
        </div>
    </div>
</div>
</main>

<%@ include file="/WEB-INF/jspf/footer.jspf" %>
</body>
</html>
