<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Success - CampusHub</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f4f7fa;
      padding: 60px 20px;
      text-align: center;
    }

    .box {
      max-width: 500px;
      margin: auto;
      background: white;
      border-radius: 12px;
      padding: 40px;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
      animation: fadeIn 1s ease;
    }

    h1 {
      color: #2f3e9e;
      margin-bottom: 15px;
    }

    p {
      color: #555;
      font-size: 18px;
      margin-bottom: 30px;
    }

    a.button {
      display: inline-block;
      background-color: #2f3e9e;
      color: white;
      padding: 12px 30px;
      text-decoration: none;
      font-weight: bold;
      border-radius: 8px;
      transition: background-color 0.3s ease;
    }

    a.button:hover {
      background-color: #1a2b8f;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-20px); }
      to   { opacity: 1; transform: translateY(0); }
    }

    .icon {
      font-size: 60px;
      color: #4CAF50;
      margin-bottom: 20px;
      animation: pop 0.6s ease;
    }

    @keyframes pop {
      0% { transform: scale(0); opacity: 0; }
      60% { transform: scale(1.2); opacity: 1; }
      100% { transform: scale(1); }
    }
  </style>
</head>
<body>

<div class="box">
  <div class="icon"></div>
  <h1>Order Placed Successfully!</h1>
  <p>Thank you for your purchase at CampusHub.<br>
</p>
  <a href="view_orders.jsp" class="button">View My Orders</a>
</div>

</body>
</html>