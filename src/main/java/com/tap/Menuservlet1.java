package com.tap;

import java.io.IOException;
import java.util.List;

import com.tap.daoIMP.MenuDAOImp;
import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/menu")
public class Menuservlet1 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String paramStr = req.getParameter("restaurantId");
		int restaurantId = 1;

		if (paramStr != null && !paramStr.trim().isEmpty()) {
			try {
				restaurantId = Integer.parseInt(paramStr.trim());
			} catch (Exception e) {
				restaurantId = 1;
			}
		} else {
			Integer sessRestId = (Integer) session.getAttribute("restaurantid");
			if (sessRestId != null) {
				restaurantId = sessRestId;
			}
		}

		RestaurantDAOImp restaurantDAOImp = new RestaurantDAOImp();
		Restaurant restaurant = restaurantDAOImp.getRestaurant(restaurantId);
		if (restaurant == null) {
			List<Restaurant> allRests = restaurantDAOImp.getAllRestaurant();
			if (allRests != null && !allRests.isEmpty()) {
				restaurant = allRests.get(0);
				restaurantId = restaurant.getRestaurant_id();
			} 
		}
		req.setAttribute("restaurant", restaurant);
		session.setAttribute("restaurantid", restaurantId);

		MenuDAOImp menuDAOImp = new MenuDAOImp();
		List<Menu> menuByRestaurant = menuDAOImp.getMenuByRestaurant(restaurantId);
		if (menuByRestaurant == null || menuByRestaurant.isEmpty()) {
			menuByRestaurant = menuDAOImp.getAllMenu();
		}
		req.setAttribute("menuByRestaurant", menuByRestaurant);

		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
		rd.forward(req, resp);
	}
}

