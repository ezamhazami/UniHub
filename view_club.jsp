<%@ page import="java.sql.*, model.bean.User" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"Admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

    String sql = "SELECT c.CLUBID, c.CLUB_NAME, c.DESCRIPTION, u.Name AS ClubRepName " +
                 "FROM CLUBS c JOIN USERS u ON c.USERID = u.UserID";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Clubs</title>
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
        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #2f3e9e;
            font-weight: bold;
        }
    </style>
</head>
<body>

<header>Club Management</header>

<section>
    <h2>All Clubs</h2>
    <table>
        <tr>
            <th>Club ID</th>
            <th>Club Name</th>
            <th>Description</th>
            <th>Club Representative</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("CLUBID") %></td>
            <td><%= rs.getString("CLUB_NAME") %></td>
            <td><%= rs.getString("DESCRIPTION") %></td>
            <td><%= rs.getString("ClubRepName") %></td>
        </tr>
        <%
            }
            rs.close();
            ps.close();
            conn.close();
        %>
    </table>

    <a class="back-link" href="admin_dashboard.jsp">? Back to Dashboard</a>
</section>

</body>
</html>
