package com.orphanage.dao;

import com.orphanage.model.User;
import com.orphanage.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;

public class UserDAOImpl implements UserDAO {

    @Override
    public int registerUser(User user) throws SQLException {
        if (emailExists(user.getEmail())) {
            throw new SQLException("Email already exists: " + user.getEmail());
        }

        String sql = "INSERT INTO users (full_name, email, phone, role, password_hash, password_salt, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getPasswordHash());
            stmt.setString(6, user.getPasswordSalt());
            stmt.setTimestamp(7, Timestamp.valueOf(LocalDateTime.now()));

            int affected = stmt.executeUpdate();
            if (affected == 0) throw new SQLException("Insert failed, no rows affected.");

            try (ResultSet keys = stmt.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public User loginUser(String email, String rawHash) throws SQLException {
        String sql = "SELECT id, full_name, email, phone, role, created_at FROM users WHERE email = ? AND password_hash = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, rawHash);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRowSafe(rs);
            }
        }
        return null;
    }

    @Override
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT id, full_name, email, phone, role, created_at FROM users WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRowSafe(rs);
            }
        }
        return null;
    }

    @Override
    public User findByEmailWithAuth(String email) throws SQLException {
        String sql = "SELECT id, full_name, email, phone, role, password_hash, password_salt, created_at FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRowFull(rs);
            }
        }
        return null;
    }

    @Override
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Helpers
    private User mapRowSafe(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) u.setCreatedAt(ts.toLocalDateTime());
        return u;
    }

    private User mapRowFull(ResultSet rs) throws SQLException {
        User u = mapRowSafe(rs);
        u.setPasswordHash(rs.getString("password_hash"));
        u.setPasswordSalt(rs.getString("password_salt"));
        return u;
    }
}
