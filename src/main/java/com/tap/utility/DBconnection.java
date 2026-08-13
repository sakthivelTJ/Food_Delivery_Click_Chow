package com.tap.utility;

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
        String fullUrl = getEnv("MYSQL_URL", "MYSQLURL", "DATABASE_URL", "DB_URL");
        if (fullUrl != null) {
            if (!fullUrl.startsWith("jdbc:mysql://")) {
                fullUrl = "jdbc:" + fullUrl;
            }
            if (!fullUrl.contains("useSSL")) {
                fullUrl += (fullUrl.contains("?") ? "&" : "?") + "useSSL=false&allowPublicKeyRetrieval=true";
            }
            return fullUrl;
        }

        String host = getEnv("MYSQLHOST", "DB_HOST", "MYSQL_HOST");
        String port = getEnv("MYSQLPORT", "DB_PORT", "MYSQL_PORT");
        String db = getEnv("MYSQLDATABASE", "MYSQL_DATABASE", "DB_NAME", "MYSQL_DB");

        if (host != null) {
            if (port == null) port = "3306";
            if (db == null) db = "railway";
            return "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        }

        // Fallback for local development
        return "jdbc:mysql://localhost:3306/dao?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    public static String getUser() {
        String user = getEnv("MYSQLUSER", "DB_USER", "MYSQL_USER");
        return user != null ? user : "root";
    }

    public static String getPassword() {
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

            System.out.println("Connecting to Database: " + url + " as User: " + user);
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