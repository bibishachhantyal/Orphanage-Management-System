<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Error - Orphanage Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/auth.css" />
</head>
<body>

<div class="auth-page">
    <div class="auth-container">

        <div class="auth-header">
            <div class="brand-icon" style="background: linear-gradient(135deg, #ef4444, #dc2626);">
                <span>&#x26A0;</span>
            </div>
            <h1>Something Went Wrong</h1>
            <p>An unexpected error occurred. Please try again.</p>
        </div>

        <div class="auth-form">
            <div style="background: rgba(255,255,255,.85); backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,.6); border-radius: var(--radius-xl); padding: 2rem; box-shadow: 0 20px 60px rgba(0,0,0,.06); text-align: center;">

                <% if (request.getAttribute("error") != null) { %>
                    <p class="error"><%= request.getAttribute("error") %></p>
                <% } %>

                <a href="${pageContext.request.contextPath}/login"
                   style="display: inline-flex; align-items: center; justify-content: center; gap: .5rem; padding: .75rem 2rem; background: linear-gradient(135deg, var(--primary-600), var(--primary-700)); color: #fff; border-radius: var(--radius-md); font-weight: 600; font-size: .938rem; box-shadow: 0 4px 14px rgba(124,58,237,.35); transition: all .25s;">
                    &#x2190; Back to Login
                </a>
            </div>
        </div>

    </div>
</div>

</body>
</html>
