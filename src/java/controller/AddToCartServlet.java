package controller;

import dao.CartDAO;
import model.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUserID();
        int merchId = Integer.parseInt(request.getParameter("merchId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        CartDAO dao = new CartDAO();
        dao.addToCart(userId, merchId, quantity);

        response.sendRedirect("ViewCart.jsp");
    }
}