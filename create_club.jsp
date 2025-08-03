<%@ page import="model.bean.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Club - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f8ff;
            padding: 2rem;
        }

        .container {
            background: #fff;
            padding: 2rem;
            border-radius: 10px;
            width: 500px;
            margin: auto;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            color: #0044cc;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 1rem;
        }

        input, textarea {
            width: 100%;
            padding: 0.7rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 0.3rem;
        }

        button {
            margin-top: 1.5rem;
            width: 100%;
            padding: 0.8rem;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1rem;
        }

        button:hover {
            background: #0056cc;
        }

        .success {
            color: green;
            text-align: center;
            margin-top: 1rem;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create New Club</h2>

        <% if (request.getAttribute("message") != null) { %>
            <div class="<%= request.getAttribute("status") %>">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>

        <form method="post" action="CreateClubServlet">
            <label for="club_name">Club Name:</label>
            <input type="text" id="club_name" name="club_name" required />

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="4" required></textarea>

            <!-- Hidden userID not required because servlet gets it from session -->
            <button type="submit">Create Club</button>
        </form>
    </div>
</body>
</html>