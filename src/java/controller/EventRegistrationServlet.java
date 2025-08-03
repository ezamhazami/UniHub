
package controller;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class EventRegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userID = Integer.parseInt(request.getParameter("userID"));
        int eventID = Integer.parseInt(request.getParameter("eventID"));
        String status = "Pending";
        java.sql.Date regDate = new java.sql.Date(System.currentTimeMillis());

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            // Check event capacity
            String capacitySql = "SELECT Capacity FROM Events WHERE EventID = ?";
            PreparedStatement psCap = conn.prepareStatement(capacitySql);
            psCap.setInt(1, eventID);
            ResultSet rsCap = psCap.executeQuery();

            int capacity = 0;
            if (rsCap.next()) {
                capacity = rsCap.getInt("Capacity");
            }

            // Count confirmed registrations
            String regCountSql = "SELECT COUNT(*) AS regCount FROM Event_Registration WHERE EventID = ? AND Status = 'Confirmed'";
            PreparedStatement psCount = conn.prepareStatement(regCountSql);
            psCount.setInt(1, eventID);
            ResultSet rsCount = psCount.executeQuery();

            int regCount = 0;
            if (rsCount.next()) {
                regCount = rsCount.getInt("regCount");
            }

            // Determine user status
            if (regCount < capacity) {
                status = "Confirmed";
            } else {
                status = "Pending";
            }

            // Insert registration
            String insertSql = "INSERT INTO Event_Registration (UserID, EventID, Status, Reg_date) VALUES (?, ?, ?, ?)";
            PreparedStatement psInsert = conn.prepareStatement(insertSql);
            psInsert.setInt(1, userID);
            psInsert.setInt(2, eventID);
            psInsert.setString(3, status);
            psInsert.setDate(4, regDate);

            int result = psInsert.executeUpdate();

            // ✅ Simplified redirect
            response.sendRedirect("userJoinedEvents.jsp");

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("userJoinedEvents.jsp");
        }
    }
}
