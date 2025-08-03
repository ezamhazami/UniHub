package dao;

import model.bean.Merchandise;
import java.sql.*;
import java.util.*;

public class MerchandiseDAO {
    private Connection conn;

    public MerchandiseDAO() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/CampusHub", "app", "app");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Merchandise> getAllMerchandise() {
        List<Merchandise> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM merchandise";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Merchandise m = new Merchandise();
                m.setMerchId(rs.getInt("merch_id"));
                m.setName(rs.getString("name"));
                m.setDescription(rs.getString("description"));
                m.setImageUrl(rs.getString("image_url"));
                m.setPrice(rs.getDouble("price"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Merchandise getMerchandiseById(int id) {
        try {
            String sql = "SELECT * FROM merchandise WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Merchandise m = new Merchandise();
                m.setMerchId(rs.getInt("merchID"));
                m.setName(rs.getString("name"));
                m.setDescription(rs.getString("description"));
                m.setImageUrl(rs.getString("image_url"));
                m.setPrice(rs.getDouble("price"));
                return m;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}