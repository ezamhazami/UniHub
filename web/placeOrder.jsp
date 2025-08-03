<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="model.bean.Merchandise, dao.MerchandiseDAO" %>
<%@ page session="true" %>
<%
    int merchId = Integer.parseInt(request.getParameter("merch_id"));
    MerchandiseDAO merchDAO = new MerchandiseDAO();
    Merchandise merch = merchDAO.getMerchandiseById(merchId);
%>

<html>
<head>
    <title>Confirm Order</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa;
            padding: 50px;
        }
        .container {
            background: white;
            max-width: 500px;
            margin: auto;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2f3e9e;
            text-align: center;
        }
        input[type="number"], input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            background-color: #2f3e9e;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #1d2d75;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Order: <%= merch.getName() %></h2>
    <form action="OrderServlet" method="post">
        <input type="hidden" name="merch_id" value="<%= merch.getId() %>">
        <input type="hidden" name="price" value="<%= merch.getPrice() %>">
        <label>Quantity:</label>
        <input type="number" name="quantity" value="1" min="1" max="10" required>
        <input type="submit" value="Confirm Order">
    </form>
</div>
</body>
</html>
