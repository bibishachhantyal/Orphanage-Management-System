package dao;

import models.Volunteer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {

    public List<Volunteer> getAllVolunteers() {
        List<Volunteer> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteers";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Volunteer v = new Volunteer();
                v.setId(rs.getInt("id"));
                v.setFullName(rs.getString("full_name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setAddress(rs.getString("address"));
                v.setStatus(rs.getString("status"));
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addVolunteer(Volunteer v) {
        String sql = "INSERT INTO volunteers (full_name, email, phone, address, status) VALUES (?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, v.getFullName());
            pstmt.setString(2, v.getEmail());
            pstmt.setString(3, v.getPhone());
            pstmt.setString(4, v.getAddress());
            pstmt.setString(5, v.getStatus());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateVolunteer(Volunteer v) {
        String sql = "UPDATE volunteers SET full_name=?, email=?, phone=?, address=?, status=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, v.getFullName());
            pstmt.setString(2, v.getEmail());
            pstmt.setString(3, v.getPhone());
            pstmt.setString(4, v.getAddress());
            pstmt.setString(5, v.getStatus());
            pstmt.setInt(6, v.getId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteVolunteer(int id) {
        String sql = "DELETE FROM volunteers WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Volunteer getVolunteerById(int id) {
        String sql = "SELECT * FROM volunteers WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Volunteer v = new Volunteer();
                v.setId(rs.getInt("id"));
                v.setFullName(rs.getString("full_name"));
                v.setEmail(rs.getString("email"));
                v.setPhone(rs.getString("phone"));
                v.setAddress(rs.getString("address"));
                v.setStatus(rs.getString("status"));
                return v;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}