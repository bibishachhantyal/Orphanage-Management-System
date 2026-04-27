<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Volunteer Form</title>
    <style>
        body { font-family: Arial; background: #f5f5f5; padding: 20px; }
        .container { max-width: 500px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        h1 { color: #333; }
        label { display: block; margin-top: 15px; font-weight: bold; }
        input, select, textarea { width: 100%; padding: 8px; margin-top: 5px; border: 1px solid #ddd; border-radius: 5px; }
        .btn { background: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; margin-top: 20px; cursor: pointer; }
        .cancel { background: #666; color: white; padding: 10px 20px; text-decoration: none; display: inline-block; margin-top: 20px; margin-left: 10px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>${volunteer == null ? "Add Volunteer" : "Edit Volunteer"}</h1>

        <form action="${pageContext.request.contextPath}/volunteer" method="post">
            <input type="hidden" name="action" value="${volunteer == null ? 'add' : 'update'}">
            <input type="hidden" name="id" value="${volunteer.id}">

            <label>Full Name</label>
            <input type="text" name="fullName" value="${volunteer.fullName}" required>

            <label>Email</label>
            <input type="email" name="email" value="${volunteer.email}" required>

            <label>Phone</label>
            <input type="text" name="phone" value="${volunteer.phone}" required>

            <label>Address</label>
            <textarea name="address" rows="3">${volunteer.address}</textarea>

            <label>Status</label>
            <select name="status">
                <option ${volunteer.status == 'Pending' ? 'selected' : ''}>Pending</option>
                <option ${volunteer.status == 'Active' ? 'selected' : ''}>Active</option>
                <option ${volunteer.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>

            <button type="submit" class="btn">Save</button>
            <a href="${pageContext.request.contextPath}/volunteer" class="cancel">Cancel</a>
        </form>
    </div>
</body>
</html>