package orphanage.dao;

import orphanage.model.ContactMessage;
import orphanage.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {

    private ContactMessage mapRow(ResultSet rs) throws SQLException {
        ContactMessage m = new ContactMessage();
        m.setId(rs.getInt("id"));
        m.setName(rs.getString("name"));
        m.setEmail(rs.getString("email"));
        m.setSubject(rs.getString("subject"));
        m.setMessage(rs.getString("message"));
        m.setSubmittedDate(rs.getTimestamp("submitted_date"));
        m.setStatus(rs.getString("status"));
        return m;
    }

    public void insert(String name, String email, String subject, String message) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, message);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ContactMessage> findAllOrderByDateDesc() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY submitted_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void markAsRead(int id) {
        String sql = "UPDATE contact_messages SET status = 'read' WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
