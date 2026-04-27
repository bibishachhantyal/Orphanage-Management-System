package com.orphanage.controller;

import com.orphanage.dao.DonorDAO;
import com.orphanage.model.User;
import com.orphanage.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * DashboardServlet — loads summary statistics and forwards to dashboard JSP.
 *
 * GET /user/dashboard → load stats, forward to /user/dashboard.jsp
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/user/dashboard"})
public class DashboardServlet extends HttpServlet {

    private DonorDAO donorDAO;

    @Override
    public void init() throws ServletException {
        donorDAO = new DonorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get logged-in user from session
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            // ---- Stats ---- //
            req.setAttribute("totalDonors", getCount("SELECT COUNT(*) FROM donors"));
            req.setAttribute("totalUsers", getCount("SELECT COUNT(*) FROM users"));
            req.setAttribute("totalDonations", getCount("SELECT COUNT(*) FROM donations"));
            req.setAttribute("totalResources", getCount("SELECT COUNT(*) FROM resource_requests"));

            req.setAttribute("totalDonatedAmount", getSum("SELECT COALESCE(SUM(total_donated), 0) FROM donors"));

            // My donations (current user)
            req.setAttribute("myDonationCount", getCountWhere(
                    "SELECT COUNT(*) FROM donations WHERE user_id = ?", user.getId()));
            req.setAttribute("myDonationTotal", getSumWhere(
                    "SELECT COALESCE(SUM(amount), 0) FROM donations WHERE user_id = ?", user.getId()));

            // Recent donations (all)
            req.setAttribute("recentDonations", getRecentDonations());

            // Top donors
            req.setAttribute("topDonors", getTopDonors());

            // Donation breakdown by type
            req.setAttribute("donationBreakdown", getDonationBreakdown());

            req.getRequestDispatcher("/user/dashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Database error loading dashboard", e);
        }
    }

    // ------------------------------------------------------------------ //
    // Helper queries
    // ------------------------------------------------------------------ //
    private int getCount(String sql) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private int getCountWhere(String sql, int param) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return 0;
    }

    private BigDecimal getSum(String sql) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        }
        return BigDecimal.ZERO;
    }

    private BigDecimal getSumWhere(String sql, int param) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, param);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal(1);
            }
        }
        return BigDecimal.ZERO;
    }

    private List<Map<String, Object>> getRecentDonations() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT d.amount, d.method, d.note, d.created_at, u.full_name " +
                "FROM donations d JOIN users u ON d.user_id = u.id " +
                "ORDER BY d.created_at DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("donorName", rs.getString("full_name"));
                row.put("amount", rs.getBigDecimal("amount"));
                row.put("method", rs.getString("method"));
                row.put("note", rs.getString("note"));
                row.put("date", rs.getTimestamp("created_at"));
                list.add(row);
            }
        }
        return list;
    }

    private List<Map<String, Object>> getTopDonors() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT full_name, email, donation_type, total_donated " +
                "FROM donors ORDER BY total_donated DESC LIMIT 5";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("name", rs.getString("full_name"));
                row.put("email", rs.getString("email"));
                row.put("type", rs.getString("donation_type"));
                row.put("totalDonated", rs.getBigDecimal("total_donated"));
                list.add(row);
            }
        }
        return list;
    }

    private List<Map<String, Object>> getDonationBreakdown() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT donation_type, COUNT(*) as count, SUM(total_donated) as total " +
                "FROM donors GROUP BY donation_type ORDER BY total DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("type", rs.getString("donation_type"));
                row.put("count", rs.getInt("count"));
                row.put("total", rs.getBigDecimal("total"));
                list.add(row);
            }
        }
        return list;
    }
}

