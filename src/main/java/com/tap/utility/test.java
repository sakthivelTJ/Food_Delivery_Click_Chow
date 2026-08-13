package com.tap.utility;

import java.util.List;

import com.tap.daoIMP.userDAOImp;
import com.tap.model.user;

public class test {

	public static void main(String[] args) {
		
		
		userDAOImp userDAOImp = new userDAOImp();
		
		
		
		
		System.out.println("User Added Successfully");
		
	}

}

//***************
//List<user> ar = userDAOImp.getAllUser();
//
//System.out.println(ar);
//







//		user user = userDAOImp.getUser(2);
//		user.setEmail("alex123@gmail.com");
//		
//		userDAOImp.updateUser(user);

//		user us = userDAOImp.getUser(user_id);
//		System.out.println(us);
//		user user = new user(1);
//		userDAOImp.deleteUser(user_id);