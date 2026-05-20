<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Logged out</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<header class="site-nav">
    <div class="inner">
        <a class="brand" href="${pageContext.request.contextPath}/">Hope Haven</a>
    </div>
</header>
<div class="container narrow">
    <h1>You are logged out</h1>
    <p>Thank you for using Hope Haven’s management portal.</p>
    <a class="btn" href="${pageContext.request.contextPath}/login">Sign in again</a>
    <p><a href="${pageContext.request.contextPath}/">Home</a></p>
</div>
</body>
</html>
