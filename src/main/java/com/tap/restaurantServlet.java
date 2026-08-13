package com.tap;

import java.io.IOException;


import java.util.List;

import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/restaurant")
public class restaurantServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Restaurant> allRestaurant = null;
		try {
			RestaurantDAOImp restaurantDAOImp = new RestaurantDAOImp();
			allRestaurant = restaurantDAOImp.getAllRestaurant();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (allRestaurant == null) {
			allRestaurant = new java.util.ArrayList<>();
		}
		
		for (Restaurant restaurant : allRestaurant) {
			System.out.println(restaurant);
		}
		
		req.setAttribute("allRestaurant", allRestaurant);
		
		RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
		rd.forward(req, resp);
	}
}

