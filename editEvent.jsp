<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Event List</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            padding: 50px 20px;
            margin: 0;
        }

        h2 {
            color: #0d47a1;
            text-align: center;
            font-size: 36px;
            margin-bottom: 40px;
        }

        table {
            margin: auto;
            width: 95%;
            max-width: 1100px;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 14px 18px;
            text-align: center;
        }

        th {
            background-color: #1976d2;
            color: white;
            font-size: 16px;
            letter-spacing: 0.5px;
        }

        td {
            font-size: 15px;
            color: #333;
        }

        tr:nth-child(even) {
            background-color: #f0f7ff;
        }

        tr:hover {
            background-color: #e1f5fe;
        }

        button {
            padding: 6px 16px;
            background-color: #43a047;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #2e7d32;
        }

        .back-link {
            display: inline-block;
            margin: 30px auto 0;
            text-decoration: none;
            background-color: #1976d2;
            color: white;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .back-link:hover {
            background-color: #0d47a1;
        }

        .no-data {
            text-align: center;
            padding: 20px;
            font-style: italic;
            color: #757575;
        }
    </style>
</head>
<body>

    <h2>📋 Edit Event List</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Date</th>
            <th>Description</th>
            <th>Capacity</th>
            <th>Club ID</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");

                String sql = "SELECT * FROM EVENTS";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("EVENTID") %></td>
            <td><%= rs.getString("TITLE") %></td>
            <td><%= rs.getDate("DATE") %></td>
            <td><%= rs.getString("DESCRIPTION") %></td>
            <td><%= rs.getInt("CAPACITY") %></td>
            <td><%= rs.getInt("CLUBID") %></td>
            <td>
                <form action="edit_eventForm.jsp" method="get" style="margin: 0;">
                    <input type="hidden" name="eventId" value="<%= rs.getInt("EVENTID") %>">
                    <button type="submit">Edit</button>
                </form>
            </td>
        </tr>
        <%
                }

                if (!hasData) {
        %>
        <tr>
            <td colspan="7" class="no-data">No events available.</td>
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

    <div style="text-align: center;">
        <a href="club_dashboard.jsp" class="back-link">← Back to Event Management</a>
    </div>

</body>
</html>
