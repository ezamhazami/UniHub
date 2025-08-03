package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author syami
 */
@WebServlet(urlPatterns = {"/DeleteEventServlet"})
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
public class DeleteEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("eventId"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String deleteSql = "DELETE FROM Events WHERE EventID = ?";
            PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
            deleteStmt.setInt(1, eventId);

            int deleted = deleteStmt.executeUpdate();

            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            if (deleted > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('Successfully deleted event');");
                out.println("window.location = 'club_dashboard.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Failed to delete event');");
                out.println("window.location = 'deleteEvent.jsp';");
                out.println("</script>");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("deleteEvent.jsp");
        }
    }
}

