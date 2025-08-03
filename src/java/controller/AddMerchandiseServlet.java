package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddMerchandiseServlet")
@MultipartConfig
public class AddMerchandiseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String name = request.getParameter("productName");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock"));
            

            // Handle image upload
            Part imagePart = request.getPart("image");
            String fileName = getSubmittedFileName(imagePart);
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

            // Define your image folder path (modify to match your system)
            String imageFolderPath = "C:/Users/ASUS/Documents/NetBeansProjects/CampusHub/web/image";
            File imageFolder = new File(imageFolderPath);
            if (!imageFolder.exists()) imageFolder.mkdirs();

            File fileToSave = new File(imageFolder, uniqueFileName);
            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, fileToSave.toPath());
            }

            String imageUrl = "image/" + uniqueFileName;

            // Insert into database
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/CampusHub", "app", "app");

            String sql = "INSERT INTO MERCHANDISE (NAME, DESCRIPTION, IMAGE_URL, PRICE, STOCK) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, imageUrl);
            ps.setDouble(4, price);
            ps.setInt(5, stock);
          

            int result = ps.executeUpdate();
            conn.close();

            if (result > 0) {
                out.println("<script type='text/javascript'>");
                out.println("alert('✅ Merchandise added successfully!');");
                out.println("window.location = 'club_dashboard.jsp';");
                out.println("</script>");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('❌ Failed to add merchandise.');");
                out.println("window.location = 'add_item.jsp';");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error: " + e.getMessage().replace("'", "") + "');");
            out.println("window.location = 'add_item.jsp';");
            out.println("</script>");
        } finally {
            out.close();
        }
    }

    // Helper to extract the file name
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
