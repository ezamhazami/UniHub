<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Merchandise Orders</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            padding: 40px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        th {
            background-color: #1976d2;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f9ff;
        }

        tr:hover {
            background-color: #e3f2fd;
        }

        .total-row {
            font-weight: bold;
            background-color: #d1ecf1;
        }

        .back-link {
            display: block;
            margin: 30px auto;
            text-align: center;
            background-color: #444;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 6px;
            width: max-content;
        }

        .back-link:hover {
            background-color: #222;
        }
    </style>
</head>
<body>

<h2>📦 Merchandise Orders</h2>

<table>
    <tr>
        <th>Order ID</th>
        <th>Merchandise Name</th>
        <th>Quantity</th>
        <th>Subtotal (RM)</th>
        <th>Ordered By</th>
    </tr>

    <%
        double grandTotal = 0.0;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "SELECT o.ORDER_ID, m.NAME AS MERCH_NAME, od.QUANTITY, od.SUBTOTAL, u.NAME " +
                         "FROM ORDER_DETAILS od " +
                         "JOIN ORDERS o ON od.ORDER_ID = o.ORDER_ID " +
                         "JOIN USERS u ON o.USERID = u.USERID " +
                         "JOIN MERCHANDISE m ON od.MERCH_ID = m.MERCH_ID";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("ORDER_ID");
                String merchName = rs.getString("MERCH_NAME");
                int quantity = rs.getInt("QUANTITY");
                double subtotal = rs.getDouble("SUBTOTAL");
                String userName = rs.getString("NAME");

                grandTotal += subtotal;
    %>
    <tr>
        <td><%= orderId %></td>
        <td><%= merchName %></td>
        <td><%= quantity %></td>
        <td>RM <%= String.format("%.2f", subtotal) %></td>
        <td><%= userName %></td>
    </tr>
    <%
            }

            conn.close();
        } catch (Exception e) {
    %>
    <tr><td colspan="5" style="color: red;">Error: <%= e.getMessage() %></td></tr>
    <%
        }
    %>

    <tr class="total-row">
        <td colspan="3">TOTAL</td>
        <td colspan="2">RM <%= String.format("%.2f", grandTotal) %></td>
    </tr>
</table>

<a class="back-link" href="club_dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
