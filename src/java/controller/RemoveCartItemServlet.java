package controller;

import dao.CartDAO;
import model.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class RemoveCartItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUserID();
        int merchId = Integer.parseInt(request.getParameter("merchId"));

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
            CartDAO dao = new CartDAO(conn);
            dao.removeCartItem(userId, merchId);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }

        response.sendRedirect("ViewCart.jsp");
    }
}