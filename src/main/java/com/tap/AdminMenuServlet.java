package com.tap;

import java.io.IOException;
import com.tap.daoIMP.MenuDAOImp;
import com.tap.model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminMenuServlet")
public class AdminMenuServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        MenuDAOImp menuDAO = new MenuDAOImp();
        
        try {
            if ("add".equalsIgnoreCase(action)) {
                int restaurantID = Integer.parseInt(req.getParameter("restaurantID"));
                String itemName = req.getParameter("itemName");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
                String imagePath = req.getParameter("imagePath");
                double rating = Double.parseDouble(req.getParameter("rating"));

                Menu newMenu = new Menu(0, restaurantID, itemName, description, price, isAvailable, imagePath, rating);
                menuDAO.addMenu(newMenu);
                req.getSession().setAttribute("adminMsg", "Menu item '" + itemName + "' added successfully!");

            } else if ("update".equalsIgnoreCase(action)) {
                int menuID = Integer.parseInt(req.getParameter("menuID"));
                int restaurantID = Integer.parseInt(req.getParameter("restaurantID"));
                String itemName = req.getParameter("itemName");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                boolean isAvailable = Boolean.parseBoolean(req.getParameter("isAvailable"));
                String imagePath = req.getParameter("imagePath");
                double rating = Double.parseDouble(req.getParameter("rating"));

                Menu updatedMenu = new Menu(menuID, restaurantID, itemName, description, price, isAvailable, imagePath, rating);
                menuDAO.updateMenu(updatedMenu);
                req.getSession().setAttribute("adminMsg", "Menu item '" + itemName + "' updated successfully!");

            } else if ("delete".equalsIgnoreCase(action)) {
                int menuID = Integer.parseInt(req.getParameter("menuID"));
                menuDAO.deleteMenu(menuID);
                req.getSession().setAttribute("adminMsg", "Menu item ID " + menuID + " deleted successfully!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError", "Error processing menu operation: " + e.getMessage());
        }

        String filterRest = req.getParameter("filterRestaurantID");
        if (filterRest != null && !filterRest.isEmpty()) {
            resp.sendRedirect("adminMenu.jsp?restaurantID=" + filterRest);
        } else {
            resp.sendRedirect("adminMenu.jsp");
        }
    }
}
