package com.tap.daoIMP;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.RestaurantDAO;
import com.tap.model.Restaurant;
import com.tap.utility.DBconnection;

public class RestaurantDAOImp implements RestaurantDAO {

	public static final String INSERT_QUERY =
			"INSERT INTO restaurant(name,CustomerType,deliveryTime,address,rating,isActive,imagePath) VALUES(?,?,?,?,?,?,?)";

	public static final String GET_QUERY =
			"SELECT * FROM restaurant WHERE restaurant_id=?";

	public static final String UPDATE_QUERY =
			"UPDATE restaurant SET name=?, CustomerType=?, deliveryTime=?, address=?, rating=?, isActive=?, imagePath=? WHERE restaurant_id=?";

	public static final String DELETE_QUERY =
			"DELETE FROM restaurant WHERE restaurant_id=?";

	public static final String GET_ALL_QUERY =
			"SELECT * FROM restaurant";

	public void addRestaurant(Restaurant restaurant) {

		Connection con = DBconnection.getConnection();

		try {

			PreparedStatement stat = con.prepareStatement(INSERT_QUERY);

			stat.setString(1, restaurant.getName());
			stat.setString(2, restaurant.getCustomerType());
			stat.setString(3, restaurant.getDeliveryTime());
			stat.setString(4, restaurant.getAddress());
			stat.setDouble(5, restaurant.getRating());
			stat.setBoolean(6, restaurant.isIsActive());
			stat.setString(7, restaurant.getImagePath());

			int i = stat.executeUpdate();

			System.out.println(i + " Rows affected");

		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	/////////////////////////////////////////////////////////////////////////

	public Restaurant getRestaurant(int restaurant_id) {

		Connection con = DBconnection.getConnection();

		Restaurant restaurant = null;

		try {

			PreparedStatement stat = con.prepareStatement(GET_QUERY);

			stat.setInt(1, restaurant_id);

			ResultSet res = stat.executeQuery();

			if (res.next()) {

				restaurant = extractRestaurant(res);

			}

		} catch (SQLException e) {

			e.printStackTrace();

		}

		return restaurant;
	}

	/////////////////////////////////////////////////////////////////////////


	public void updateRestaurant(Restaurant restaurant) {

		Connection con = DBconnection.getConnection();

		try {

			PreparedStatement stat = con.prepareStatement(UPDATE_QUERY);

			stat.setString(1, restaurant.getName());
			stat.setString(2, restaurant.getCustomerType());
			stat.setString(3, restaurant.getDeliveryTime());
			stat.setString(4, restaurant.getAddress());
			stat.setDouble(5, restaurant.getRating());
			stat.setBoolean(6, restaurant.isIsActive());
			stat.setString(7, restaurant.getImagePath());
			stat.setInt(8, restaurant.getRestaurant_id());

			int i = stat.executeUpdate();

			System.out.println(i + " Rows affected");

		} catch (SQLException e) {

			e.printStackTrace();

		}

	}

	/////////////////////////////////////////////////////////////////////////

	@Override
	public void deleteRestaurant(int restaurant_id) {

		Connection con = DBconnection.getConnection();

		try {

			PreparedStatement stat = con.prepareStatement(DELETE_QUERY);

			stat.setInt(1, restaurant_id);

			int i = stat.executeUpdate();

			System.out.println(i + " Rows affected");

		} catch (SQLException e) {

			e.printStackTrace();

		}

	}

	/////////////////////////////////////////////////////////////////////////

	public List<Restaurant> getAllRestaurant() {

		ArrayList<Restaurant> list = new ArrayList<>();

		Connection con = DBconnection.getConnection();
		if (con == null) {
			System.err.println("DBconnection returned null in getAllRestaurant()");
			return list;
		}

		try {

			Statement stat = con.createStatement();

			ResultSet res = stat.executeQuery(GET_ALL_QUERY);

			while (res.next()) {

				Restaurant restaurant = extractRestaurant(res);

				list.add(restaurant);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		return list;

	}

	/////////////////////////////////////////////////////////////////////////

	public static Restaurant extractRestaurant(ResultSet res) throws SQLException {

		int id = res.getInt("restaurant_id");
		String name = res.getString("name");
		String customerType = res.getString("customerType");
		String deliveryTime = res.getString("deliveryTime");
		String address = res.getString("address");
		double ratings = res.getDouble("rating");
		boolean isActive = res.getBoolean("isActive");
		String imagePath = res.getString("imagePath");

		return new Restaurant(id, name, customerType, deliveryTime,
				address, ratings, isActive, imagePath);

	}

}
