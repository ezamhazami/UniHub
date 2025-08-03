<%@ page session="true" %>
<%@ page import="model.bean.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard - Uni-Club hub</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: #f0f4fc;
    }

    header {
      background: #007BFF;
      color: white;
      text-align: center;
      padding: 20px 0;
      font-size: 26px;
      font-weight: bold;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    nav {
      background: white;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 40px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .nav-left, .nav-right {
      display: flex;
      gap: 20px;
      align-items: center;
    }

    nav a {
      color: #007BFF;
      text-decoration: none;
      font-weight: bold;
      transition: all 0.3s ease;
    }

    nav a:hover {
      color: #0056b3;
    }

    .container {
      max-width: 1100px;
      margin: 40px auto;
      text-align: center;
    }

    h2 {
      color: #007BFF;
      margin-bottom: 20px;
    }

    .quick-actions {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 25px;
      margin-bottom: 50px;
    }

    .action-btn {
      background: #007BFF;
      color: white;
      padding: 15px 25px;
      border-radius: 10px;
      font-size: 16px;
      text-decoration: none;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      transition: transform 0.3s ease;
    }

    .action-btn:hover {
      background: #0056b3;
      transform: scale(1.05);
    }

    .menu-section {
      background: white;
      border-radius: 15px;
      padding: 30px;
      margin: 30px auto;
      box-shadow: 0 6px 18px rgba(0,0,0,0.05);
    }

    .menu-section h3 {
      text-align: left;
      color: #007BFF;
      margin-bottom: 15px;
    }

    .gallery {
      display: grid;
      grid-template-columns: repeat(2, 1fr); /* 2 images per row */
      gap: 20px;
    }

    .gallery-item {
      text-align: center;
    }

    .gallery-item img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    .gallery-item p {
      margin-top: 10px;
      font-weight: 500;
      color: #2f3e9e;
    }

    footer {
      text-align: center;
      background: #007BFF;
      color: white;
      padding: 15px;
      margin-top: 40px;
    }
  </style>
</head>
<body>

<header>CampusHub</header>

<!-- Add Font Awesome for cart icon support -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<nav>
  <div class="nav-left">
    <a href="Dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="Catalog.jsp"><i class="fas fa-store"></i> Merchandise</a>
    <a href="ViewCart.jsp"><i class="fas fa-shopping-cart"></i> View Cart</a>
    <a href="view_orders.jsp"><i class="fas fa-file-alt"></i> Orders</a>
  </div>
  <div class="nav-right">
    <span><i class="fas fa-user"></i> Welcome, <%= user.getName() %></span>
    <a href="Logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </div>
</nav>


<div class="container">
  <h2>Quick Actions</h2>
  <div class="quick-actions">
    <a href="Catalog.jsp" class="action-btn">Shop Merchandise</a>
    <a href="view_orders.jsp" class="action-btn">View My Orders</a>
    <a href="eventRegistration.jsp" class="action-btn">Browse Events</a>
    <a href="userJoinedEvents.jsp" class="action-btn">My Joined Events</a>
  </div>
</div>

<div class="container menu-section">
  <h3>Popular Events</h3>
  <div class="gallery">
    <div class="gallery-item">
      <img src="image/dashboard_img/event1.jpg" alt="event1">
      <p>Pertandingan Kawad Kaki</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/event2.jpg" alt="event2">
      <p>Sukan Antara Fakulti</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/event3.jpg" alt="event3">
      <p>Sukan Program (SuPro)</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/event4.jpg" alt="event4">
      <p>Sukan Kolej (SUKOL)</p>
    </div>
  </div>
</div>

<div class="container menu-section">
  <h3>Club Highlights</h3>
  <div class="gallery">
    <div class="gallery-item">
      <img src="image/dashboard_img/club1.jpg" alt="club1">
      <p>Kelab Bola Sepak</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/club2.jpg" alt="club2">
      <p>Kelab Berenang</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/club3.jpg" alt="club3">
      <p>Kelab Rekreasi</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/club4.jpg" alt="club4">
      <p>Kelab Badminton</p>
    </div>
  </div>
</div>

<div class="container menu-section">
  <h3>Top Merchandise</h3>
  <div class="gallery">
    <div class="gallery-item">
      <img src="image/dashboard_img/merc1.jpg" alt="merc1">
      <p>Keychain Kelab</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/merc2.jpg" alt="merc2">
      <p>Jersi Kelab</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/merc3.jpg" alt="merc3">
      <p>Topi Kelab</p>
    </div>
    <div class="gallery-item">
      <img src="image/dashboard_img/merc4.jpg" alt="merc4">
      <p>Drawstring Bag Kelab</p>
    </div>
  </div>
</div>

<footer>
  &copy; 2025 Campus Event & Club Merchandise System
</footer>

</body>
</html>
