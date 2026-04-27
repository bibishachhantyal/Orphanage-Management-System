<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Volunteer List</title>
    <style>
        body { font-family: Arial; background: #f5f5f5; padding: 20px; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 20px; border-radius: 10px; }
        h1 { color: #333; }
        .btn { background: #4CAF50; color: white; padding: 10px 15px; text-decoration: none; display: inline-block; margin-bottom: 20px; border-radius: 5px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; }
        .edit { background: #2196F3; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; }
        .delete { background: #f44336; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Volunteer Management</h1>
        <a href="${pageContext.request.contextPath}/volunteer/new" class="btn">Add Volunteer</a>

        <table>
            <thead>
                <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Status</th><th>Actions</th></tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${volunteers}">
                    <tr>
                        <td>${v.id}</td>
                        <td>${v.fullName}</td>
                        <td>${v.email}</td>
                        <td>${v.phone}</td>
                        <td>${v.status}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/volunteer/edit/${v.id}" class="edit">Edit</a>
                            <a href="${pageContext.request.contextPath}/volunteer/delete/${v.id}" class="delete" onclick="return confirm('Delete?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>