<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to CampusHub</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap');

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

        /* Background image */
        #bgImage {
            position: fixed;
            top: 0;
            left: 0;
            min-width: 100%;
            min-height: 100%;
            object-fit: cover;
            z-index: -2;
            filter: brightness(0.6) contrast(1.1);
        }

        /* Overlay */
        #bgOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to right, rgba(0,0,0,0.5), rgba(0,0,0,0.6));
            z-index: -1;
        }

        .hero {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px;
            color: white;
        }

        .hero h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 1px 1px 4px #000;
        }

        .hero p {
            font-size: 18px;
            max-width: 600px;
            margin-bottom: 40px;
            text-shadow: 1px 1px 3px #000;
        }

        .btn-group {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
        }

        .btn {
            padding: 14px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            text-decoration: none;
        }

        .btn-login {
            background-color: #ffffff;
            color: #007BFF;
        }

        .btn-register {
            background-color: #0d47a1;
            color: white;
        }

        .btn-login:hover {
            background-color: #e0e0e0;
            transform: translateY(-2px);
        }

        .btn-register:hover {
            background-color: #08306b;
            transform: translateY(-2px);
        }

        .footer {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
            color: #ccc;
            font-size: 14px;
            text-shadow: 1px 1px 2px #000;
        }

        @media (max-width: 600px) {
            .hero h1 {
                font-size: 36px;
            }
            .hero p {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>

<!-- Background Image -->
<img id="bgImage" src="image/landing_page.jpg" alt="Background Image">
<div id="bgOverlay"></div>

<div class="hero">
    <h1>Welcome to Uni-Club Hub 🎓</h1>
    <p>Your one-stop platform to connect, explore events, manage clubs, and purchase exclusive merchandise from your university community.</p>

    <div class="btn-group">
        <a href="Login.jsp" class="btn btn-login">Login</a>
        <a href="Register.jsp" class="btn btn-register">Register</a>
    </div>
</div>

<div class="footer">
    &copy; <%= java.time.Year.now() %> Uni-Club Hub. All rights reserved.
</div>

</body>
</html>
