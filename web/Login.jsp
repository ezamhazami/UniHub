<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - CampusHub</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body, html {
            height: 100%;
            overflow: hidden;
            background-color: f0f4fc;
        }

     

        .top-link {
            position: absolute;
            top: 20px;
            right: 30px;
            z-index: 1;
        }

        .top-link a {
            background-color: #007BFF;
            color: white;
            padding: 10px 16px;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            transition: background-color 0.3s;
        }

        .top-link a:hover {
            background-color: #0056b3;
        }

        .container {
            position: relative;
            max-width: 400px;
            margin: 100px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0, 123, 255, 0.5);
        }

        h2 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 25px;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border-color 0.3s;
        }

        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #007BFF;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007BFF;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        p {
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        p a {
            color: #007BFF;
            text-decoration: none;
        }

        p a:hover {
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .container {
                margin: 50px 20px;
                padding: 30px;
            }

            .top-link {
                right: 15px;
                top: 15px;
            }
        }
    </style>
</head>
<body>

    

    <div class="top-link">
        <a href="admin_login.jsp">Admin Login</a>
    </div>

    <div class="container">
        <h2>Login to CampusHub</h2>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="Register.jsp">Register here</a></p>
    </div>

</body>
</html>
