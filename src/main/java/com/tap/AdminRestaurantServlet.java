package com.tap;

import java.io.IOException;
import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminRestaurantServlet")
public class AdminRestaurantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        RestaurantDAOImp restaurantDAO = new RestaurantDAOImp();

        try {
            if ("add".equalsIgnoreCase(action)) {
                String name = req.getParameter("name");
                String customerType = req.getParameter("customerType");
                String deliveryTime = req.getParameter("deliveryTime");
                String address = req.getParameter("address");
                double rating = Double.parseDouble(req.getParameter("rating"));
                boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
                String imagePath = req.getParameter("imagePath");

                Restaurant res = new Restaurant(0, name, customerType, deliveryTime, address, rating, isActive, imagePath);
                restaurantDAO.addRestaurant(res);
                req.getSession().setAttribute("adminMsg", "Restaurant '" + name + "' added successfully!");

            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("restaurant_id"));
                String name = req.getParameter("name");
                String customerType = req.getParameter("customerType");
                String deliveryTime = req.getParameter("deliveryTime");
                String address = req.getParameter("address");
                double rating = Double.parseDouble(req.getParameter("rating"));
                boolean isActive = Boolean.parseBoolean(req.getParameter("isActive"));
                String imagePath = req.getParameter("imagePath");

                Restaurant res = new Restaurant(id, name, customerType, deliveryTime, address, rating, isActive, imagePath);
                restaurantDAO.updateRestaurant(res);
                req.getSession().setAttribute("adminMsg", "Restaurant '" + name + "' updated successfully!");

            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("restaurant_id"));
                restaurantDAO.deleteRestaurant(id);
                req.getSession().setAttribute("adminMsg", "Restaurant ID " + id + " deleted successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError", "Error processing restaurant operation: " + e.getMessage());
        }

        resp.sendRedirect("adminMenu.jsp");
    }
}
