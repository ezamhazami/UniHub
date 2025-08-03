package dao;
import java.sql.*;
import model.bean.User;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean registerUser(User user) throws SQLException {
        String sql = "INSERT INTO Users (Name, Email, Password, Role) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPassword()); // (Note: hash in real apps!)
        stmt.setString(4, user.getRole());

        return stmt.executeUpdate() > 0;
    }

    public User checkLogin(String email, String password) throws SQLException {
        String sql = "SELECT * FROM USERS WHERE Email=? AND Password=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setUserID(rs.getInt("USERID"));
            user.setName(rs.getString("NAME"));
            user.setEmail(rs.getString("EMAIL"));
            user.setRole(rs.getString("ROLE"));
            return user;
        }
        return null;
}

}
