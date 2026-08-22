package com.tap.utility;

import java.util.List;
import com.tap.daoIMP.MenuDAOImp;
import com.tap.model.Menu;

public class test {

	public static void main(String[] args) {
		try {
			MenuDAOImp dao = new MenuDAOImp();
			List<Menu> menus = dao.getAllMenu();
			System.out.println("--- MENU ITEMS ---");
			for (Menu m : menus) {
				System.out.println("ID: " + m.getMenuID() + " | Name: " + m.getItemName() + " | Path: " + m.getImagePath() + " | Price: " + m.getPrice());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
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