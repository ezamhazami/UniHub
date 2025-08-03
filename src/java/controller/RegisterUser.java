package controller;

import dao.UserDAO;
import model.bean.User;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
            UserDAO dao = new UserDAO(conn);

            if (dao.registerUser(user)) {
                // ✅ On success, send success message to login.jsp
                request.setAttribute("success", "Account created successfully. Please login.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                // Registration failed for some reason
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("Register.jsp").forward(request, response);
            }

        } catch (SQLIntegrityConstraintViolationException e) {
            // ✅ Duplicate email error
            request.setAttribute("error", "Email already registered. Please login.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }
}
