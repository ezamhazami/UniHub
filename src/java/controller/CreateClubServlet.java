package controller;

import dao.ClubDAO;
import model.bean.Club;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.*;
import javax.servlet.http.*;

public class CreateClubServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clubName = request.getParameter("club_name");
        String description = request.getParameter("description");

        HttpSession session = request.getSession();
        model.bean.User currentUser = (model.bean.User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int userID = currentUser.getUserID();

        Club club = new Club();
        club.setClubName(clubName);
        club.setDescription(description);
        club.setUserID(userID);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "root", "");

            ClubDAO clubDAO = new ClubDAO(conn);
            boolean success = clubDAO.createClub(club);

            if (success) {
                response.sendRedirect("admin_dashboard.jsp?message=Club created successfully");
            } else {
                response.sendRedirect("create_club.jsp?error=Unable to create club");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("create_club.jsp?error=Exception occurred");
        }
    }
}
