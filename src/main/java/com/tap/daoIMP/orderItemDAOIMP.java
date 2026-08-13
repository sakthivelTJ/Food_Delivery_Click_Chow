package com.tap.daoIMP;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderItemDAO;
import com.tap.model.order_item;
import com.tap.utility.DBconnection;

public class orderItemDAOIMP implements OrderItemDAO {

    public static final String INSERT_QUERY =
            "INSERT INTO orderitem(order_id,menu_id,quantity,itemTotal) VALUES(?,?,?,?)";

    public static final String GET_QUERY =
            "SELECT * FROM orderitem WHERE orderItem_id=?";

    public static final String UPDATE_QUERY =
            "UPDATE orderitem SET order_id=?, menu_id=?, quantity=?, itemTotal=? WHERE orderItem_id=?";

    public static final String DELETE_QUERY =
            "DELETE FROM orderitem WHERE orderItem_id=?";

    public static final String GET_ALL_QUERY =
            "SELECT * FROM orderitem";

    public void addOrderItem(order_item orderItem) {

        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(INSERT_QUERY);

            stat.setInt(1, orderItem.getOrderID());
            stat.setInt(2, orderItem.getMenuID());
            stat.setInt(3, orderItem.getQuantity());
            stat.setDouble(4, orderItem.getItemTotal());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    ///////////////////////////////////////////////////////////////////////

    public order_item getOrderItem(int orderItem_id) {

        Connection con = DBconnection.getConnection();

        order_item orderItem = null;

        try {

            PreparedStatement stat = con.prepareStatement(GET_QUERY);

            stat.setInt(1, orderItem_id);

            ResultSet res = stat.executeQuery();

            if (res.next()) {

                orderItem = extractOrderItem(res);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return orderItem;

    }

    ///////////////////////////////////////////////////////////////////////

    public void updateOrderItem(order_item orderItem) {

        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(UPDATE_QUERY);

            stat.setInt(1, orderItem.getOrderID());
            stat.setInt(2, orderItem.getMenuID());
            stat.setInt(3, orderItem.getQuantity());
            stat.setDouble(4, orderItem.getItemTotal());
            stat.setInt(5, orderItem.getOrderItemID());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ///////////////////////////////////////////////////////////////////////

    public void deleteOrderItem(int orderItem_id) {

        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(DELETE_QUERY);

            stat.setInt(1, orderItem_id);

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ///////////////////////////////////////////////////////////////////////

    public List<order_item> getAllOrderItem() {

        ArrayList<order_item> list = new ArrayList<>();

        Connection con = DBconnection.getConnection();

        try {

            Statement stat = con.createStatement();

            ResultSet res = stat.executeQuery(GET_ALL_QUERY);

            while (res.next()) {

            	order_item orderItem = extractOrderItem(res);

                list.add(orderItem);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;

    }

    ///////////////////////////////////////////////////////////////////////

    public static order_item extractOrderItem(ResultSet res) throws SQLException {

        int orderItem_id = res.getInt("orderItem_id");
        int order_id = res.getInt("order_id");
        int menu_id = res.getInt("menu_id");
        int quantity = res.getInt("quantity");
        double itemTotal = res.getDouble("itemTotal");

        order_item orderItem = new order_item(
                orderItem_id,
                order_id,
                menu_id,
                quantity,
                itemTotal
        );

        return orderItem;

    }

    @Override
    public List<order_item> getOrderItemsByOrderId(int orderId) {
        ArrayList<order_item> list = new ArrayList<>();
        Connection con = DBconnection.getConnection();
        String sql = "SELECT * FROM orderitem WHERE order_id=?";
        try {
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, orderId);
            ResultSet res = stat.executeQuery();
            while (res.next()) {
                list.add(extractOrderItem(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}