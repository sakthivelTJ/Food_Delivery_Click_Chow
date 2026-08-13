package com.tap.daoIMP;

import com.tap.model.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tap.dao.userDAO;
import com.tap.model.user;
import com.tap.utility.DBconnection;

public class userDAOImp implements userDAO {

	public static final String Insert_Query = "INSERT INTO user (user_name , email ,password  , role ,createdDate , lastLogIN ,address) VALUES (?,?,?,?,?,?,?)";
	public static final String Update_Query = "UPDATE user SET user_name = ? , email = ?, password = ? , role = ? ,lastLogIN = ?, address=? WHERE user_id = ?";

	private String[] getRoleVariants(String role) {
		String r = role != null ? role.trim().toLowerCase().replace("_", "").replace(" ", "") : "customer";
		if (r.equals("delivery") || r.equals("deliverypartner")) {
			return new String[]{"DeliveryPartner", "deliveryPartner", "Delivery Partner", "delivery_partner", "delivery", "Delivery"};
		} else if (r.equals("admin") || r.equals("administrator")) {
			return new String[]{"Admin", "admin", "Administrator"};
		} else {
			return new String[]{"Customer", "customer"};
		}
	}

	@Override
	public int addUser(user user) {
		int i = 0;
		Connection con = DBconnection.getConnection();
		String[] variants = getRoleVariants(user.getRole());

		for (String v : variants) {
			try {
				PreparedStatement stat = con.prepareStatement(Insert_Query);
				stat.setString(1, user.getUser_name());
				stat.setString(2, user.getEmail());
				stat.setString(3, user.getPassword());
				stat.setString(4, v);
				stat.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
				stat.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
				stat.setString(7, user.getAddress());

				i = stat.executeUpdate();
				user.setRole(v);
				System.out.println(i + " Rows affected using role variant: " + v);
				break;
			} catch (SQLException e) {
				if (e.getMessage() != null && e.getMessage().contains("Data truncated for column 'role'")) {
					System.out.println("Role variant '" + v + "' truncated by MySQL ENUM, trying next variant...");
					continue;
				}
				e.printStackTrace();
				break;
			}
		}
		return i;
	}

	@Override
	public user getUser(int user_id) {
		String Show_User = "SELECT * FROM user WHERE user_id = ?";
		Connection con = DBconnection.getConnection();
		PreparedStatement stat = null;
		user user = null;
		try {
			stat = con.prepareStatement(Show_User);
			stat.setInt(1, user_id);
			ResultSet res = stat.executeQuery();

			while (res.next()) {
				int id = res.getInt("user_id");
				String name = res.getString("user_name");
				String email = res.getString("email");
				String password = res.getString("password");
				String role = res.getString("role");
				String createdDate = res.getString("createdDate");
				String lastLogIN = res.getString("lastLogIN");
				String address = res.getString("address");

				user = new user(id, name, email, password, role, createdDate, lastLogIN, address);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public void updateUser(user user) {
		Connection con = DBconnection.getConnection();
		String[] variants = getRoleVariants(user.getRole());

		for (String v : variants) {
			try {
				PreparedStatement stat = con.prepareStatement(Update_Query);
				stat.setString(1, user.getUser_name());
				stat.setString(2, user.getEmail());
				stat.setString(3, user.getPassword());
				stat.setString(4, v);
				stat.setString(5, user.getLastLogIN());
				stat.setString(6, user.getAddress());
				stat.setInt(7, user.getUser_id());

				int i = stat.executeUpdate();
				user.setRole(v);
				System.out.println(i + " Rows affected using role variant: " + v);
				break;
			} catch (SQLException e) {
				if (e.getMessage() != null && e.getMessage().contains("Data truncated for column 'role'")) {
					System.out.println("Role variant '" + v + "' truncated by MySQL ENUM, trying next variant...");
					continue;
				}
				e.printStackTrace();
				break;
			}
		}
	}

	@Override
	public void deleteUser(int user_id) {
		String Delete = "DELETE FROM user where user_id = ? ";
		Connection con = DBconnection.getConnection();
		try {
			PreparedStatement stat = con.prepareStatement(Delete);
			stat.setInt(1, user_id);
			int i = stat.executeUpdate();
			System.out.println(i + " Rows affected");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public user getUserByUsername(String username) {
		user user = null;
		String query = "SELECT * FROM user WHERE user_name = ?";
		Connection con = DBconnection.getConnection();
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, username);
			ResultSet res = pstmt.executeQuery();

			if (res.next()) {
				user = new user();
				user.setUser_id(res.getInt("user_id"));
				user.setUser_name(res.getString("user_name"));
				user.setEmail(res.getString("email"));
				user.setPassword(res.getString("password"));
				user.setRole(res.getString("role"));
				user.setAddress(res.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public List<user> getAllUser() {
		String AllUser = "Select * from user";
		ArrayList<user> ar = new ArrayList<user>();
		Connection con = DBconnection.getConnection();
		try {
			Statement stat = con.createStatement();
			ResultSet res = stat.executeQuery(AllUser);

			while (res.next()) {
				user user = extractUser(res);
				ar.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ar;
	}

	public static user extractUser(ResultSet res) throws SQLException {
		int id = res.getInt("user_id");
		String name = res.getString("user_name");
		String email = res.getString("email");
		String password = res.getString("password");
		String role = res.getString("role");
		String createdDate = res.getString("createdDate");
		String lastLogIN = res.getString("lastLogIN");
		String address = res.getString("address");

		return new user(id, name, email, password, role, createdDate, lastLogIN, address);
	}
}
