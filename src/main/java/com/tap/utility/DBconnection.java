package com.tap.utility;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {

    private static String getEnv(String... keys) {
        for (String key : keys) {
            String val = System.getenv(key);
            if (val != null && !val.trim().isEmpty()) {
                return val.trim();
            }
        }
        return null;
    }

    public static String getUrl() {
        String rawUrl = getEnv("MYSQL_URL", "MYSQLURL", "DATABASE_URL", "DB_URL");
        if (rawUrl != null) {
            try {
                if (rawUrl.startsWith("jdbc:mysql://")) {
                    return rawUrl;
                }
                if (rawUrl.startsWith("mysql://")) {
                    URI uri = new URI(rawUrl);
                    String host = uri.getHost();
                    int port = uri.getPort() > 0 ? uri.getPort() : 3306;
                    String path = uri.getPath();
                    if (path != null && path.startsWith("/")) path = path.substring(1);
                    if (path == null || path.isEmpty()) path = "railway";
                    return "jdbc:mysql://" + host + ":" + port + "/" + path + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                }
            } catch (Exception e) {
                System.err.println("Error parsing MYSQL_URL: " + e.getMessage());
            }
        }

        String host = getEnv("MYSQLHOST", "DB_HOST", "MYSQL_HOST");
        String port = getEnv("MYSQLPORT", "DB_PORT", "MYSQL_PORT");
        String db = getEnv("MYSQLDATABASE", "MYSQL_DATABASE", "DB_NAME", "MYSQL_DB");

        if (host != null) {
            if (port == null) port = "3306";
            if (db == null || db.isEmpty()) db = "railway";
            return "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }

        // Fallback for local development
        return "jdbc:mysql://localhost:3306/dao?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    public static String getUser() {
        String rawUrl = getEnv("MYSQL_URL", "MYSQLURL", "DATABASE_URL", "DB_URL");
        if (rawUrl != null && rawUrl.startsWith("mysql://")) {
            try {
                URI uri = new URI(rawUrl);
                if (uri.getUserInfo() != null && uri.getUserInfo().contains(":")) {
                    return uri.getUserInfo().split(":")[0];
                }
            } catch (Exception e) {}
        }
        String user = getEnv("MYSQLUSER", "DB_USER", "MYSQL_USER");
        return user != null ? user : "root";
    }

    public static String getPassword() {
        String rawUrl = getEnv("MYSQL_URL", "MYSQLURL", "DATABASE_URL", "DB_URL");
        if (rawUrl != null && rawUrl.startsWith("mysql://")) {
            try {
                URI uri = new URI(rawUrl);
                if (uri.getUserInfo() != null && uri.getUserInfo().contains(":")) {
                    String[] parts = uri.getUserInfo().split(":");
                    if (parts.length > 1) return parts[1];
                }
            } catch (Exception e) {}
        }
        String pass = getEnv("MYSQLPASSWORD", "DB_PASSWORD", "MYSQL_PASSWORD");
        return pass != null ? pass : "Lucifer.t.j7";
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = getUrl();
            String user = getUser();
            String password = getPassword();

            System.out.println("Connecting to MySQL Database URL: " + url + " | User: " + user);
            connection = DriverManager.getConnection(url, user, password);
            System.out.println("DATABASE CONNECTED SUCCESSFULLY!");
        } catch (ClassNotFoundException e) {
            System.err.println("Driver Class Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
        return connection;
    }
}