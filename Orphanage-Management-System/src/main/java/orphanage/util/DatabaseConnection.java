package orphanage.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL =
            "jdbc:mysql://localhost:3306/orphanagesystem_db"
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kathmandu";
    private static final String USER = "root";
    /** XAMPP / local MySQL: often empty. Change to your MySQL password if needed. */
    private static final String PASSWORD = "";

    private static final HikariDataSource dataSource;

    static {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(URL);
        config.setUsername(USER);
        config.setPassword(PASSWORD);
        config.setMaximumPoolSize(10);
        config.setMinimumIdle(2);
        config.setConnectionTimeout(30_000);
        config.setIdleTimeout(600_000);
        config.setMaxLifetime(1_800_000);
        config.setPoolName("OrphanagePool");
        dataSource = new HikariDataSource(config);
    }

    private DatabaseConnection() {}

    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }
}
