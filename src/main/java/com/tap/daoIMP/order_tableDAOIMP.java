package com.tap.daoIMP;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.OrderTableDAO;
import com.tap.model.order_table;
import com.tap.utility.DBconnection;

public class order_tableDAOIMP implements OrderTableDAO {

    public static final String INSERT_QUERY =
            "INSERT INTO ordertable(user_id,restaurant_id,orderDate,totalAmount,status,paymentMethod) VALUES(?,?,?,?,?,?)";

    public static final String GET_QUERY =
            "SELECT * FROM ordertable WHERE order_id=?";

    public static final String UPDATE_QUERY =
            "UPDATE ordertable SET user_id=?, restaurant_id=?, orderDate=?, totalAmount=?, status=?, paymentMethod=? WHERE order_id=?";

    public static final String DELETE_QUERY =
            "DELETE FROM ordertable WHERE order_id=?";

    public static final String GET_ALL_QUERY =
            "SELECT * FROM ordertable";

    public int addOrder(order_table order) {

    	int order_id = 0;
        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(INSERT_QUERY, Statement.RETURN_GENERATED_KEYS);

            stat.setInt(1, order.getUserID());
            stat.setInt(2, order.getRestaurantID());
            stat.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stat.setDouble(4, order.getTotalAmount());
            stat.setString(5, order.getStatus());
            stat.setString(6, order.getPaymentMethod());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");
            ResultSet res = stat.getGeneratedKeys();
            if(res.next()) {
            	order_id=res.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order_id;
        

    }

    ////////////////////////////////////////////////////////////////////////

    public order_table getOrder(int order_id) {

        Connection con = DBconnection.getConnection();

        order_table order = null;

        try {

            PreparedStatement stat = con.prepareStatement(GET_QUERY);

            stat.setInt(1, order_id);

            ResultSet res = stat.executeQuery();

            if (res.next()) {

                order = extractOrder(res);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return order;

    }

    ////////////////////////////////////////////////////////////////////////

    public void updateOrder(order_table order) {

        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(UPDATE_QUERY);

            stat.setInt(1, order.getUserID());
            stat.setInt(2, order.getRestaurantID());
            stat.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            stat.setDouble(4, order.getTotalAmount());
            stat.setString(5, order.getStatus());
            stat.setString(6, order.getPaymentMethod());
            stat.setInt(7, order.getOrderID());

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ////////////////////////////////////////////////////////////////////////

    public void deleteOrder(int order_id) {

        Connection con = DBconnection.getConnection();

        try {

            PreparedStatement stat = con.prepareStatement(DELETE_QUERY);

            stat.setInt(1, order_id);

            int i = stat.executeUpdate();

            System.out.println(i + " Rows affected");

        } catch (SQLException e) {

            e.printStackTrace();

        }

    }

    ////////////////////////////////////////////////////////////////////////

    public List<order_table> getAllOrder() {

        ArrayList<order_table> list = new ArrayList<>();

        Connection con = DBconnection.getConnection();

        try {

            Statement stat = con.createStatement();

            ResultSet res = stat.executeQuery(GET_ALL_QUERY);

            while (res.next()) {

            	order_table order = extractOrder(res);

                list.add(order);

            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;

    }

    ////////////////////////////////////////////////////////////////////////

    public static order_table extractOrder(ResultSet res) throws SQLException {

        int order_id = res.getInt("order_id");
        int user_id = res.getInt("user_id");
        Date orderDate = res.getTimestamp("orderDate") != null ? res.getTimestamp("orderDate") : res.getDate("orderDate");
        double totalAmount = res.getDouble("totalAmount");
        int restaurant_id = res.getInt("restaurant_id");
        String status = res.getString("status");
        String paymentMethod = res.getString("paymentMethod");

        order_table order = new order_table(order_id, user_id, orderDate, totalAmount, status, paymentMethod, restaurant_id);
        return order;
    }

    @Override
    public List<order_table> getOrdersByUserId(int userId) {
        ArrayList<order_table> list = new ArrayList<>();
        Connection con = DBconnection.getConnection();
        String sql = "SELECT * FROM ordertable WHERE user_id=? ORDER BY order_id DESC";
        try {
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, userId);
            ResultSet res = stat.executeQuery();
            while (res.next()) {
                list.add(extractOrder(res));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}