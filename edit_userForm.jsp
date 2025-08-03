<%@ page import="java.sql.*, model.bean.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }
        body {
            margin: 0;
            background: #f4f7fa;
            color: #333;
        }
        header {
            background-color: #222d63;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 26px;
            letter-spacing: 1px;
        }
        section {
            padding: 30px 40px;
            max-width: 600px;
            margin: 0 auto;
            background: #fff;
            margin-top: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2f3e9e;
            margin-bottom: 20px;
            text-align: center;
        }
        form label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
        }
        form input[type="text"],
        form input[type="email"],
        form select {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }
        form input[type="submit"] {
            background-color: #2f3e9e;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        form input[type="submit"]:hover {
            background-color: #1a2b8f;
        }
        .back-link {
            display: inline-block;
            margin-top: 25px;
            text-decoration: none;
            color: white;
            background: #555;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .back-link:hover {
            background-color: #333;
        }
        .back-container {
            text-align: center;
        }
    </style>
</head>
<body>

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"Admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int userId = Integer.parseInt(request.getParameter("userId"));

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

    PreparedStatement ps = conn.prepareStatement("SELECT * FROM Users WHERE UserID = ?");
    ps.setInt(1, userId);
    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("edit_user.jsp?error=UserNotFound");
        return;
    }

    String name = rs.getString("Name");
    String email = rs.getString("Email");
    String role = rs.getString("Role");

    rs.close();
    ps.close();
    conn.close();
%>

<header>Edit User</header>

<section>
    <h2>Edit User Details</h2>
    <form action="EditUserServlet" method="post">
        <input type="hidden" name="userId" value="<%= userId %>">

        <label for="name">Name:</label>
        <input type="text" name="name" id="name" value="<%= name %>" required>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" value="<%= email %>" required>

        <label for="role">Role:</label>
        <select name="role" id="role">
            <option value="User" <%= "User".equals(role) ? "selected" : "" %>>User</option>
            <option value="Admin" <%= "Admin".equals(role) ? "selected" : "" %>>Admin</option>
            <option value="ClubRep" <%= "ClubRep".equals(role) ? "selected" : "" %>>ClubRep</option>
        </select>

        <input type="submit" value="Update User">
    </form>

    <div class="back-container">
        <a href="manageUsers.jsp" class="back-link">? Back to User List</a>
    </div>
</section>

</body>
</html>
