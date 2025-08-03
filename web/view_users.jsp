<%@ page import="java.util.List" %>
<%@ page import="java.sql.*, model.bean.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Users</title>
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
            font-size: 24px;
        }
        section {
            padding: 30px 40px;
        }
        h2 {
            color: #2f3e9e;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #2f3e9e;
            color: white;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .action-btn {
            display: inline-block;
            margin-right: 6px;
            padding: 8px 14px;
            border: none;
            border-radius: 5px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
        }
        .edit-btn {
            background-color: #4CAF50;
            color: white;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
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

    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM Users");
%>

<header>User Management</header>

<section>
    <h2>All Registered Users</h2>
    <table>
        <tr>
            <th>UserID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
        </tr>
    <%
        while (rs.next()) {
            int userId = rs.getInt("UserID");
            String name = rs.getString("Name");
            String email = rs.getString("Email");
            String role = rs.getString("Role");
    %>
        <tr>
            <td><%= userId %></td>
            <td><%= name %></td>
            <td><%= email %></td>
            <td><%= role %></td>
            
        </tr>
    <%
        }
        rs.close();
        stmt.close();
        conn.close();
    %>
    </table>
</section>

</body>
</html>
