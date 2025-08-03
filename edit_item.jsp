<%@page import="model.bean.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int userID = user.getUserID();
    String clubName = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

        PreparedStatement ps = conn.prepareStatement("SELECT Club_Name FROM Clubs WHERE UserID = ?");
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            clubName = rs.getString("Club_Name");
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error retrieving club info: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Merchandise List</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f4f8;
            padding: 40px;
            margin: 0;
        }

        h2 {
            text-align: center;
            color: #0d47a1;
            font-size: 32px;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            max-width: 1000px;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-radius: 12px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 16px;
            text-align: center;
        }

        th {
            background-color: #1976d2;
            color: white;
            font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f1f9ff;
        }

        tr:hover {
            background-color: #e3f2fd;
        }

        button {
            padding: 6px 12px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #388e3c;
        }

        a.back-link {
            display: block;
            width: max-content;
            margin: 30px auto 0;
            text-align: center;
            background-color: #1976d2;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        a.back-link:hover {
            background-color: #0d47a1;
        }

        .no-data {
            text-align: center;
            font-style: italic;
            color: #666;
        }
    </style>
</head>
<body>

    <h2>🛒 Edit Merchandise List</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price (RM)</th>
            <th>Stock</th>
            <th>Image URL</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

                String sql = "SELECT * FROM MERCHANDISE";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("MERCH_ID") %></td>
            <td><%= rs.getString("NAME") %></td>
            <td><%= rs.getString("DESCRIPTION") %></td>
            <td><%= String.format("%.2f", rs.getDouble("PRICE")) %></td>
            <td><%= rs.getInt("STOCK") %></td>
            <td><%= rs.getString("IMAGE_URL") %></td>
            <td>
                <form action="edit_merchForm.jsp" method="get" style="margin: 0;">
                    <input type="hidden" name="id" value="<%= rs.getInt("MERCH_ID") %>">
                    <button type="submit">Edit</button>
                </form>
            </td>
        </tr>
        <%
                }

                if (!hasData) {
        %>
        <tr>
            <td colspan="7" class="no-data">No merchandise to edit.</td>
        </tr>
        <%
                }

                conn.close();
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="7" style="color: red;">Error: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
    </table>

    <a href="merchandise.jsp" class="back-link">← Back to Merchandise</a>

</body>
</html>
