<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>401 - Unauthorized</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; background: #f5f5f5; }
        .container { background: white; padding: 40px; border-radius: 10px; max-width: 500px; margin: 0 auto; }
        h1 { font-size: 72px; color: #f39c12; margin: 0; }
        p { color: #666; }
        a { color: #3498db; text-decoration: none; }
        .login-btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #3498db; color: white; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>401</h1>
        <h2>Unauthorized Access</h2>
        <p>You don't have permission to view this page.</p>
        <p>Please login with appropriate credentials.</p>
        <a href="${pageContext.request.contextPath}/login.jsp" class="login-btn">Login</a>
    </div>
</body>
</html>