<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - CampusHub</title>
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
        }

        #bgVideo {
            position: fixed;
            top: 0;
            left: 0;
            min-width: 100%;
            min-height: 100%;
            object-fit: cover;
            z-index: -1;
            filter: brightness(0.6);
        }

        .container {
            position: relative;
            max-width: 450px;
            margin: 80px auto;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 0 25px rgba(0, 123, 255, 0.4);
        }

        h2 {
            text-align: center;
            color: #007BFF;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            background-color: #f8f8f8;
            transition: border 0.3s;
        }

        input:focus, select:focus {
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
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        p {
            text-align: center;
            margin-top: 15px;
            color: #333;
        }

        a {
            color: #007BFF;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            font-size: 14px;
        }

        .error {
            background-color: #e74c3c;
            color: #fff;
        }

        .success {
            background-color: #2ecc71;
            color: #000;
        }

        @media (max-width: 500px) {
            .container {
                margin: 40px 20px;
                padding: 30px;
            }
        }
    </style>
</head>
<body>

    <video autoplay muted loop id="bgVideo">
        <source src="videos/campus.mp4" type="video/mp4">
        Your browser does not support HTML5 video.
    </video>

    <div class="container">
        <h2>Register for CampusHub</h2>

        <% if (error != null) { %>
            <div class="message error"><%= error %></div>
        <% } %>
        <% if (success != null) { %>
            <div class="message success"><%= success %></div>
        <% } %>

        <form action="RegisterUser" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email Address" required>
            <input type="password" name="password" placeholder="Create Password" required>
            <select name="role" required>
                <option value="" disabled selected>Select Role</option>
                <option value="Student">Student</option>
                <option value="ClubRep">Club Representative</option>
            </select>
            <input type="submit" value="Register">
        </form>

        <p>Already have an account? <a href="Login.jsp">Login here</a></p>
    </div>

</body>
</html>
