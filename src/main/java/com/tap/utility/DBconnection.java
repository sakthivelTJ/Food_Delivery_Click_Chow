package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {

    // ==============================
    // DATABASE URL
    // ==============================
    public static String getUrl() {

        // Railway MYSQL_URL
        String mysqlUrl = System.getenv("MYSQL_URL");

        if (mysqlUrl != null && !mysqlUrl.trim().isEmpty()) {

            if (mysqlUrl.startsWith("mysql://")) {
                mysqlUrl = "jdbc:" + mysqlUrl;
            }

            return mysqlUrl;
        }

        // Railway individual MySQL variables
        String host = System.getenv("DB_HOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQL_DATABASE");

        if (host != null && !host.trim().isEmpty()) {

            if (port == null || port.trim().isEmpty()) {
                port = "3306";
            }

            if (database == null || database.trim().isEmpty()) {
                database = "dao";
            }

            return "jdbc:mysql://" + host + ":" + port + "/" + database
                    + "?useSSL=false"
                    + "&allowPublicKeyRetrieval=true"
                    + "&serverTimezone=UTC";
        }

        // Optional custom database URL
        String customUrl = System.getenv("DB_URL");

        if (customUrl != null && !customUrl.trim().isEmpty()) {
            return customUrl;
        }

        // Local development fallback
        return "jdbc:mysql://localhost:3306/dao"
                + "?useSSL=false"
                + "&allowPublicKeyRetrieval=true"
                + "&serverTimezone=UTC";
    }


    // ==============================
    // DATABASE USERNAME
    // ==============================
    public static String getUser() {

        String mysqlUser = System.getenv("MYSQLUSER");

        if (mysqlUser != null && !mysqlUser.trim().isEmpty()) {
            return mysqlUser;
        }

        String customUser = System.getenv("DB_USER");

        if (customUser != null && !customUser.trim().isEmpty()) {
            return customUser;
        }

        // Local development
        return "root";
    }


    // ==============================
    // DATABASE PASSWORD
    // ==============================
    public static String getPassword() {

        String mysqlPassword = System.getenv("MYSQLPASSWORD");

        if (mysqlPassword != null && !mysqlPassword.trim().isEmpty()) {
            return mysqlPassword;
        }

        String customPassword = System.getenv("DB_PASSWORD");

        if (customPassword != null && !customPassword.trim().isEmpty()) {
            return customPassword;
        }

        // Local development
        return "Lucifer.t.j7";
    }


    // ==============================
    // CREATE DATABASE CONNECTION
    // ==============================
    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = getUrl();
            String user = getUser();
            String password = getPassword();

            System.out.println("========================================");
            System.out.println("Database Connection Information");
            System.out.println("URL  : " + url);
            System.out.println("User : " + user);
            System.out.println("========================================");

            Connection connection =
                    DriverManager.getConnection(url, user, password);

            System.out.println("MySQL Database Connected Successfully!");

            return connection;

        } catch (ClassNotFoundException e) {

            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();

        } catch (SQLException e) {

            System.err.println("Failed to connect to MySQL Database!");
            e.printStackTrace();
        }

        return null;
    }
}