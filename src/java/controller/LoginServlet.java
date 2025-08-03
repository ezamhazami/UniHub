package controller;

import dao.UserDAO;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import model.bean.User;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from the login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Connect to Derby (Java DB)
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            UserDAO dao = new UserDAO(conn);
            User user = dao.checkLogin(email, password);
            
            System.out.println("Login attempt with: " + email);
            System.out.println("Login result: " + (user != null ? "Success" : "Failed"));


            if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // ✅ Redirect based on role
            String role = user.getRole();
            if ("Student".equalsIgnoreCase(role)) {
                response.sendRedirect("Dashboard.jsp");
            } else if ("ClubRep".equalsIgnoreCase(role)) {
                response.sendRedirect("club_dashboard.jsp");
            } else if ("Admin".equalsIgnoreCase(role)) {
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                // default fallback
                response.sendRedirect("Login.jsp");
            }

            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }


        } catch (SQLException e) {
            throw new ServletException("Database connection or query failed.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // optional: you can disable GET access
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // handle login POST form
    }

    @Override
    public String getServletInfo() {
        return "LoginServlet handles user authentication.";
    }
}
