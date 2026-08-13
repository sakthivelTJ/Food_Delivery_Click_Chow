package com.tap;

import java.io.IOException;
import java.sql.Timestamp;

import com.tap.daoIMP.orderItemDAOIMP;
import com.tap.daoIMP.order_tableDAOIMP;
import com.tap.model.CartItems;
import com.tap.model.Carts;
import com.tap.model.order_item;
import com.tap.model.order_table;
import com.tap.model.user;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.tap.daoIMP.userDAOImp;

@WebServlet("/checkoutServlet")
public class checkOutServlet extends HttpServlet
{

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		user user = (user)session.getAttribute("loggedInUser");
		Carts cart =(Carts)session.getAttribute("cart");
		Integer  restaurantId = (Integer)session.getAttribute("restaurantid");
		double grandTotal = (double)session.getAttribute("grandTotal");
		
		if(user !=null) {
			
			if(cart !=null && !cart.getItems().isEmpty()) {
				int user_id = user.getUser_id();
				String fullName = req.getParameter("fullName");
				String phone = req.getParameter("phone");
				String email = req.getParameter("email");
				String address = req.getParameter("address");
				String paymentMethod = req.getParameter("paymentMethod");
				
				// Update user details if provided in checkout form
				if (fullName != null && !fullName.trim().isEmpty()) {
					user.setUser_name(fullName);
				}
				if (email != null && !email.trim().isEmpty()) {
					user.setEmail(email);
				}
				if (address != null && !address.trim().isEmpty()) {
					String formattedAddress = address;
					if (phone != null && !phone.trim().isEmpty() && !address.toLowerCase().contains("phone")) {
						formattedAddress = address + " | Phone: " + phone;
					}
					user.setAddress(formattedAddress);
				}
				
				userDAOImp userDAO = new userDAOImp();
				userDAO.updateUser(user);
				session.setAttribute("loggedInUser", user);
				
				order_table order = new order_table(user_id, 
						new Timestamp(System.currentTimeMillis()),
						grandTotal,
						"Pending", 
						paymentMethod, 
						restaurantId
						);
				
				order_tableDAOIMP order_tableDAOIMP = new order_tableDAOIMP();
				int order_id = order_tableDAOIMP.addOrder(order);
				
				orderItemDAOIMP orderItemDAOIMP = new orderItemDAOIMP();
				for(CartItems items: cart.getItems().values()) {
					
					int menuId = items.getMenuId();
					int quantity = items.getQuantity();
					double totalPrice = items.getPrice() * quantity;
					
					order_item od = new order_item(order_id, menuId, quantity, totalPrice);
					orderItemDAOIMP.addOrderItem(od);
					System.out.println(od + " Added to orderitem table");
					
				}
				
				session.removeAttribute("cart");
				session.removeAttribute("restaurantid");
				session.removeAttribute("grandTotal");
				
				resp.sendRedirect("orderConfirmed.jsp");
				
				
				
			}
		}
		else {
			RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
			rd.forward(req, resp);
		}
		
		
	}
	
}
