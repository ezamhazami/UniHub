package controller;

import dao.CartDAO;
import model.bean.CartItem;
import model.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ViewCartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        CartDAO dao = new CartDAO();
        List<CartItem> cartItems = dao.getCartItems(user.getUserID());

        request.setAttribute("cartItems", cartItems);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewCart.jsp");
        dispatcher.forward(request, response);
    }
}