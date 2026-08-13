package com.tap.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {

    public static String getUrl() {
        String envUrl = System.getenv("MYSQL_URL");
        if (envUrl != null && !envUrl.trim().isEmpty()) {
            if (!envUrl.startsWith("jdbc:mysql://")) {
                envUrl = "jdbc:" + envUrl;
            }
            return envUrl;
        }

        String host = System.getenv("MYSQLHOST");
        if (host != null && !host.trim().isEmpty()) {
            String port = System.getenv("MYSQLPORT") != null ? System.getenv("MYSQLPORT") : "3306";
            String db = System.getenv("MYSQLDATABASE") != null ? System.getenv("MYSQLDATABASE") : "dao";
            return "jdbc:mysql://" + host + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true";
        }

        String customUrl = System.getenv("DB_URL");
        if (customUrl != null && !customUrl.trim().isEmpty()) {
            return customUrl;
        }

        return "jdbc:mysql://localhost:3306/dao?useSSL=false&allowPublicKeyRetrieval=true";
    }

    public static String getUser() {
        String envUser = System.getenv("MYSQLUSER");
        if (envUser != null && !envUser.trim().isEmpty()) return envUser;
        String customUser = System.getenv("DB_USER");
        if (customUser != null && !customUser.trim().isEmpty()) return customUser;
        return "root";
    }

    public static String getPassword() {
        String envPass = System.getenv("MYSQLPASSWORD");
        if (envPass != null && !envPass.trim().isEmpty()) return envPass;
        String customPass = System.getenv("DB_PASSWORD");
        if (customPass != null && !customPass.trim().isEmpty()) return customPass;
        return "Lucifer.t.j7";
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(getUrl(), getUser(), getPassword());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }
}

