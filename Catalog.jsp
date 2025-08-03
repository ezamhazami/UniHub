<%@ page import="java.util.List" %>
<%@ page import="model.bean.Merchandise" %>
<%@ page import="dao.MerchandiseDAO" %>
<%@ page import="model.bean.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    MerchandiseDAO merchDao = new MerchandiseDAO();
    List<Merchandise> merchList = merchDao.getAllMerchandise();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Merchandise Catalog - CampusHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            padding: 30px;
            background: #f4f7fa;
        }
        h2 {
            text-align: center;
            color: #2f3e9e;
            margin-bottom: 10px;
            font-size: 28px;
        }
        .section-icon {
            text-align: center;
            color: #007BFF;
            font-size: 22px;
            margin-bottom: 30px;
        }
        a.back-btn {
            display: inline-block;
            background: #007BFF;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            margin-bottom: 20px;
            transition: 0.3s;
        }
        a.back-btn:hover {
            background: #0056b3;
        }
        .catalog {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }
        .item {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.2s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 460px;
        }
        .item:hover {
            transform: translateY(-5px);
        }
        .item img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .item h3 {
            color: #2f3e9e;
            font-size: 20px;
            margin-bottom: 5px;
        }
        .item p {
            color: #555;
            font-size: 14px;
            height: 40px;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .item .price {
            font-weight: bold;
            margin: 10px 0;
            color: #007BFF;
        }
        .item form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .item input[type="number"] {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            padding: 10px;
            border: none;
            background-color: #2f3e9e;
            color: white;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #1a2b8f;
        }
    </style>
</head>
<body>

<a href="Dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

<h2><i class="fas fa-store"></i> Club Merchandise Catalog</h2>
<div class="section-icon"><i class="fas fa-star"></i> Browse & Buy your favorite items <i class="fas fa-star"></i></div>

<div class="catalog">
<%
    for (Merchandise m : merchList) {
%>
    <div class="item">
        <img src="<%= m.getImageUrl() %>" alt="merchandise">
        <h3><%= m.getName() %></h3>
        <p><%= m.getDescription() %></p>
        <div class="price">RM <%= m.getPrice() %></div>

        <!-- Buy Now form -->
        <form action="payment.jsp" method="post">
            <input type="hidden" name="merchId" value="<%= m.getMerchId() %>">
            <input type="hidden" name="price" value="<%= m.getPrice() %>">
            <input type="hidden" name="name" value="<%= m.getName() %>">
            <input type="hidden" name="image" value="<%= m.getImageUrl() %>">
            <input type="number" name="quantity" value="1" min="1" required>
            <button type="submit" class="btn"><i class="fas fa-credit-card"></i> Buy Now</button>
        </form>

        <!-- Add to Cart form -->
        <form action="AddToCartServlet" method="post">
            <input type="hidden" name="merchId" value="<%= m.getMerchId() %>">
            <input type="number" name="quantity" value="1" min="1" required>
            <button type="submit" class="btn"><i class="fas fa-cart-plus"></i> Add to Cart</button>
        </form>
    </div>
<%
    }
%>
</div>

</body>
</html>