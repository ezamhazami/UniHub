<%@ page import="model.bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String merchId = request.getParameter("merchId");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String quantity = request.getParameter("quantity");
    String image = request.getParameter("image");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - CampusHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7fa;
            padding: 40px;
        }

        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2f3e9e;
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            margin-top: 12px;
            display: block;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        input[readonly] {
            background-color: #f2f2f2;
        }

        .product-img {
            display: block;
            margin: 15px auto;
            width: 100%;
            max-height: 180px;
            object-fit: cover;
            border-radius: 8px;
        }

        input[type=submit] {
            background: #2f3e9e;
            color: white;
            font-weight: bold;
            border: none;
            margin-top: 20px;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background: #1a2b8f;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>? Payment Page</h2>

    <img src="<%= image %>" class="product-img" alt="Product">

    <form action="ConfirmOrderServlet" method="post">
        <input type="hidden" name="mode" value="buyNow">
        <input type="hidden" name="merchId" value="<%= merchId %>">
        <input type="hidden" name="price" value="<%= price %>">
        <input type="hidden" name="quantity" value="<%= quantity %>">

        <label>Item:</label>
        <input type="text" value="<%= name %>" readonly>

        <label>Quantity:</label>
        <input type="text" value="<%= quantity %>" readonly>

        <label>Total Amount:</label>
        <input type="text" value="RM <%= Double.parseDouble(price) * Integer.parseInt(quantity) %>" readonly>

        <label>Select Payment Method:</label>
        <select name="paymentMethod" required>
            <option value="Credit Card">Credit Card</option>
            <option value="FPX">FPX</option>
        </select>

        <input type="submit" value="Pay Now">
    </form>
</div>

</body>
</html>