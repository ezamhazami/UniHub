<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Logged Out - CampusHub</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .message {
            text-align: center;
            background-color: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
            border: 2px solid #2f3e9e;
        }

        h2 {
            color: #2f3e9e;
            margin-bottom: 20px;
        }

        p {
            margin: 0;
        }

        a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #2f3e9e;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #1a2b8f;
        }
    </style>
</head>
<body>
    <div class="message">
        <h2>You have successfully logged out.</h2>
        <p><a href="Login.jsp">Login again</a></p>
    </div>
</body>
</html>