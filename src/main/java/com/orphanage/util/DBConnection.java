package com.orphanage.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/orphanage_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    private DBConnection() {}

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = readEnvOrDefault("ORPHANAGE_DB_URL", DEFAULT_URL);
        String user = readEnvOrDefault("ORPHANAGE_DB_USER", DEFAULT_USER);
        String pass = readEnvOrDefault("ORPHANAGE_DB_PASSWORD", DEFAULT_PASSWORD);
        return DriverManager.getConnection(url, user, pass);
    }

    private static String readEnvOrDefault(String key, String def) {
        String v = System.getenv(key);
        return (v == null || v.isBlank()) ? def : v;
    }
}
