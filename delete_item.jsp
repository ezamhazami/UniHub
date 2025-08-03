<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Merchandise</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #fff6f6;
            padding: 40px;
            text-align: center;
            margin: 0;
        }

        h2 {
            color: #c62828;
            margin-bottom: 30px;
            font-size: 30px;
        }

        table {
            margin: auto;
            width: 90%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        th {
            background-color: #ffcdd2;
            color: #b71c1c;
        }

        tr:nth-child(even) {
            background-color: #fbe9e7;
        }

        tr:hover {
            background-color: #ffebee;
        }

        button {
            padding: 8px 16px;
            background-color: #e53935;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #c62828;
        }

        a.back-link {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            background-color: #757575;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        a.back-link:hover {
            background-color: #424242;
        }

        .no-data {
            padding: 20px;
            color: #888;
        }

        .error {
            color: red;
            padding: 20px;
        }
    </style>
</head>
<body>

    <h2>🗑️ Delete Merchandise List</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Price (RM)</th>
            <th>Stock</th>
            <th>Action</th>
        </tr>

        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");

                String sql = "SELECT * FROM MERCHANDISE";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql);

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("MERCH_ID") %></td>
            <td><%= rs.getString("NAME") %></td>
            <td>RM <%= String.format("%.2f", rs.getDouble("PRICE")) %></td>
            <td><%= rs.getInt("STOCK") %></td>
            <td>
                <form action="DeleteMerchandiseServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this item?');">
                    <input type="hidden" name="merchId" value="<%= rs.getInt("MERCH_ID") %>">
                    <button type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }

                if (!hasData) {
        %>
        <tr><td colspan="5" class="no-data">No merchandise to delete.</td></tr>
        <%
                }

                conn.close();
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="5" class="error">Error: <%= e.getMessage() %></td>
        </tr>
        <%
            }
        %>
    </table>

    <a href="merchandise.jsp" class="back-link">← Back to Merchandise</a>

</body>
</html>
