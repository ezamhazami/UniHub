package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            PreparedStatement ps = conn.prepareStatement("DELETE FROM Users WHERE UserID = ?");
            ps.setInt(1, userId);
            int rowsAffected = ps.executeUpdate();

            ps.close();
            conn.close();

            if (rowsAffected > 0) {
                response.sendRedirect("edit_user.jsp?success=deleted");
            } else {
                response.sendRedirect("edit_user.jsp?error=userNotFound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("edit_user.jsp?error=deleteFailed");
        }
    }
}
