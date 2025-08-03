<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    int merchId = Integer.parseInt(request.getParameter("id"));

    String name = "";
    String description = "";
    String imageUrl = "";
    double price = 0.0;
    int stock = 0;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

        String sql = "SELECT * FROM MERCHANDISE WHERE MERCH_ID=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, merchId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("NAME");
            description = rs.getString("DESCRIPTION");
            imageUrl = rs.getString("IMAGE_URL");
            price = rs.getDouble("PRICE");
            stock = rs.getInt("STOCK");
        }

        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading merchandise: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Merchandise</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #eef6fc;
            margin: 0;
            padding: 40px 0;
        }

        .form-container {
            width: 500px;
            margin: auto;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #2f3e9e;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #333;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        .form-buttons {
            margin-top: 25px;
            text-align: center;
        }

        .form-buttons button,
        .form-buttons a {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            margin: 0 8px;
            text-decoration: none;
            cursor: pointer;
        }

        .form-buttons button {
            background-color: #4caf50;
            color: white;
        }

        .form-buttons button:hover {
            background-color: #388e3c;
        }

        .form-buttons a {
            background-color: #ddd;
            color: #333;
        }

        .form-buttons a:hover {
            background-color: #bbb;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Edit Merchandise Item</h2>

        <form action="EditMerchandiseServlet" method="post">
            <input type="hidden" name="merchId" value="<%= merchId %>">

            <label for="productName">Product Name:</label>
            <input type="text" name="productName" id="productName" value="<%= name %>" required>

            <label for="description">Description:</label>
            <textarea name="description" id="description" rows="3"><%= description %></textarea>

            <label for="imageUrl">Image URL:</label>
            <input type="text" name="imageUrl" id="imageUrl" value="<%= imageUrl %>">

            <label for="price">Price (RM):</label>
            <input type="number" step="0.01" name="price" id="price" value="<%= price %>" required>

            <label for="stock">Stock Quantity:</label>
            <input type="number" name="stock" id="stock" value="<%= stock %>" required>

            <div class="form-buttons">
                <button type="submit">Update Merchandise</button>
                <a href="merchandise.jsp">Cancel</a>
            </div>
        </form>
    </div>

</body>
</html>
