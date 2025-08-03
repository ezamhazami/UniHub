package controller;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/AddClubServlet")
public class AddClubServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clubName = request.getParameter("clubName");
        String description = request.getParameter("description");
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "INSERT INTO CLUBS (CLUB_NAME, DESCRIPTION, USERID) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, clubName);
            ps.setString(2, description);
            ps.setInt(3, userId);

            ps.executeUpdate();
            ps.close();
            conn.close();

            response.sendRedirect("admin_dashboard.jsp?success=clubAdded");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_club.jsp?error=insertFailed");
        }
    }
}
