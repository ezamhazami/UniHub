<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, model.bean.User" %>

<%
    // Ensure user is logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int userID = user.getUserID();
    int clubId = 0;
    String clubName = "";

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

        String sql = "SELECT ClubID, Club_Name FROM Clubs WHERE UserID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            clubId = rs.getInt("ClubID");
            clubName = rs.getString("Club_Name");
        } else {
            out.println("<p style='color:red;'>No club found for your account.</p>");
            return;
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading club info: " + e.getMessage() + "</p>");
        return;
    }

    String selectedEventId = request.getParameter("eventId");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Event Registrants</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f0f8fc;
            margin: 0;
            padding: 40px;
        }

        h2 {
            color: #333;
            font-size: 30px;
            margin-bottom: 10px;
        }

        .club-info {
            font-size: 18px;
            margin-bottom: 20px;
            color: #555;
        }

        .event-form {
            margin-bottom: 30px;
        }

        .event-form select, .event-form input[type="submit"] {
            padding: 10px;
            font-size: 16px;
            margin-right: 10px;
        }

        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #2196F3;
            color: white;
        }

        tr:hover {
            background-color: #f1faff;
        }

        .no-data {
            color: #999;
            font-style: italic;
            text-align: center;
        }

        .back-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .back-btn:hover {
            background-color: #1565c0;
        }
    </style>
</head>
<body>

    <h2>Registered Students</h2>
    <div class="club-info"><strong>Club:</strong> <%= clubName %> (ID: <%= clubId %>)</div>

    <!-- Dropdown Form -->
    <form class="event-form" method="get" action="event_registrant.jsp">
        <label for="eventId"><strong>Choose Event:</strong></label>
        <select name="eventId" id="eventId" required>
            <option value="">-- Select an Event --</option>
            <%
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

                    PreparedStatement ps = conn.prepareStatement("SELECT EventID, Title FROM EVENTS WHERE ClubID = ?");
                    ps.setInt(1, clubId);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        int eventId = rs.getInt("EventID");
                        String title = rs.getString("Title");
                        String selected = (String.valueOf(eventId).equals(selectedEventId)) ? "selected" : "";
            %>
                        <option value="<%= eventId %>" <%= selected %>><%= title %></option>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<option disabled>Error loading events</option>");
                }
            %>
        </select>
        <input type="submit" value="View Registrants">
    </form>

    <!-- Registrants Table -->
    <div class="table-container">
        <table>
            <tr>
                <th>Event Title</th>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Registration Date</th>
            </tr>

<%
    if (selectedEventId != null && !selectedEventId.isEmpty()) {
        boolean hasData = false;
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "SELECT e.Title, u.UserID, u.Name, u.Email, r.Reg_date " +
                         "FROM Event_Registration r " +
                         "JOIN Users u ON r.UserID = u.UserID " +
                         "JOIN Events e ON r.EventID = e.EventID " +
                         "WHERE e.EventID = ? ORDER BY r.Reg_date";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(selectedEventId));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                hasData = true;
%>
                <tr>
                    <td><%= rs.getString("Title") %></td>
                    <td><%= rs.getInt("UserID") %></td>
                    <td><%= rs.getString("Name") %></td>
                    <td><%= rs.getString("Email") %></td>
                    <td><%= rs.getDate("Reg_date") %></td>
                </tr>
<%
            }

            if (!hasData) {
%>
                <tr><td colspan="5" class="no-data">No registrants found for this event.</td></tr>
<%
            }

            conn.close();
        } catch (Exception e) {
%>
            <tr><td colspan="5" style="color:red;">Error: <%= e.getMessage() %></td></tr>
<%
        }
    } else {
%>
        <tr><td colspan="5" class="no-data">Please select an event to view registrants.</td></tr>
<%
    }
%>
        </table>
    </div>

    <a class="back-btn" href="club_dashboard.jsp">← Back to Club Dashboard</a>

</body>
</html>
