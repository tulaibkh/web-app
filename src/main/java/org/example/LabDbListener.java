package org.example;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 * Creates {@code webapp_lab} and {@code lab_logs} on deploy if missing (XAMPP MySQL).
 */
@WebListener
public class LabDbListener implements ServletContextListener {

    private static final String DB_NAME = "webapp_lab";

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();
        String user = ctx.getInitParameter("mysql.user");
        String pass = ctx.getInitParameter("mysql.password");
        if (user == null) {
            return;
        }
        String password = pass == null ? "" : pass;
        String bootstrapUrl = ctx.getInitParameter("mysql.bootstrapUrl");
        if (bootstrapUrl == null || bootstrapUrl.isBlank()) {
            bootstrapUrl = "jdbc:mysql://localhost:3306/?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection c = DriverManager.getConnection(bootstrapUrl, user, password);
                 Statement st = c.createStatement()) {
                st.executeUpdate(
                        "CREATE DATABASE IF NOT EXISTS " + DB_NAME
                                + " CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
            }
            String appUrl = ctx.getInitParameter("mysql.jdbcUrl");
            if (appUrl == null || appUrl.isBlank()) {
                appUrl = "jdbc:mysql://localhost:3306/" + DB_NAME
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            }
            try (Connection c = DriverManager.getConnection(appUrl, user, password);
                 Statement st = c.createStatement()) {
                st.executeUpdate(
                        "CREATE TABLE IF NOT EXISTS lab_logs ("
                                + "id INT AUTO_INCREMENT PRIMARY KEY,"
                                + "num_value INT NOT NULL,"
                                + "square_value INT NOT NULL,"
                                + "parity VARCHAR(10) NOT NULL,"
                                + "color VARCHAR(32) NULL,"
                                + "created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP"
                                + ")");
            }
        } catch (Exception e) {
            ctx.log("LabDbListener: MySQL init failed", e);
        }
    }
}
