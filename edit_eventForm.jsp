<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    int eventId = Integer.parseInt(request.getParameter("eventId"));

    String title = "";
    String date = "";
    String description = "";
    int capacity = 0;
    int clubId = 0;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(
            "jdbc:derby://localhost:1527/CampusHub", "app", "app");

        String sql = "SELECT * FROM EVENTS WHERE EVENTID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, eventId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            title = rs.getString("TITLE");
            date = rs.getString("DATE");
            description = rs.getString("DESCRIPTION");
            capacity = rs.getInt("CAPACITY");
            clubId = rs.getInt("CLUBID");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading event: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Event</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f8f9;
            padding: 30px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background-color: #fff;
            width: 60%;
            margin: auto;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 12px;
        }

        td:first-child {
            text-align: right;
            font-weight: bold;
            width: 30%;
        }

        input[type="text"],
        input[type="date"],
        input[type="number"],
        textarea {
            width: 95%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        input[disabled] {
            background-color: #eee;
            color: #555;
        }

        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 15px;
        }

        button:hover {
            background-color: #45a049;
        }

        a.cancel-link {
            margin-left: 15px;
            color: #777;
            text-decoration: none;
            font-size: 14px;
        }

        a.cancel-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>Edit Event</h2>

    <form action="EditEventServlet" method="post">
        <input type="hidden" name="eventId" value="<%= eventId %>">

        <table>
            <tr>
                <td>Event Title:</td>
                <td><input type="text" name="title" value="<%= title %>" required></td>
            </tr>
            <tr>
                <td>Date:</td>
                <td><input type="date" name="date" value="<%= date %>" required></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><textarea name="description" rows="4" required><%= description %></textarea></td>
            </tr>
            <tr>
                <td>Capacity:</td>
                <td><input type="number" name="capacity" value="<%= capacity %>" required></td>
            </tr>
            <tr>
                <td>Club ID:</td>
                <td>
                    <input type="number" value="<%= clubId %>" disabled>
                    <input type="hidden" name="clubId" value="<%= clubId %>">
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button type="submit">Update Event</button>
                    <a href="editEvent.jsp" class="cancel-link">Cancel</a>
                </td>
            </tr>
        </table>
    </form>

</body>
</html>
