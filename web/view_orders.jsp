<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="model.bean.User" %>
<%@ page import="model.bean.Order" %>
<%@ page import="model.bean.OrderDetail" %>
<%@ page import="dao.OrderDAO" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    List<Order> orders = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

        OrderDAO dao = new OrderDAO(conn);
        orders = dao.getOrdersByUserId(user.getUserID());

        conn.close();

        // ? Reverse to show oldest orders first
        Collections.reverse(orders);
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading orders: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - CampusHub</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7fa;
            padding: 30px;
            color: #333;
        }

        h2 {
            color: #2f3e9e;
            text-align: center;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #2f3e9e;
            color: white;
        }

        .no-orders {
            text-align: center;
            padding: 30px;
            color: #777;
            font-size: 18px;
        }

        .btn-back {
            display: block;
            width: fit-content;
            margin: 40px auto 0;
            padding: 12px 25px;
            background-color: #2f3e9e;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .btn-back:hover {
            background-color: #1a2b8f;
        }
    </style>
</head>
<body>

<h2>My Order History</h2>

<% if (orders == null || orders.isEmpty()) { %>
    <div class="no-orders">You haven't placed any orders yet.</div>
<% } else { %>

<table>
    <tr>
        <th>Order No.</th>
        <th>Order Date</th>
        <th>Total Amount</th>
        <th>No.</th>
        <th>Merchandise</th>
        <th>Quantity</th>
        <th>Subtotal</th>
    </tr>

<%
    int orderCount = 1;
    for (Order order : orders) {
        List<OrderDetail> details = order.getDetails();
        int rowSpan = (details != null) ? details.size() : 1;

        for (int i = 0; i < rowSpan; i++) {
            OrderDetail d = details.get(i);
%>
    <tr>
        <% if (i == 0) { %>
            <td rowspan="<%= rowSpan %>">#<%= orderCount %></td>
            <td rowspan="<%= rowSpan %>"><%= order.getDate() %></td>
            <td rowspan="<%= rowSpan %>">RM <%= String.format("%.2f", order.getTotal()) %></td>
        <% } %>
        <td><%= i + 1 %></td>
        <td><%= d.getMerchName() %></td>
        <td><%= d.getQuantity() %></td>
        <td>RM <%= String.format("%.2f", d.getSubtotal()) %></td>
    </tr>
<%
        }
        orderCount++;
    }
%>
</table>

<% } %>

<a href="Dashboard.jsp" class="btn-back"> Back to Dashboard</a>

</body>
</html>