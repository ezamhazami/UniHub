<%@page import="model.bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int userID = user.getUserID();
%>
<head>
    <title>Create Event</title>
    <link rel="stylesheet" href="css/AddEvent_style.css">
</head>
<body>
    <div class="form-container">
        <h2>Create a New Event</h2>
        
        <form action="AddEventServlet" method="post" enctype="multipart/form-data">
            <label for="title">Title:</label><br>
            <input type="text" name="title" id="title" required><br>

            <label for="description">Description:</label><br>
            <textarea name="description" id="description" rows="4" required></textarea><br>

            <label for="date">Date:</label><br>
            <input type="date" name="date" id="date" required><br>

            <label for="capacity">Capacity:</label><br>
            <input type="number" name="capacity" id="capacity" min="1" required><br>

            <%
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    Connection conn = DriverManager.getConnection(
                        "jdbc:derby://localhost:1527/CampusHub", "app", "app");

                    PreparedStatement ps = conn.prepareStatement("SELECT ClubID, Club_Name FROM Clubs WHERE userid = ?");
                    ps.setInt(1, userID);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        int clubID = rs.getInt("ClubID");
                        String clubName = rs.getString("Club_Name");
            %>
                        <p><strong>Club:</strong> <%= clubID %> - <%= clubName %></p>
                        <input type="hidden" name="clubID" value="<%= clubID %>">
            <%
                    } else {
            %>
                        <p style="color: red;">No club found for your user.</p>
            <%
                    }

                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
            %>
                    <p style="color: red;">Error loading your club.</p>
            <%
                    e.printStackTrace();
                }
            %>

            <label for="image">Event Image:</label><br>
            <input type="file" name="image" id="image" accept="image/*" required><br>

            <input type="submit" value="Create Event">
        </form>
    </div>
</body>
</html>
