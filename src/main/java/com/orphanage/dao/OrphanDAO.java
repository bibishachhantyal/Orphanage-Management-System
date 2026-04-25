package com.orphanage.dao;

import com.orphanage.model.Orphan;
import com.orphanage.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrphanDAO {
    public List<Orphan> getAllOrphans() {
        List<Orphan> list = new ArrayList<>();
        String sql = "SELECT * FROM orphans";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Orphan(rs.getInt("id"), rs.getString("name"), rs.getInt("age")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Orphan getOrphanById(int id) {
        String sql = "SELECT * FROM orphans WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Orphan(rs.getInt("id"), rs.getString("name"), rs.getInt("age"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addOrphan(Orphan orphan) {
        String sql = "INSERT INTO orphans (name, age) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orphan.getName());
            ps.setInt(2, orphan.getAge());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrphan(Orphan orphan) {
        String sql = "UPDATE orphans SET name = ?, age = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orphan.getName());
            ps.setInt(2, orphan.getAge());
            ps.setInt(3, orphan.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteOrphan(int id) {
        String sql = "DELETE FROM orphans WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}