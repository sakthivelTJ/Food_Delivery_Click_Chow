package com.tap;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

import com.tap.daoIMP.MenuDAOImp;
import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.model.Menu;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/searchFood")
public class SearchFoodServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        jakarta.servlet.http.HttpSession session = req.getSession();
        if (session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        String ajax = req.getParameter("ajax");
        String rawQuery = req.getParameter("q");
        String query = rawQuery;
        if (query != null) {
            query = query.trim().toLowerCase();
        }

        MenuDAOImp menuDAO = new MenuDAOImp();
        RestaurantDAOImp restaurantDAO = new RestaurantDAOImp();

        List<Menu> allMenus = menuDAO.getAllMenu();
        List<Restaurant> allRestaurants = restaurantDAO.getAllRestaurant();

        Map<Integer, String> restaurantNames = new HashMap<>();
        Map<Integer, Restaurant> restaurantMap = new HashMap<>();
        if (allRestaurants != null) {
            for (Restaurant r : allRestaurants) {
                restaurantNames.put(r.getRestaurant_id(), r.getName());
                restaurantMap.put(r.getRestaurant_id(), r);
            }
        }

        List<Menu> searchResults = new ArrayList<>();
        if (allMenus != null) {
            for (Menu menu : allMenus) {
                if (query != null && !query.isEmpty()) {
                    boolean nameMatch = menu.getItemName() != null && menu.getItemName().toLowerCase().contains(query);
                    boolean descMatch = menu.getDescription() != null && menu.getDescription().toLowerCase().contains(query);
                    String rName = restaurantNames.getOrDefault(menu.getRestaurantID(), "");
                    boolean restMatch = rName.toLowerCase().contains(query);
                    if (!nameMatch && !descMatch && !restMatch) {
                        continue;
                    }
                }
                searchResults.add(menu);
            }
        }

        if ("true".equalsIgnoreCase(ajax)) {
            resp.setContentType("application/json; charset=UTF-8");
            resp.setHeader("Access-Control-Allow-Origin", "*");
            PrintWriter out = resp.getWriter();
            StringBuilder json = new StringBuilder("[");

            boolean first = true;
            for (Menu menu : searchResults) {
                if (!first) {
                    json.append(",");
                }
                first = false;

                String rName = restaurantNames.getOrDefault(menu.getRestaurantID(), "ClickChow Restaurant");

                json.append("{");
                json.append("\"menuId\":").append(menu.getMenuID()).append(",");
                json.append("\"restaurantId\":").append(menu.getRestaurantID()).append(",");
                json.append("\"restaurantName\":\"").append(escapeJson(rName)).append("\",");
                json.append("\"itemName\":\"").append(escapeJson(menu.getItemName())).append("\",");
                json.append("\"description\":\"").append(escapeJson(menu.getDescription())).append("\",");
                json.append("\"price\":").append(menu.getPrice()).append(",");
                json.append("\"rating\":").append(menu.getRating() != null ? menu.getRating() : 4.5).append(",");
                json.append("\"imagePath\":\"").append(escapeJson(menu.getImagePath() != null ? menu.getImagePath() : "")).append("\"");
                json.append("}");
            }

            json.append("]");
            out.print(json.toString());
            out.flush();
        } else {
            req.setAttribute("searchResults", searchResults);
            req.setAttribute("restaurantMap", restaurantMap);
            req.setAttribute("searchQuery", rawQuery == null ? "" : rawQuery);
            req.getRequestDispatcher("searchResults.jsp").forward(req, resp);
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
