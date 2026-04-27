package com.orphanage.dao;

import com.orphanage.model.Donor;
import com.orphanage.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * DonorDAO — data access object for the donors table.
 * Provides full CRUD operations.
 */
public class DonorDAO {

    // ------------------------------------------------------------------ //
    // CREATE
    // ------------------------------------------------------------------ //
    public int create(Donor donor) throws SQLException {
        String sql = "INSERT INTO donors (full_name, email, phone, address, donation_type, total_donated, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            LocalDateTime now = LocalDateTime.now();
            ps.setString(1, donor.getFullName());
            ps.setString(2, donor.getEmail());
            ps.setString(3, donor.getPhone());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getDonationType());
            ps.setBigDecimal(6, donor.getTotalDonated() != null ? donor.getTotalDonated() : BigDecimal.ZERO);
            ps.setTimestamp(7, Timestamp.valueOf(now));
            ps.setTimestamp(8, Timestamp.valueOf(now));

            int affected = ps.executeUpdate();
            if (affected == 0) throw new SQLException("Insert failed, no rows affected.");

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    // ------------------------------------------------------------------ //
    // READ — all
    // ------------------------------------------------------------------ //
    public List<Donor> findAll() throws SQLException {
        String sql = "SELECT id, full_name, email, phone, address, donation_type, total_donated, created_at, updated_at " +
                     "FROM donors ORDER BY created_at DESC";
        List<Donor> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    // ------------------------------------------------------------------ //
    // READ — by ID
    // ------------------------------------------------------------------ //
    public Donor findById(int id) throws SQLException {
        String sql = "SELECT id, full_name, email, phone, address, donation_type, total_donated, created_at, updated_at " +
                     "FROM donors WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    // ------------------------------------------------------------------ //
    // UPDATE
    // ------------------------------------------------------------------ //
    public boolean update(Donor donor) throws SQLException {
        String sql = "UPDATE donors SET full_name = ?, email = ?, phone = ?, address = ?, " +
                     "donation_type = ?, total_donated = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, donor.getFullName());
            ps.setString(2, donor.getEmail());
            ps.setString(3, donor.getPhone());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getDonationType());
            ps.setBigDecimal(6, donor.getTotalDonated() != null ? donor.getTotalDonated() : BigDecimal.ZERO);
            ps.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(8, donor.getId());

            return ps.executeUpdate() > 0;
        }
    }

    // ------------------------------------------------------------------ //
    // DELETE
    // ------------------------------------------------------------------ //
    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM donors WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ------------------------------------------------------------------ //
    // Email uniqueness check (excluding a specific donor ID for updates)
    // ------------------------------------------------------------------ //
    public boolean emailExists(String email, int excludeId) throws SQLException {
        String sql = "SELECT 1 FROM donors WHERE email = ? AND id != ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ------------------------------------------------------------------ //
    // Row mapper
    // ------------------------------------------------------------------ //
    private Donor mapRow(ResultSet rs) throws SQLException {
        Donor d = new Donor();
        d.setId(rs.getInt("id"));
        d.setFullName(rs.getString("full_name"));
        d.setEmail(rs.getString("email"));
        d.setPhone(rs.getString("phone"));
        d.setAddress(rs.getString("address"));
        d.setDonationType(rs.getString("donation_type"));
        d.setTotalDonated(rs.getBigDecimal("total_donated"));

        Timestamp createdTs = rs.getTimestamp("created_at");
        if (createdTs != null) d.setCreatedAt(createdTs.toLocalDateTime());

        Timestamp updatedTs = rs.getTimestamp("updated_at");
        if (updatedTs != null) d.setUpdatedAt(updatedTs.toLocalDateTime());

        return d;
    }
}
