<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - CampusHub</title>
    <style>
        body {
            background: #f0f4ff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-box {
            position: relative;
            max-width: 400px;
            margin: 80px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 0 25px rgba(0, 123, 255, 0.4);
        }

        .login-box h2 {
           text-align: center;
            color: #007BFF;
            margin-bottom: 25px;
        }

        .login-box input[type="email"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f2f7ff;
            font-size: 1rem;
        }

        .login-box button {
            width: 100%;
            padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
        }

        .login-box button:hover {
            background-color: #0056cc;
        }

        .login-box p {
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .login-box a {
            color: #007bff;
            text-decoration: none;
        }

        .error {
            color: red;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Login</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <% 
            String errorTitle = (String) request.getAttribute("errorTitle");
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div style="background-color: #ffdddd; color: #a94442; border: 1px solid #f5c6cb; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
                <h4 style="margin-top: 0; color: #a94442;"><%= errorTitle %></h4>
                <p><%= errorMessage %></p>
            </div>
        <% } %>

        
        <form method="post" action="AdminLoginServlet">
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <button type="submit">Login</button>
        </form>

        <p>Back to <a href="Login.jsp">User Login</a></p>
    </div>
</body>
</html>
