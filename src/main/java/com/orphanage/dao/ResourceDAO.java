package com.orphanage.dao;

import com.orphanage.model.Resource;
import com.orphanage.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ResourceDAO {
    // Requires a table like:
    // resource_requests(id PK AI, user_id FK, item_name, quantity, priority, status DEFAULT 'PENDING', created_at DEFAULT CURRENT_TIMESTAMP)
    public void createRequest(Resource r) throws SQLException {
        String sql = "INSERT INTO resource_requests(user_id, item_name, quantity, priority, status) VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, r.getUserId());
            ps.setString(2, r.getItemName());
            ps.setInt(3, r.getQuantity());
            ps.setString(4, r.getPriority());
            ps.setString(5, r.getStatus() == null ? "PENDING" : r.getStatus());
            ps.executeUpdate();
        }
    }
}
