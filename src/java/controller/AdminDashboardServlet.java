 package controller;

import model.bean.AdminStats;
import model.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect("Login.jsp");
            return;
        }
          AdminStats stats = new AdminStats();
        
        try {
            // Update with your DB info
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");



            Statement stmt = conn.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM events");
            if (rs.next()) stats.setTotalEvents(rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM clubs");
            if (rs.next()) stats.setTotalClubs(rs.getInt(1));

            rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
            if (rs.next()) stats.setTotalUsers(rs.getInt(1));

            rs = stmt.executeQuery("SELECT SUM(total_amount) FROM orders");
            if (rs.next()) stats.setTotalRevenue(rs.getDouble(1));

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("stats", stats);
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}
