package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {

    public static String getUrl() {

        // Railway MySQL URL
        String mysqlUrl = System.getenv("MYSQL_URL");

        if (mysqlUrl != null && !mysqlUrl.trim().isEmpty()) {

            if (mysqlUrl.startsWith("mysql://")) {
                mysqlUrl = "jdbc:" + mysqlUrl;
            }

            return mysqlUrl;
        }

        // Railway MySQL variables
        String host = System.getenv("MYSQLHOST");
        String port = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQL_DATABASE");

        if (host == null || host.trim().isEmpty()) {
            System.err.println("ERROR: MYSQLHOST is missing!");
            return null;
        }

        if (port == null || port.trim().isEmpty()) {
            port = "3306";
        }

        if (database == null || database.trim().isEmpty()) {
            System.err.println("ERROR: MYSQL_DATABASE is missing!");
            return null;
        }

        return "jdbc:mysql://" + host + ":" + port + "/" + database
                + "?useSSL=false"
                + "&allowPublicKeyRetrieval=true"
                + "&serverTimezone=UTC";
    }


    public static String getUser() {

        String user = System.getenv("MYSQLUSER");

        if (user == null || user.trim().isEmpty()) {
            System.err.println("ERROR: MYSQLUSER is missing!");
            return null;
        }

        return user;
    }


    public static String getPassword() {

        String password = System.getenv("MYSQLPASSWORD");

        if (password == null || password.trim().isEmpty()) {
            System.err.println("ERROR: MYSQLPASSWORD is missing!");
            return null;
        }

        return password;
    }


    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = getUrl();
            String user = getUser();
            String password = getPassword();

            if (url == null || user == null || password == null) {
                System.err.println("ERROR: Railway MySQL configuration is incomplete.");
                return null;
            }

            System.out.println("========================================");
            System.out.println("Connecting to Railway MySQL...");
            System.out.println("URL  : " + url);
            System.out.println("USER : " + user);
            System.out.println("========================================");

            Connection connection =
                    DriverManager.getConnection(url, user, password);

            System.out.println("========================================");
            System.out.println("MySQL Database Connected Successfully!");
            System.out.println("========================================");

            return connection;

        } catch (ClassNotFoundException e) {

            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();

        } catch (SQLException e) {

            System.err.println("MYSQL CONNECTION FAILED!");
            e.printStackTrace();
        }

        return null;
    }
}