<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, model.bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Merchandise</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4faff;
            padding: 50px;
        }

        h2 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .form-container {
            width: 500px;
            margin: auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
        }

        td {
            padding: 10px 0;
        }

        td:first-child {
            text-align: right;
            font-weight: bold;
            width: 40%;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        input[type="file"] {
            padding: 6px;
            background-color: #f8f9fa;
            cursor: pointer;
        }

        input[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h2>Add New Merchandise</h2>

<div class="form-container">
    <form action="AddMerchandiseServlet" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>Product Name:</td>
                <td><input type="text" name="productName" required></td>
            </tr>
            <tr>
                <td>Description:</td>
                <td><input type="text" name="description" required></td>
            </tr>
            <tr>
                <td>Image:</td>
                <td><input type="file" name="image" accept="image/*" required></td>
            </tr>
            <tr>
                <td>Price (RM):</td>
                <td><input type="number" name="price" step="0.01" required></td>
            </tr>
            <tr>
                <td>Stock Quantity:</td>
                <td><input type="number" name="stock" required></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Add Merchandise"></td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
