package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;


@MultipartConfig
public class AddEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String date = request.getParameter("date");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        int clubID = Integer.parseInt(request.getParameter("clubID"));

        Part imagePart = request.getPart("image");
        String fileName = getSubmittedFileName(imagePart);

        // Generate unique filename to prevent collisions
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

        // Save to permanent NetBeans web folder
        String imageFolderPath = "C:/Users/ASUS/Documents/NetBeansProjects/CampusHub/web/image";// laptop ezam
        File imageFolder = new File(imageFolderPath);
        if (!imageFolder.exists()) {
            imageFolder.mkdirs();
        }

        File fileToSave = new File(imageFolder, uniqueFileName);
        try (InputStream input = imagePart.getInputStream()) {
            Files.copy(input, fileToSave.toPath());
        }

        // Save relative image path in DB
        String imagePath = "image/" + uniqueFileName;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "INSERT INTO Events (Title, Description, Date, Capacity, ClubID, Image_Path) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, date);
            ps.setInt(4, capacity);
            ps.setInt(5, clubID);
            ps.setString(6, imagePath); // Store as "image/xyz.jpg"

            ps.executeUpdate();
            conn.close();

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script type='text/javascript'>");
            response.getWriter().println("alert('✅ Event added successfully!');");
            response.getWriter().println("window.location = 'club_dashboard.jsp';");
            response.getWriter().println("</script>");
            
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error adding event: " + e.getMessage());
        }
    }

    // Helper method to extract file name
    private String getSubmittedFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String content : header.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}