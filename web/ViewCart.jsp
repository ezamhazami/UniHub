<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.bean.CartItem" %>
<%@ page import="dao.CartDAO" %>
<%@ page import="model.bean.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    CartDAO dao = new CartDAO();
    List<CartItem> cartItems = dao.getCartItems(user.getUserID());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Cart - CampusHub</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f7fa;
            padding: 40px;
        }
        h2 {
            text-align: center;
            color: #2f3e9e;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #2f3e9e;
            color: white;
        }
        img {
            width: 100px;
            border-radius: 8px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
        }
        .btn-remove {
            background-color: #dc3545;
            color: white;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .total {
            text-align: right;
            padding: 20px 0;
            width: 90%;
            margin: auto;
            font-size: 18px;
        }
        .checkout {
            text-align: center;
            margin-top: 20px;
        }
        .btn-checkout {
            padding: 12px 30px;
            background-color: #2f3e9e;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .btn-checkout:hover {
            background-color: #1a2b8f;
        }

        .back-btn {
            display: block;
            width: fit-content;
            margin: 20px auto;
            background: #007BFF;           /* Primary blue */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
         }
         .back-btn:hover {
             background: #0056b3;           /* Darker blue on hover */
         }

    </style>
</head>
<body>

<h2><i class="fas fa-shopping-cart"></i> My Cart</h2>

<% if (cartItems == null || cartItems.isEmpty()) { %>
    <p style="text-align:center; color:#888;">Your cart is empty.</p>
<% } else { 
    double total = 0;
%>
<table>
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Merchandise</th>
        <th>Price (RM)</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Actions</th>
    </tr>
<%
    int i = 1;
    for (CartItem item : cartItems) {
        double subtotal = item.getQuantity() * item.getPrice();
        total += subtotal;
%>
    <tr>
        <td><%= i++ %></td>
        <td><img src="<%= item.getImageUrl() %>" alt="image"></td>
        <td><%= item.getMerchName() %></td>
        <td><%= String.format("%.2f", item.getPrice()) %></td>
        <td>
            <form action="UpdateCartServlet" method="post" style="display:flex; align-items:center; justify-content:center; gap:5px;">
                <input type="hidden" name="merchId" value="<%= item.getMerchId() %>">
                <input type="number" name="quantity" value="<%= (item.getQuantity() > 0 ? item.getQuantity() : 1) %>" min="1" style="width:60px;">
                <button type="submit" class="btn btn-update"><i class="fas fa-sync-alt"></i> Update</button>
            </form>
        </td>
        <td>RM <%= String.format("%.2f", subtotal) %></td>
        <td>
            <form action="RemoveCartItemServlet" method="post">
                <input type="hidden" name="merchId" value="<%= item.getMerchId() %>">
                <button type="submit" class="btn btn-remove"><i class="fas fa-trash-alt"></i> Remove</button>
            </form>
        </td>
    </tr>
<% } %>
</table>

<div class="total">
    <strong>Total:</strong> RM <%= String.format("%.2f", total) %>
</div>

<div class="checkout">
    <form action="ConfirmOrderServlet" method="post" onsubmit="return validatePayment();">
        <input type="hidden" name="mode" value="cart">

        <div style="margin-bottom: 15px;">
            <label for="paymentMethod" style="font-weight: bold;">Select Payment Method:</label><br>
            <select name="paymentMethod" id="paymentMethod" style="margin-top: 5px; padding: 8px; border-radius: 6px; border: 1px solid #ccc;">
                <option value="">-- Choose a Payment Method --</option>
                <option value="FPX">Online Banking (FPX)</option>
                <option value="CreditCard">Credit Card</option>
                <option value="COD">Cash on Delivery</option>
            </select>
        </div>

        <button type="submit" class="btn-checkout">
            <i class="fas fa-money-check-alt"></i> Confirm & Pay
        </button>
    </form>

</div>

<!-- Font Awesome (for icon) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<!-- JavaScript Validation -->
<script>
function validatePayment() {
    const method = document.getElementById("paymentMethod").value;
    if (method === "") {
        alert("Please select a payment method before proceeding.");
        return false;
    }
    return true;
}
</script>


<% } %>

<a href="Dashboard.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

</body>
</html>