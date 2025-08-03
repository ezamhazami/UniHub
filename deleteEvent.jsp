<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.bean.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int userID = user.getUserID();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Event</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f8f9;
            padding: 40px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 40px;
            font-size: 32px;
        }

        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .card {
            background-color: white;
            width: 280px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: scale(1.03);
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 6px;
            transition: background-color 0.3s;
        }

        .card a:hover {
            background-color: #388e3c;
        }

        .icon {
            font-size: 40px;
            margin-bottom: 10px;
            color: #4CAF50;
        }

        .event-section {
            margin-top: 50px;
            background-color: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .event-card {
            display: flex;
            gap: 30px;
            align-items: center;
            margin-bottom: 30px;
            text-align: left;
        }

        .event-card img {
            width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .event-details p {
            margin: 6px 0;
            font-size: 16px;
        }

        .event-details span {
            font-weight: bold;
            color: #333;
        }

        .nav-buttons {
            display: flex;
            justify-content: center;
            gap: 30px;
        }

        .nav-buttons a {
            padding: 12px 24px;
            background-color: #2196F3;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .nav-buttons a:hover {
            background-color: #1565c0;
        }

        form {
            margin-top: 40px;
        }

        input[type="number"], input[type="submit"] {
            padding: 10px;
            font-size: 16px;
            margin-top: 10px;
        }

        input[type="submit"] {
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
        }

        input[type="submit"]:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>

    <h2>Delete Event</h2>

    <div class="event-section">
        <div class="icon">🗑️</div>
        <h3>Your Club's Events</h3>

        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

                String sql = "SELECT E.EVENTID , C.Club_Name, E.Title, E.Date, E.Capacity, E.Image_Path " +
                             "FROM Users U " +
                             "JOIN Clubs C ON U.UserID = C.UserID " +
                             "JOIN Events E ON C.ClubID = E.ClubID " +
                             "WHERE U.UserID = ? ORDER BY E.Date";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, userID);

                ResultSet rs = ps.executeQuery();
                boolean hasEvents = false;

                while (rs.next()) {
                    hasEvents = true;
                    int eventID = rs.getInt("EVENTID");
                    String clubName = rs.getString("Club_Name");
                    String title = rs.getString("Title");
                    Date date = rs.getDate("Date");
                    int capacity = rs.getInt("Capacity");
                    String imagePath = rs.getString("Image_Path");
        %>
            <div class="event-card">
                <img src="<%= imagePath %>" alt="Event Image">
                <div class="event-details">
                    <p><span>Event ID:</span> <%= eventID %></p>
                    <p><span>Club:</span> <%= clubName %></p>
                    <p><span>Title:</span> <%= title %></p>
                    <p><span>Date:</span> <%= date %></p>
                    <p><span>Capacity:</span> <%= capacity %></p>
                </div>
            </div>
        <%
                }

                if (!hasEvents) {
        %>
            <p>No events found for your club.</p>
        <%
                }

                rs.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error fetching events.</p>");
                e.printStackTrace();
            }
        %>

        <form action="DeleteEventServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this event?');">
            <label for="eventId">Enter Event ID to Delete:</label><br>
            <input type="number" name="eventId" id="eventId" required><br><br>
            <input type="submit" value="Delete Event">
        </form>

        <div class="nav-buttons" style="margin-top: 30px;">
            <a href="club_dashboard.jsp">Back to Event Management</a>
        </div>

    </div>

</body>
</html>
