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
    <title>Event Registration</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            padding: 30px;
            text-align: center;
        }

        h2 {
            margin-bottom: 20px;
        }

        form.filter-form {
            margin-bottom: 30px;
        }

        select, input[type="number"] {
            padding: 5px;
            font-size: 14px;
            margin: 0 10px;
        }

        input[type="submit"] {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .event-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .event-card {
            width: 300px;
            background: white;
            border: 1px solid #ccc;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .event-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .event-details {
            padding: 15px;
            text-align: left;
        }

        .event-details p {
            margin: 5px 0;
        }

        .event-card form {
            margin-top: 10px;
            padding: 0 15px 15px;
        }

        .event-card input[type="submit"] {
            width: 100%;
            background-color: #28a745;
            cursor: pointer;
        }

        .event-card input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h2>Welcome, <%= user.getName() %>! Register for Events</h2>

<form class="filter-form" method="get">
    <label>Club:</label>
    <select name="clubID">
        <option value="">All</option>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
                Statement stmt = conn.createStatement();
                ResultSet clubs = stmt.executeQuery("SELECT ClubID, Club_Name FROM Clubs");
                while (clubs.next()) {
                    int cid = clubs.getInt("ClubID");
                    String cname = clubs.getString("Club_Name");
                    String selected = request.getParameter("clubID") != null && request.getParameter("clubID").equals(String.valueOf(cid)) ? "selected" : "";
                    out.print("<option value='" + cid + "' " + selected + ">" + cname + "</option>");
                }
                conn.close();
            } catch (Exception e) {
                out.print("<option disabled>Error loading clubs</option>");
            }
        %>
    </select>

    <label>Max Capacity:</label>
    <input type="number" name="capacity" placeholder="e.g. 100" value="<%= request.getParameter("capacity") != null ? request.getParameter("capacity") : "" %>">

    <input type="submit" value="Filter">
</form>

<div class="event-container">
<%
    String filterClubID = request.getParameter("clubID");
    String filterCapacity = request.getParameter("capacity");

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

        StringBuilder sql = new StringBuilder(
            "SELECT e.EventID, e.Title, e.Description, e.Date, e.Capacity, e.IMAGE_PATH, c.Club_Name, " +
            "(SELECT COUNT(*) FROM Event_Registration r WHERE r.EventID = e.EventID AND r.Status = 'Confirmed') AS RegisteredCount " +
            "FROM Events e JOIN Clubs c ON e.ClubID = c.ClubID WHERE 1=1"
        );
        if (filterClubID != null && !filterClubID.isEmpty()) {
            sql.append(" AND e.ClubID = ").append(filterClubID);
        }
        if (filterCapacity != null && !filterCapacity.isEmpty()) {
            sql.append(" AND e.Capacity <= ").append(filterCapacity);
        }

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql.toString());

        while (rs.next()) {
            int eid = rs.getInt("EventID");
            String title = rs.getString("Title");
            String desc = rs.getString("Description");
            Date date = rs.getDate("Date");
            int cap = rs.getInt("Capacity");
            int regCount = rs.getInt("RegisteredCount");
            String img = rs.getString("IMAGE_PATH");
            String clubName = rs.getString("Club_Name");
%>
    <div class="event-card">
        <img src="<%= img %>" alt="Event Image">
        <div class="event-details">
            <p><strong>Club:</strong> <%= clubName %></p>
            <p><strong>Title:</strong> <%= title %></p>
            <p><strong>Description:</strong> <%= desc %></p>
            <p><strong>Date:</strong> <%= date %></p>
            <p><strong>Capacity:</strong> <%= cap %></p>
            <p><strong>Registered:</strong> <%= regCount %> / <%= cap %></p>
        </div>
        <form method="post" action="EventRegistrationServlet">
            <input type="hidden" name="eventID" value="<%= eid %>">
            <input type="hidden" name="userID" value="<%= userID %>">
            <input type="submit" value="Join Event">
        </form>
    </div>
<%
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</div>

</body>
</html>
