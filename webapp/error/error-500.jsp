<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>500 - Server Error</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; background: #f5f5f5; }
        .container { background: white; padding: 40px; border-radius: 10px; max-width: 500px; margin: 0 auto; }
        h1 { font-size: 72px; color: #e67e22; margin: 0; }
        p { color: #666; }
        a { color: #3498db; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h1>500</h1>
        <h2>Internal Server Error</h2>
        <p>Something went wrong on our server. Please try again later.</p>
        <a href="${pageContext.request.contextPath}/">Go to Homepage</a>
    </div>
</body>
</html>