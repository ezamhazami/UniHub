package controller;

import model.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "SELECT * FROM Users WHERE email=? AND Password=? AND Role='admin'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Create user object and store in session
                User admin = new User();
                admin.setUserID(rs.getInt("UserID"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("Role"));
                admin.setName(rs.getString("name"));
                request.getSession().setAttribute("user", admin);

                response.sendRedirect("AdminDashboardServlet");

            } else {
                request.setAttribute("error", "Invalid credentials or not an admin.");
                request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorTitle", "Oops! Something went wrong");
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.<br><small>Details: " + e.getMessage() + "</small>");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
        }

    }
}
