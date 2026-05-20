package orphanage.dao;

import orphanage.model.Volunteer;
import orphanage.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {
    // Create
    public void addVolunteer(Volunteer v) {
        String sql = "INSERT INTO volunteers (full_name, email, phone, skill_area, availability, joined_date, status) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getFull_name());
            ps.setString(2, v.getEmail());
            ps.setString(3, v.getPhone());
            ps.setString(4, v.getSkill_area());
            ps.setString(5, v.getAvailability());
            ps.setString(6, v.getJoined_date());
            ps.setString(7, v.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Read all
    public List<Volunteer> getAllVolunteers() {
        List<Volunteer> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteers";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Volunteer v = new Volunteer();
                v.setId(rs.getInt("id"));
                v.setFull_name(rs.getString("full_name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setSkill_area(rs.getString("skill_area"));
                v.setAvailability(rs.getString("availability"));
                v.setJoined_date(rs.getString("joined_date"));
                v.setStatus(rs.getString("status"));
                list.add(v);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Read by ID
    public Volunteer getVolunteerById(int id) {
        String sql = "SELECT * FROM volunteers WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Volunteer v = new Volunteer();
                v.setId(rs.getInt("id"));
                v.setFull_name(rs.getString("full_name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setSkill_area(rs.getString("skill_area"));
                v.setAvailability(rs.getString("availability"));
                v.setJoined_date(rs.getString("joined_date"));
                v.setStatus(rs.getString("status"));
                return v;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Update
    public void updateVolunteer(Volunteer v) {
        String sql = "UPDATE volunteers SET full_name=?, email=?, phone=?, skill_area=?, availability=?, joined_date=?, status=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, v.getFull_name());
            ps.setString(2, v.getEmail());
            ps.setString(3, v.getPhone());
            ps.setString(4, v.getSkill_area());
            ps.setString(5, v.getAvailability());
            ps.setString(6, v.getJoined_date());
            ps.setString(7, v.getStatus());
            ps.setInt(8, v.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Delete
    public void deleteVolunteer(int id) {
        String sql = "DELETE FROM volunteers WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Count for dashboard
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM volunteers";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}