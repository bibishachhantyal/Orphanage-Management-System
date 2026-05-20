package orphanage.dao;

import orphanage.model.VolunteerApplication;
import orphanage.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerApplicationDAO {

    private VolunteerApplication mapRow(ResultSet rs) throws SQLException {
        VolunteerApplication a = new VolunteerApplication();
        a.setId(rs.getInt("id"));
        a.setFullName(rs.getString("full_name"));
        a.setEmail(rs.getString("email"));
        a.setPhone(rs.getString("phone"));
        a.setSkillArea(rs.getString("skill_area"));
        a.setAvailability(rs.getString("availability"));
        a.setMessage(rs.getString("message"));
        a.setSubmittedDate(rs.getTimestamp("submitted_date"));
        a.setStatus(rs.getString("status"));
        return a;
    }

    public void insert(VolunteerApplication app) {
        String sql = "INSERT INTO volunteer_applications (full_name, email, phone, skill_area, availability, message) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, app.getFullName());
            ps.setString(2, app.getEmail());
            ps.setString(3, app.getPhone());
            ps.setString(4, app.getSkillArea());
            ps.setString(5, app.getAvailability());
            ps.setString(6, app.getMessage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<VolunteerApplication> findPending() {
        List<VolunteerApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteer_applications WHERE status = 'pending' ORDER BY submitted_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public VolunteerApplication findById(int id) {
        String sql = "SELECT * FROM volunteer_applications WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE volunteer_applications SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
