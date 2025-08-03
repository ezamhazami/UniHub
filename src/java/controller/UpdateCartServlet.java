
package controller;

import dao.CartDAO;
import model.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class UpdateCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String quantityParam = request.getParameter("quantity");
        String merchIdParam = request.getParameter("merchId");

        if (quantityParam == null || merchIdParam == null || quantityParam.isEmpty()) {
            response.sendRedirect("ViewCart.jsp?error=Missing+input");
            return;
        }

        try {
            int userId = user.getUserID();
            int merchId = Integer.parseInt(merchIdParam);
            int quantity = Integer.parseInt(quantityParam);

            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
            CartDAO dao = new CartDAO(conn);
            dao.updateCartItem(userId, merchId, quantity);  // ✅ Make sure this method exists in DAO
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        response.sendRedirect("ViewCart.jsp");
    }
}