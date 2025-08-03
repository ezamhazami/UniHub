<%@ page import="java.sql.*" %>
<%@ page import="model.bean.User" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"Admin".equalsIgnoreCase(admin.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }

    Class.forName("org.apache.derby.jdbc.ClientDriver");
    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

    // Only get ClubReps who are not already assigned to any club
    String sql = "SELECT UserID, Name FROM Users WHERE Role = 'ClubRep' AND UserID NOT IN (SELECT UserID FROM Clubs)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Club</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Poppins', sans-serif;
            box-sizing: border-box;
        }
        body {
            background: #f4f7fa;
            margin: 0;
            padding: 0;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #2f3e9e;
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
        }
        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            margin-top: 25px;
            width: 100%;
            padding: 12px;
            background: #2f3e9e;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: #1a2b8f;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #2f3e9e;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add New Club</h2>
    <form action="AddClubServlet" method="post">
        <label for="clubName">Club Name:</label>
        <input type="text" name="clubName" id="clubName" required>

        <label for="description">Description:</label>
        <textarea name="description" id="description" rows="4" required></textarea>

        <label for="userId">Assign ClubRep:</label>
        <select name="userId" id="userId" required>
            <option value="">-- Select Available ClubRep --</option>
            <%
                boolean hasClubReps = false;
                while (rs.next()) {
                    hasClubReps = true;
                    int uid = rs.getInt("UserID");
                    String uname = rs.getString("Name");
            %>
                <option value="<%= uid %>"><%= uname %></option>
            <%
                }
                if (!hasClubReps) {
            %>
                <option disabled>No ClubReps available</option>
            <%
                }
                rs.close();
                ps.close();
                conn.close();
            %>
        </select>

        <input type="submit" value="Add Club" <%= hasClubReps ? "" : "disabled" %>>
    </form>

    <a class="back-link" href="admin_dashboard.jsp">? Back to Dashboard</a>
</div>

</body>
</html>
