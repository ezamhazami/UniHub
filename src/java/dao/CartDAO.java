package dao;

import model.bean.CartItem;
import java.sql.*;
import java.util.*;

public class CartDAO {
    private Connection conn;

    
    public CartDAO() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public CartDAO(Connection conn) {
        this.conn = conn;
    }

    public void addToCart(int userId, int merchId, int quantity) {
        try {
            String check = "SELECT * FROM cart WHERE userid = ? AND merch_id = ?";
            PreparedStatement ps = conn.prepareStatement(check);
            ps.setInt(1, userId);
            ps.setInt(2, merchId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String update = "UPDATE cart SET quantity = quantity + ? WHERE userid = ? AND merch_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(update);
                updateStmt.setInt(1, quantity);
                updateStmt.setInt(2, userId);
                updateStmt.setInt(3, merchId);
                updateStmt.executeUpdate();
            } else {
                String insert = "INSERT INTO cart (userid, merch_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insert);
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, merchId);
                insertStmt.setInt(3, quantity);
                insertStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CartItem> getCartItems(int userId) {
        List<CartItem> list = new ArrayList<>();
        try {
            String sql = "SELECT c.merch_id, m.name, m.price, m.image_url, c.quantity " +
                         "FROM cart c JOIN merchandise m ON c.merch_id = m.merch_id WHERE c.userid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setMerchId(rs.getInt("merch_id"));
                item.setMerchName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setImageUrl(rs.getString("image_url"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

       public void removeCartItem(int userId, int merchId) {
        try {
            String sql = "DELETE FROM cart WHERE userid = ? AND merch_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, merchId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCart(int userId) {
        try {
            String sql = "DELETE FROM cart WHERE userid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCartItem(int userId, int merchId, int quantity) {
        try {
            String sql = "UPDATE cart SET quantity = ? WHERE userid = ? AND merch_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, merchId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}