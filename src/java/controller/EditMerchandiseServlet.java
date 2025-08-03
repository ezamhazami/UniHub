package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/EditMerchandiseServlet")
public class EditMerchandiseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get parameters from form
            int merchId = Integer.parseInt(request.getParameter("merchId"));
            String productName = request.getParameter("productName");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            // Connect to Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            // Update SQL without CLUBID
            String sql = "UPDATE MERCHANDISE SET NAME = ?, DESCRIPTION = ?, IMAGE_URL = ?, PRICE = ?, STOCK = ? WHERE MERCH_ID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productName);
            ps.setString(2, description);
            ps.setString(3, imageUrl);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
            ps.setInt(6, merchId);

            int rowsUpdated = ps.executeUpdate();
            conn.close();

            if (rowsUpdated > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Successfully updated merchandise item!');");
                out.println("window.location = 'merchandise.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed to update merchandise item.');");
                out.println("window.location = 'edit_item.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: " + e.getMessage().replace("'", "") + "');");
            out.println("window.location = 'edit_item.jsp';");
            out.println("</script>");
        } finally {
            out.close();
        }
    }
}
