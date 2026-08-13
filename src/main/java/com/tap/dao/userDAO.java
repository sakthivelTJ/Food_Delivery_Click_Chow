package com.tap.dao;

import java.util.List;

import com.tap.model.user;

public interface userDAO {

	int addUser(user user);
	user getUser(int user_id);
	void updateUser(user user);
	void deleteUser(int user_id);
	List<user> getAllUser();
	user getUserByUsername(String username);
	
}
