package orphanage.dao;

import orphanage.model.TimeSlotStats;
import orphanage.util.DatabaseConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Activity counts grouped by time of day (morning 06–11, afternoon 12–17, evening 18–23).
 */
public class AdminStatsDAO {

    private static final String SLOT_CASE = """
            CASE
                WHEN HOUR(ts) BETWEEN 6 AND 11 THEN 'morning'
                WHEN HOUR(ts) BETWEEN 12 AND 17 THEN 'afternoon'
                ELSE 'evening'
            END
            """;

    public TimeSlotStats getVisitorStats() {
        return countBySlot("""
                SELECT submitted_date AS ts FROM contact_messages
                UNION ALL
                SELECT submitted_date FROM volunteer_applications
                """);
    }

    public TimeSlotStats getDonorActivityStats() {
        return countBySlot("SELECT donation_date AS ts FROM donations");
    }

    public TimeSlotStats getVolunteerStats() {
        return countBySlot("SELECT submitted_date AS ts FROM volunteer_applications");
    }

    public TimeSlotStats getRegistrationStats() {
        return countBySlot("SELECT created_at AS ts FROM users WHERE role = 'USER'");
    }

    private TimeSlotStats countBySlot(String subquery) {
        int morning = 0, afternoon = 0, evening = 0;
        String sql = "SELECT " + SLOT_CASE + " AS slot, COUNT(*) AS cnt FROM (" + subquery + ") AS activity GROUP BY slot";
        try (Connection conn = DatabaseConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                String slot = rs.getString("slot");
                int cnt = rs.getInt("cnt");
                switch (slot) {
                    case "morning" -> morning = cnt;
                    case "afternoon" -> afternoon = cnt;
                    default -> evening = cnt;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new TimeSlotStats(morning, afternoon, evening);
    }
}
