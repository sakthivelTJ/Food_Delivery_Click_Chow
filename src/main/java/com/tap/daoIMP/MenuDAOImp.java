package com.tap.daoIMP;

import com.tap.model.*;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.MenuDAO;
import com.tap.model.Menu;
import com.tap.utility.DBconnection;

public class MenuDAOImp implements MenuDAO {

    public static final String INSERT_QUERY =
            "INSERT INTO menu (restaurantID,itemName,description,price,isAvailable,imagePath,Rating) VALUES (?,?,?,?,?,?,?)";

    public static final String GET_QUERY =
            "SELECT * FROM menu WHERE menuID=?";

    public static final String UPDATE_QUERY =
            "UPDATE menu SET restaurantID=?, itemName=?, description=?, price=?, isAvailable=?, imagePath=?, Rating=? WHERE menuID=?";

    public static final String DELETE_QUERY =
            "DELETE FROM menu WHERE menuID=?";

    public static final String GET_ALL_QUERY =
            "SELECT * FROM menu";

    public static final String GET_BY_RESTAURANT_QUERY =
            "SELECT * FROM menu WHERE RestaurantID=?";

    public void addMenu(Menu menu) {

        Connection con = DBconnection.getConnection();
        if (con == null) return;

        try {

            PreparedStatement stat = con.prepareStatement(INSERT_QUERY);

            stat.setInt(1, menu.getRestaurantID());
            stat.setString(2, menu.getItemName());
            stat.setString(3, menu.getDescription());
            stat.setDouble(4, menu.getPrice());
            stat.setBoolean(5, menu.isAvailable());
            stat.setString(6, menu.getImagePath());
            stat.setDouble(7, menu.getRating());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    ///////////////////////////////////////////////////////////////////////

    public Menu getMenu(int menu_id) {

        Connection con = DBconnection.getConnection();
        if (con == null) return null;

        Menu menu = null;

        try {

            PreparedStatement stat = con.prepareStatement(GET_QUERY);

            stat.setInt(1, menu_id);

            ResultSet res = stat.executeQuery();

            if (res.next()) {

                menu = extractMenu(res);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return menu;

    }

    ///////////////////////////////////////////////////////////////////////

    public void updateMenu(Menu menu) {

        Connection con = DBconnection.getConnection();
        if (con == null) return;

        try {

            PreparedStatement stat = con.prepareStatement(UPDATE_QUERY);

            stat.setInt(1, menu.getRestaurantID());
            stat.setString(2, menu.getItemName());
            stat.setString(3, menu.getDescription());
            stat.setDouble(4, menu.getPrice());
            stat.setBoolean(5, menu.isAvailable());
            stat.setString(6, menu.getImagePath());
            stat.setDouble(7,menu.getRating());
            stat.setInt(8, menu.getMenuID());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ///////////////////////////////////////////////////////////////////////

    public void deleteMenu(int menu_id) {

        Connection con = DBconnection.getConnection();
        if (con == null) return;

        try {

            PreparedStatement stat = con.prepareStatement(DELETE_QUERY);

            stat.setInt(1, menu_id);

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ///////////////////////////////////////////////////////////////////////

    public List<Menu> getAllMenu() {

        ArrayList<Menu> list = new ArrayList<>();

        Connection con = DBconnection.getConnection();
        if (con == null) return list;

        try {

            Statement stat = con.createStatement();

            ResultSet res = stat.executeQuery(GET_ALL_QUERY);

            while (res.next()) {

                Menu menu = extractMenu(res);

                list.add(menu);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;

    }

    ///////////////////////////////////////////////////////////////////////

    public static Menu extractMenu(ResultSet res) throws SQLException {
        int menu_id = getIntSafe(res, "menuID", "menu_id");
        int restaurant_id = getIntSafe(res, "restaurantID", "restaurant_id");
        String itemName = getStringSafe(res, "itemName", "item_name", "name");
        String description = getStringSafe(res, "description");
        double price = getDoubleSafe(res, "price");
        boolean isAvailable = getBooleanSafe(res, "isAvailable", "is_available");
        String imagePath = getStringSafe(res, "imagePath", "image_path", "image");
        double rating = getDoubleSafe(res, "Rating", "rating");

        return new Menu(menu_id, restaurant_id, itemName, description, price, isAvailable, imagePath, rating);
    }

    private static int getIntSafe(ResultSet res, String... colNames) {
        for (String col : colNames) {
            try {
                return res.getInt(col);
            } catch (SQLException e) {}
        }
        return 0;
    }

    private static double getDoubleSafe(ResultSet res, String... colNames) {
        for (String col : colNames) {
            try {
                return res.getDouble(col);
            } catch (SQLException e) {}
        }
        return 0.0;
    }

    private static boolean getBooleanSafe(ResultSet res, String... colNames) {
        for (String col : colNames) {
            try {
                return res.getBoolean(col);
            } catch (SQLException e) {}
        }
        return true;
    }

    private static String getStringSafe(ResultSet res, String... colNames) {
        for (String col : colNames) {
            try {
                String val = res.getString(col);
                if (val != null) return val;
            } catch (SQLException e) {}
        }
        return "";
    }

    ///////////////////////////////////////////////////////////////////////

    public List<Menu> getMenuByRestaurant(int restaurantId) {

        ArrayList<Menu> list = new ArrayList<>();

        Connection con = DBconnection.getConnection();
        if (con == null) return list;

        try {

            PreparedStatement stat = con.prepareStatement(GET_BY_RESTAURANT_QUERY);

            stat.setInt(1, restaurantId);

            ResultSet res = stat.executeQuery();

            while (res.next()) {

                Menu menu = extractMenu(res);

                list.add(menu);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;

    }

}