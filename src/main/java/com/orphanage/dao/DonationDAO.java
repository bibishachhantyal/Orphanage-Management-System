package com.orphanage.dao;

import com.orphanage.model.Donation;
import com.orphanage.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DonationDAO {
    // Requires a table like:
    // donations(id PK AI, user_id FK, amount, method, note, created_at DEFAULT CURRENT_TIMESTAMP)
    public void create(Donation d) throws SQLException {
        String sql = "INSERT INTO donations(user_id, amount, method, note) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, d.getUserId());
            ps.setDouble(2, d.getAmount());
            ps.setString(3, d.getMethod());
            ps.setString(4, d.getNote());
            ps.executeUpdate();
        }
    }
}
