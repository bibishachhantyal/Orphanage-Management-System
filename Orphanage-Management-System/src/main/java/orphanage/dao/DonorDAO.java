package orphanage.dao;

import orphanage.model.Donor;
import orphanage.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonorDAO {
    // Create
    public void addDonor(Donor donor) {
        String sql = "INSERT INTO donors (full_name, email, phone, address, donor_type) VALUES (?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, donor.getFull_name());
            ps.setString(2, donor.getEmail());
            ps.setString(3, donor.getPhone());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getDonor_type());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Read all
    public List<Donor> getAllDonors() {
        List<Donor> list = new ArrayList<>();
        String sql = "SELECT * FROM donors";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Donor d = new Donor();
                d.setId(rs.getInt("id"));
                d.setFull_name(rs.getString("full_name"));
                d.setEmail(rs.getString("email"));
                d.setPhone(rs.getString("phone"));
                d.setAddress(rs.getString("address"));
                d.setDonor_type(rs.getString("donor_type"));
                list.add(d);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public Donor findByEmail(String email) {
        String sql = "SELECT * FROM donors WHERE email = ? LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Donor d = new Donor();
                d.setId(rs.getInt("id"));
                d.setFull_name(rs.getString("full_name"));
                d.setEmail(rs.getString("email"));
                d.setPhone(rs.getString("phone"));
                d.setAddress(rs.getString("address"));
                d.setDonor_type(rs.getString("donor_type"));
                return d;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public int addDonorReturningId(Donor donor) {
        String sql = "INSERT INTO donors (full_name, email, phone, address, donor_type) VALUES (?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, donor.getFull_name());
            ps.setString(2, donor.getEmail());
            ps.setString(3, donor.getPhone());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getDonor_type());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    // Read by ID
    public Donor getDonorById(int id) {
        String sql = "SELECT * FROM donors WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Donor d = new Donor();
                d.setId(rs.getInt("id"));
                d.setFull_name(rs.getString("full_name"));
                d.setEmail(rs.getString("email"));
                d.setPhone(rs.getString("phone"));
                d.setAddress(rs.getString("address"));
                d.setDonor_type(rs.getString("donor_type"));
                return d;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Update
    public void updateDonor(Donor donor) {
        String sql = "UPDATE donors SET full_name=?, email=?, phone=?, address=?, donor_type=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, donor.getFull_name());
            ps.setString(2, donor.getEmail());
            ps.setString(3, donor.getPhone());
            ps.setString(4, donor.getAddress());
            ps.setString(5, donor.getDonor_type());
            ps.setInt(6, donor.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Delete
    public void deleteDonor(int id) {
        String sql = "DELETE FROM donors WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Count for dashboard
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM donors";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}