<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Events</title>
    <style>
        /* Same CSS as before (kept for style continuity) */
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            padding: 30px;
            text-align: center;
        }

        h2, h3 {
            color: #333;
        }

        form {
            margin-bottom: 30px;
        }

        select {
            padding: 6px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
            font-size: 16px;
        }

        input[type="submit"] {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .events-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .event-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 250px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            text-align: left;
            overflow: hidden;
        }
                .event-card {
            width: 350px; /* or 400px */
        }


                .event-card img {
            width: 100%;
            height: 300px; /* increased from 180px */
            object-fit: cover;
            border-bottom: 1px solid #ddd;
        }


        .event-details {
            padding: 15px;
        }

        .event-details p {
            margin: 5px 0;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
        }

        a:hover {
            background-color: #1e7e34;
        }

        .message {
            margin-top: 20px;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <h2>View Events by Club</h2>

    <form method="get">
        <label for="clubID">Select Club:</label>
        <select name="clubID" id="clubID" required>
            <option value="">-- Select Club --</option>
            <%
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:derby://localhost:1527/CampusHub", "app", "app");

                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT ClubID, Club_Name FROM Clubs");

                    while (rs.next()) {
                        int clubID = rs.getInt("ClubID");
                        String clubName = rs.getString("Club_Name");

                        // Preserve selection after form submit
                        String selected = (request.getParameter("clubID") != null &&
                                           request.getParameter("clubID").equals(String.valueOf(clubID)))
                                          ? "selected" : "";
                        out.println("<option value='" + clubID + "' " + selected + ">" + clubName + "</option>");
                    }

                    conn.close();
                } catch (Exception e) {
                    out.println("<option disabled>Error loading clubs</option>");
                }
            %>
        </select>
        <input type="submit" value="View Events">
    </form>

    <%
        String clubIDStr = request.getParameter("clubID");
        if (clubIDStr != null && !clubIDStr.isEmpty()) {
            try {
                int clubID = Integer.parseInt(clubIDStr);

                // Get club name
                String clubName = "";
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");

                PreparedStatement nameStmt = conn.prepareStatement("SELECT Club_Name FROM Clubs WHERE ClubID = ?");
                nameStmt.setInt(1, clubID);
                ResultSet nameRs = nameStmt.executeQuery();
                if (nameRs.next()) {
                    clubName = nameRs.getString("Club_Name");
                }

                %>
                <h3>Events for <%= clubName %></h3>
                <div class="events-container">
                <%
                    String sql = "SELECT EventID, Title, Description, Date, Capacity, IMAGE_PATH FROM Events WHERE ClubID = ?";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, clubID);

                    ResultSet rs = ps.executeQuery();

                    boolean hasEvents = false;
                    while (rs.next()) {
                        hasEvents = true;
                        int eventID = rs.getInt("EventID");
                        String title = rs.getString("Title");
                        String description = rs.getString("Description");
                        Date date = rs.getDate("Date");
                        int capacity = rs.getInt("Capacity");
                        String imagePath = rs.getString("IMAGE_PATH");
                %>
                    <div class="event-card">
                        <% if (imagePath != null && !imagePath.isEmpty()) { %>
                            <img src="<%= imagePath %>" alt="Event Image">
                        <% } else { %>
                            <img src="image/default.jpg" alt="No Image">
                        <% } %>
                        <div class="event-details">
                            <p><strong>Event ID:</strong> <%= eventID %></p>
                            <p><strong>Title:</strong> <%= title %></p>
                            <p><strong>Description:</strong> <%= description %></p>
                            <p><strong>Date:</strong> <%= date %></p>
                            <p><strong>Capacity:</strong> <%= capacity %></p>
                        </div>
                    </div>
                <%
                    }

                    if (!hasEvents) {
                %>
                    <p class="message">No events found for this club.</p>
                <%
                    }

                    conn.close();
                %>
                </div>
    <%
            } catch (NumberFormatException e) {
    %>
                <div class="message">Invalid Club selection.</div>
    <%
            } catch (Exception e) {
    %>
                <div class="message">Error loading events. Please try again later.</div>
    <%
                e.printStackTrace();
            }
        }
    %>

    <a href="admin_dashboard.jsp">Back to Dashboard</a>
</body>
</html>
