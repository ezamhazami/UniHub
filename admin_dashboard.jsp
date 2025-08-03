<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="model.bean.User" %>
<%@ page import="model.bean.AdminStats" %>

<jsp:useBean id="stats" class="model.bean.AdminStats" scope="request" />

<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String adminName = admin.getName();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Admin Dashboard - Club Merchandise System</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    * {
      font-family: 'Poppins', sans-serif;
      box-sizing: border-box;
    }
    body {
      margin: 0;
      background: #f4f7fa;
      color: #333;
    }
    header {
      background-color: #222d63;
      color: white;
      padding: 20px;
      text-align: center;
      font-size: 24px;
    }
    nav {
      background-color: #ffffff;
      display: flex;
      justify-content: space-between;
      padding: 15px 40px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    nav a {
      color: #222d63;
      text-decoration: none;
      margin: 0 15px;
      font-weight: bold;
    }
    .overview {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
      padding: 30px 40px;
    }
    .card {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      padding: 20px;
      text-align: center;
    }
    .card h3 {
      color: #222d63;
      margin-bottom: 10px;
    }
    .card .value {
      font-size: 24px;
      font-weight: bold;
    }
    section {
      padding: 20px 40px;
    }
    section h2 {
      color: #2f3e9e;
      margin-bottom: 10px;
    }
    .admin-section {
      background: #fff;
      padding: 20px;
      margin-bottom: 30px;
      border-radius: 10px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .admin-links a {
      display: inline-block;
      margin: 8px 15px 8px 0;
      padding: 10px 18px;
      background: #2f3e9e;
      color: white;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 500;
      transition: background-color 0.3s;
    }
    .admin-links a:hover {
      background: #1a2b8f;
    }
  </style>
</head>

<body>

<header>
  Admin Dashboard - Campus Club & Merchandise System
</header>

<nav>
  <div>
    <a href="Logout.jsp">Logout</a>
  </div>
  <div>Welcome, <%= adminName %></div>
</nav>

<!-- Overview Summary Cards -->
<div class="overview">
    <div class="card">
      <h3>Total Events</h3>
      <div class="value"><%= stats.getTotalEvents() %></div>
    </div>
    <div class="card">
      <h3>Total Clubs</h3>
      <div class="value"><%= stats.getTotalClubs() %></div>
    </div>
    <div class="card">
      <h3>Total Users</h3>
      <div class="value"><%= stats.getTotalUsers() %></div>
    </div>
    <div class="card">
      <h3>Revenue</h3>
      <div class="value">RM <%= stats.getTotalRevenue() %></div>
    </div>
</div>

<!-- Manage Users -->
<section class="admin-section">
  <h2>User Account Management</h2>
  <div class="admin-links">
    <a href="view_users.jsp">View All Users</a>
    <a href="edit_user.jsp">Edit User</a>
  </div>
</section>

<!-- Manage Clubs & Events -->
<section class="admin-section">
  <h2>Clubs & Events Management</h2>
  <div class="admin-links">
    <a href="view_club.jsp">View Clubs</a>
    <a href="view_events.jsp">View Events</a>
    <a href="addClub.jsp">Add New Club</a>
  </div>
</section>

<!-- Merchandise Management -->
<section class="admin-section">
  <h2>Merchandise Listings</h2>
  <div class="admin-links">
    <a href="Catalog.jsp">View Merchandise</a>
    <a href="merch_orders.jsp">Merchandise Orders</a>
  </div>
</section>

</body>
</html>
