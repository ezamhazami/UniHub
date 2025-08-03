package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class EditUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "UPDATE Users SET Name=?, Email=?, Role=? WHERE UserID=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, role);
            ps.setInt(4, userId);

            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("edit_user.jsp?success=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_user.jsp?error=updateFailed");
        }
    }
}
