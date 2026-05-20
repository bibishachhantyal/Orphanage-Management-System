package orphanage.dao;

import orphanage.model.Orphan;
import orphanage.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrphanDAO {

    private Orphan mapRow(ResultSet rs) throws SQLException {
        Orphan o = new Orphan();
        o.setOrphan_id(rs.getInt("orphan_id"));
        o.setFirst_name(rs.getString("first_name"));
        o.setLast_name(rs.getString("last_name"));
        o.setDate_of_birth(rs.getString("date_of_birth"));
        o.setGender(rs.getString("gender"));
        o.setHealth_status(rs.getString("health_status"));
        o.setEducation_level(rs.getString("education_level"));
        o.setEnrollment_date(rs.getString("enrollment_date"));
        o.setStatus(rs.getString("status"));
        o.setNotes(rs.getString("notes"));
        o.setPhoto_path(rs.getString("photo_path"));
        o.setBirth_certificate_ref(rs.getString("birth_certificate_ref"));
        o.setBlood_group(rs.getString("blood_group"));
        o.setGuardian_name(rs.getString("guardian_name"));
        o.setGuardian_phone(rs.getString("guardian_phone"));
        return o;
    }

    public List<Orphan> getAllOrphans() {
        List<Orphan> list = new ArrayList<>();
        String sql = "SELECT * FROM orphans ORDER BY last_name, first_name";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Orphan> getOrphansByStatus(String statusFilter) {
        List<Orphan> list = new ArrayList<>();
        if (statusFilter == null || statusFilter.isBlank() || "all".equalsIgnoreCase(statusFilter)) {
            return getAllOrphans();
        }
        String sql = "SELECT * FROM orphans WHERE TRIM(LOWER(status)) = ? ORDER BY last_name, first_name";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, statusFilter.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /** Children shown on public “meet the children” pages — active only */
    public List<Orphan> getActiveOrphansForPublic() {
        List<Orphan> list = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM orphans WHERE TRIM(LOWER(status)) = 'active' ORDER BY first_name")) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Orphan getOrphanById(int id) {
        String sql = "SELECT * FROM orphans WHERE orphan_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addOrphan(Orphan o) {
        String sql = "INSERT INTO orphans (first_name, last_name, date_of_birth, gender, health_status, education_level, enrollment_date, status, notes, photo_path, birth_certificate_ref, blood_group, guardian_name, guardian_phone) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindOrphan(ps, o, false);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrphan(Orphan o) {
        String sql = "UPDATE orphans SET first_name=?, last_name=?, date_of_birth=?, gender=?, health_status=?, education_level=?, enrollment_date=?, status=?, notes=?, photo_path=?, birth_certificate_ref=?, blood_group=?, guardian_name=?, guardian_phone=? WHERE orphan_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            bindOrphan(ps, o, true);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void bindOrphan(PreparedStatement ps, Orphan o, boolean includeId) throws SQLException {
        int i = 1;
        ps.setString(i++, nullToEmpty(o.getFirst_name()));
        ps.setString(i++, nullToEmpty(o.getLast_name()));
        ps.setString(i++, o.getDate_of_birth());
        ps.setString(i++, o.getGender());
        ps.setString(i++, nullToEmpty(o.getHealth_status()));
        ps.setString(i++, nullToEmpty(o.getEducation_level()));
        if (o.getEnrollment_date() == null || o.getEnrollment_date().isBlank()) {
            ps.setNull(i++, Types.DATE);
        } else {
            ps.setString(i++, o.getEnrollment_date());
        }
        ps.setString(i++, o.getStatus());
        ps.setString(i++, o.getNotes());
        String photo = o.getPhoto_path();
        if (photo == null || photo.isBlank()) {
            ps.setString(i++, "images/orphans/placeholder.svg");
        } else {
            ps.setString(i++, photo.trim());
        }
        ps.setString(i++, emptyToNull(o.getBirth_certificate_ref()));
        ps.setString(i++, emptyToNull(o.getBlood_group()));
        ps.setString(i++, emptyToNull(o.getGuardian_name()));
        ps.setString(i++, emptyToNull(o.getGuardian_phone()));
        if (includeId) {
            ps.setInt(i, o.getOrphan_id());
        }
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    private static String emptyToNull(String s) {
        if (s == null || s.isBlank()) {
            return null;
        }
        return s.trim();
    }

    public void deleteOrphan(int id) {
        String sql = "DELETE FROM orphans WHERE orphan_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM orphans";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getActiveCount() {
        String sql = "SELECT COUNT(*) FROM orphans WHERE LOWER(status) = 'active'";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** Search active children by name, guardian, or blood group (logged-in user dashboard). */
    public List<Orphan> searchActiveOrphans(String query) {
        List<Orphan> list = new ArrayList<>();
        if (query == null || query.isBlank()) {
            return getActiveOrphansForPublic();
        }
        String pattern = "%" + query.trim().toLowerCase() + "%";
        String sql = """
                SELECT * FROM orphans
                WHERE LOWER(status) = 'active' AND (
                    LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?
                    OR LOWER(CONCAT(first_name, ' ', last_name)) LIKE ?
                    OR LOWER(COALESCE(guardian_name, '')) LIKE ?
                    OR LOWER(COALESCE(blood_group, '')) LIKE ?
                )
                ORDER BY first_name
                """;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 1; i <= 5; i++) {
                ps.setString(i, pattern);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Orphan> getOrphansByIds(List<Integer> ids) {
        List<Orphan> list = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return list;
        }
        StringBuilder placeholders = new StringBuilder();
        for (int i = 0; i < ids.size(); i++) {
            if (i > 0) {
                placeholders.append(',');
            }
            placeholders.append('?');
        }
        String sql = "SELECT * FROM orphans WHERE orphan_id IN (" + placeholders + ") ORDER BY first_name";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
