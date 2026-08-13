package com.tap;

import java.io.IOException;
import java.util.List;

import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.daoIMP.userDAOImp;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/accessed")
public class AfterAccess extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		
		RestaurantDAOImp restaurantDAOImp = new RestaurantDAOImp();
		List<Restaurant> allRestaurant = restaurantDAOImp.getAllRestaurant();
		
		for (Restaurant restaurant : allRestaurant) {
			System.out.println(restaurant);
		}
		
		req.setAttribute("allRestaurant", allRestaurant);
		
		RequestDispatcher rd = req.getRequestDispatcher("/myindex.jsp");
		rd.forward(req, resp);
	}
}
