package orphanage.dao;

import orphanage.model.Donation;
import orphanage.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationDAO {
    // Create
    public void addDonation(Donation d) {
        String sql = "INSERT INTO donations (donor_id, orphan_id, amount, donation_date, payment_method, purpose) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, d.getDonor_id());
            if (d.getOrphan_id() == 0) {
                ps.setNull(2, Types.INTEGER);
            } else {
                ps.setInt(2, d.getOrphan_id());
            }
            ps.setDouble(3, d.getAmount());
            ps.setString(4, d.getDonation_date());
            ps.setString(5, d.getPayment_method());
            ps.setString(6, d.getPurpose());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Read all
    public List<Donation> getAllDonations() {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT * FROM donations";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Donation d = new Donation();
                d.setId(rs.getInt("id"));
                d.setDonor_id(rs.getInt("donor_id"));
                d.setOrphan_id(rs.getInt("orphan_id"));
                d.setAmount(rs.getDouble("amount"));
                d.setDonation_date(rs.getString("donation_date"));
                d.setPayment_method(rs.getString("payment_method"));
                d.setPurpose(rs.getString("purpose"));
                list.add(d);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Read by ID
    public Donation getDonationById(int id) {
        String sql = "SELECT * FROM donations WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Donation d = new Donation();
                d.setId(rs.getInt("id"));
                d.setDonor_id(rs.getInt("donor_id"));
                d.setOrphan_id(rs.getInt("orphan_id"));
                d.setAmount(rs.getDouble("amount"));
                d.setDonation_date(rs.getString("donation_date"));
                d.setPayment_method(rs.getString("payment_method"));
                d.setPurpose(rs.getString("purpose"));
                return d;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // Update
    public void updateDonation(Donation d) {
        String sql = "UPDATE donations SET donor_id=?, orphan_id=?, amount=?, donation_date=?, payment_method=?, purpose=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, d.getDonor_id());
            if (d.getOrphan_id() == 0) {
                ps.setNull(2, Types.INTEGER);
            } else {
                ps.setInt(2, d.getOrphan_id());
            }
            ps.setDouble(3, d.getAmount());
            ps.setString(4, d.getDonation_date());
            ps.setString(5, d.getPayment_method());
            ps.setString(6, d.getPurpose());
            ps.setInt(7, d.getId());
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Delete
    public void deleteDonation(int id) {
        String sql = "DELETE FROM donations WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Count for dashboard (number of donations)
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM donations";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // Total amount for dashboard (optional)
    public double getTotalAmount() {
        String sql = "SELECT SUM(amount) FROM donations";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0.0;
    }
}