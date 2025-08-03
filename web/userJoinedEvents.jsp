<%@ page import="java.sql.*, model.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>My Joined Events</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 30px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
        }

        .event-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .event-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            width: 320px;
            overflow: hidden;
            text-align: left;
        }

                .event-card img {
            width: 100%;
            height: 200px;
            object-fit: contain;
            background-color: #f8f8f8; /* optional to fill extra space */
        }


        .event-details {
            padding: 15px;
        }

        .event-details p {
            margin: 8px 0;
        }

        .status-confirmed {
            color: green;
            font-weight: bold;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        a.back-link {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>

<h2>👤 <%= user.getName() %>'s Joined Events</h2>
<%
    String statusMsg = request.getParameter("status");
    if (statusMsg != null) {
%>
    <script>
        alert("Registration complete.");
    </script>
<%
    }
%>


<div class="event-container">
<%
    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection(
            "jdbc:derby://localhost:1527/CampusHub", "app", "app");

        String sql = "SELECT e.Title, e.Date, e.IMAGE_PATH, er.Status " +
                     "FROM Events e JOIN Event_Registration er ON e.EventID = er.EventID " +
                     "WHERE er.UserID = ?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userID);
        ResultSet rs = ps.executeQuery();

        boolean hasEvents = false;
        while (rs.next()) {
            hasEvents = true;
            String title = rs.getString("Title");
            Date date = rs.getDate("Date");
            String imagePath = rs.getString("IMAGE_PATH");
            String regStatus = rs.getString("Status");
%>
    <div class="event-card">
        <img src="<%= imagePath %>" alt="Event Image">
        <div class="event-details">
            <p><strong>Title:</strong> <%= title %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <p><strong>Status:</strong> 
                <span class="<%= "Confirmed".equalsIgnoreCase(regStatus) ? "status-confirmed" : "status-pending" %>">
                    <%= regStatus %>
                </span>
            </p>
        </div>
    </div>
<%
        }

        if (!hasEvents) {
            out.println("<p>You have not joined any events yet.</p>");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading joined events.</p>");
        e.printStackTrace();
    }
%>
</div>

<a class="back-link" href="Dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
