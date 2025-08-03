package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/DeleteMerchandiseServlet")
public class DeleteMerchandiseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int merchId = Integer.parseInt(request.getParameter("merchId")); // ✅ renamed to match form input

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "DELETE FROM MERCHANDISE WHERE MERCH_ID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, merchId);

            int result = ps.executeUpdate();
            conn.close();

            if (result > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('✅ Merchandise deleted successfully');");
                out.println("window.location = 'club_dashboard.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('❌ Failed to delete merchandise');");
                out.println("window.location = 'delete_item.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: " + e.getMessage().replace("'", "") + "');");
            out.println("window.location = 'delete_item.jsp';");
            out.println("</script>");
        } finally {
            out.close();
        }
    }
}
