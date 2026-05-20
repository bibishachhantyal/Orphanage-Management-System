package orphanage.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL =
            "jdbc:mysql://localhost:3306/orphanagesystem_db"
                    + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kathmandu";
    private static final String USER = "root";
    /** XAMPP / local MySQL: often empty. Change to your MySQL password if needed. */
    private static final String PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
