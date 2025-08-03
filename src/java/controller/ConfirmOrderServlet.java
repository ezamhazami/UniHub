package controller;

import dao.OrderDAO;
import model.bean.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userId = user.getUserID();

        try (Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app")) {

            OrderDAO dao = new OrderDAO(conn);

            // ✅ Auto-detect Buy Now vs Cart Checkout
            String merchIdStr = request.getParameter("merchId");
            String quantityStr = request.getParameter("quantity");
            String priceStr = request.getParameter("price");

            if (merchIdStr != null && quantityStr != null && priceStr != null) {
                // 🔹 Buy Now flow
                int merchId = Integer.parseInt(merchIdStr);
                int quantity = Integer.parseInt(quantityStr);
                double price = Double.parseDouble(priceStr);
                double subtotal = quantity * price;

                dao.placeOrder(userId, merchId, quantity, subtotal);
                System.out.println("✅ BuyNow placed: merchId=" + merchId + ", qty=" + quantity);

            } else {
                // 🔹 Cart checkout flow
                dao.checkoutFromCart(userId);
                System.out.println("Cart checkout complete for user: " + userId);
            }

            response.sendRedirect("order_success.jsp");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format.");
            request.getRequestDispatcher("Catalog.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Order processing failed: " + e.getMessage(), e);
        }
    }
}