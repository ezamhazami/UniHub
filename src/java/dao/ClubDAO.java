package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.bean.Club;

public class ClubDAO {
    private Connection conn;

    public ClubDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createClub(Club club) throws SQLException {
    String sql = "INSERT INTO Clubs (club_name, description, userid) VALUES (?, ?, ?)";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, club.getClubName());
    stmt.setString(2, club.getDescription());
    stmt.setInt(3, club.getUserID());

    return stmt.executeUpdate() > 0;
    }
}