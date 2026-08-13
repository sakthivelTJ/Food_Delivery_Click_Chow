package com.tap;

import java.io.IOException;

import com.tap.model.Carts;
import com.tap.model.Menu;
import com.tap.daoIMP.MenuDAOImp;
import com.tap.model.CartItems;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cartServlet")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

    	HttpSession session = req.getSession();
    	Carts cart = (Carts) session.getAttribute("cart");
    	
    	if (cart == null) {
    		cart = new Carts();
    		session.setAttribute("cart", cart);
    	}
    	
    	Integer newRestaurantId = getIntParam(req, "restaurantid", "restaurantId", "restId");
    	Integer cartRestaurantId = null;
    	if (cart.getItems() != null && !cart.getItems().isEmpty()) {
    		CartItems firstItem = cart.getItems().values().iterator().next();
    		cartRestaurantId = firstItem.getRestaurantId();
    	}
    	
    	String action = getParam(req, "action");
    	String forceStr = getParam(req, "force", "clearAndAdd", "override");
    	boolean forceClear = "true".equalsIgnoreCase(forceStr);
    	boolean isAjax = "XMLHttpRequest".equalsIgnoreCase(req.getHeader("X-Requested-With")) 
    	        || "true".equalsIgnoreCase(req.getParameter("ajax"));
    	
    	if ("add".equalsIgnoreCase(action)) {
    		if (cartRestaurantId != null && newRestaurantId != null && !cartRestaurantId.equals(newRestaurantId)) {
    			if (!forceClear && isAjax) {
    				resp.setContentType("application/json");
    				resp.setCharacterEncoding("UTF-8");
    				resp.getWriter().write("{\"status\":\"conflict\",\"message\":\"Cart contains items from another restaurant\",\"currentRestaurantId\":" + cartRestaurantId + ",\"newRestaurantId\":" + newRestaurantId + "}");
    				return;
    			}
    			// Clear previous restaurant items if forced or non-AJAX fallback
    			cart.clear();
    			session.setAttribute("cart", cart);
    		}
    		
    		if (newRestaurantId != null) {
    			session.setAttribute("restaurantid", newRestaurantId);
    		}
    		addItemsToCart(req, cart);
    	} else if ("update".equalsIgnoreCase(action)) {
    		updateItemToCart(req, cart);
    	} else if ("delete".equalsIgnoreCase(action) || "remove".equalsIgnoreCase(action)) {
    		removeItemsFromCart(req, cart);
    	} else if ("clear".equalsIgnoreCase(action)) {
    		cart.clear();
    		session.setAttribute("cart", cart);
    	}


    	if (isAjax) {
    	    resp.setContentType("application/json");
    	    resp.setCharacterEncoding("UTF-8");

    	    double total = 0;
    	    int totalCount = 0;
    	    StringBuilder itemsJson = new StringBuilder("[");
    	    if (cart != null && cart.getItems() != null) {
    	        boolean first = true;
    	        for (CartItems item : cart.getItems().values()) {
    	            if (!first) itemsJson.append(",");
    	            first = false;
    	            String itemNameStr = (item.getName() != null && !item.getName().trim().isEmpty()) 
    	                    ? item.getName() : "Food Item #" + item.getMenuId();
    	            double itemPriceVal = item.getPrice();
    	            int itemQtyVal = item.getQuantity();
    	            double subtotal = item.getSubTotal();
    	            total += subtotal;
    	            totalCount += itemQtyVal;
    	            
    	            String imgPath = item.getImagePath();
    	            if (imgPath == null || imgPath.trim().isEmpty()) {
    	            	imgPath = "assets/images/paneertikka.png";
    	            }
    	            
    	            itemsJson.append("{")
    	                    .append("\"menuId\":").append(item.getMenuId()).append(",")
    	                    .append("\"restaurantId\":").append(item.getRestaurantId()).append(",")
    	                    .append("\"name\":\"").append(escapeJson(itemNameStr)).append("\",")
    	                    .append("\"price\":").append(itemPriceVal).append(",")
    	                    .append("\"quantity\":").append(itemQtyVal).append(",")
    	                    .append("\"subtotal\":").append(subtotal).append(",")
    	                    .append("\"imagePath\":\"").append(escapeJson(imgPath)).append("\"")
    	                    .append("}");
    	        }
    	    }
    	    itemsJson.append("]");

    	    double deliveryFee = 40.0;
    	    double gst = 35.0;
    	    double grandTotal = total > 0 ? (total + deliveryFee + gst) : 0;
    	    session.setAttribute("grandTotal", grandTotal);

    	    String json = "{"
    	            + "\"items\":" + itemsJson.toString() + ","
    	            + "\"subtotal\":" + total + ","
    	            + "\"totalCount\":" + totalCount + ","
    	            + "\"deliveryFee\":" + deliveryFee + ","
    	            + "\"gst\":" + gst + ","
    	            + "\"grandTotal\":" + grandTotal
    	            + "}";

    	    resp.getWriter().write(json);
    	    return;
    	}

    	RequestDispatcher rd = req.getRequestDispatcher("cart.jsp");
    	rd.forward(req, resp);
    }

    public static String getParam(HttpServletRequest req, String... names) {
        for (String name : names) {
            String val = req.getParameter(name);
            if (val != null && !val.trim().isEmpty()) {
                return val.trim();
            }
        }
        return null;
    }

    public static Integer getIntParam(HttpServletRequest req, String... names) {
        String str = getParam(req, names);
        if (str != null) {
            try {
                return Integer.parseInt(str);
            } catch (Exception e) {}
        }
        return null;
    }

    public static Double getDoubleParam(HttpServletRequest req, String... names) {
        String str = getParam(req, names);
        if (str != null) {
            try {
                return Double.parseDouble(str);
            } catch (Exception e) {}
        }
        return null;
    }

    public static String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\b", "\\b")
                  .replace("\f", "\\f")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }

	private void removeItemsFromCart(HttpServletRequest req, Carts cart) {
		Integer menuIdObj = getIntParam(req, "menuid", "menuId", "itemId", "itemid", "id");
		if (menuIdObj != null && cart != null) {
			cart.removeitems(menuIdObj);
		}
	}

	private void updateItemToCart(HttpServletRequest req, Carts cart) {
		Integer menuIdObj = getIntParam(req, "menuid", "menuId", "itemId", "itemid", "id");
		Integer quantityObj = getIntParam(req, "quantity", "qty", "count");
		if (menuIdObj != null && cart != null) {
			int quantity = quantityObj != null ? quantityObj : 1;
			cart.updateItems(menuIdObj, quantity);
		}
	}

	private void addItemsToCart(HttpServletRequest req, Carts cart) {
		Integer menuIdObj = getIntParam(req, "menuid", "menuId", "itemId", "itemid", "id");
		if (menuIdObj == null) return;
		int menuId = menuIdObj;

		Integer quantityObj = getIntParam(req, "quantity", "qty", "count");
		int quantity = (quantityObj != null && quantityObj > 0) ? quantityObj : 1;

		String paramName = getParam(req, "itemname", "itemName", "name", "dishName", "title");
		Double paramPrice = getDoubleParam(req, "itemprice", "itemPrice", "price");
		String paramImg = getParam(req, "itemimage", "itemImage", "image", "imagePath");
		Integer paramRest = getIntParam(req, "restaurantid", "restaurantId", "restId");

		double price = (paramPrice != null && paramPrice > 0) ? paramPrice : 150.0;
		int restId = (paramRest != null && paramRest > 0) ? paramRest : 1;
		String itemName = (paramName != null && !paramName.isEmpty()) ? paramName : "Food Item #" + menuId;
		String imgPath = paramImg;

		try {
			MenuDAOImp menuDAOImp = new MenuDAOImp();
			Menu menu = menuDAOImp.getMenu(menuId);
			if (menu != null) {
				if (menu.getItemName() != null && !menu.getItemName().trim().isEmpty()) {
					itemName = menu.getItemName();
				}
				if (menu.getPrice() > 0) {
					price = menu.getPrice();
				}
				if (menu.getRestaurantID() > 0) {
					restId = menu.getRestaurantID();
				}
				if (menu.getImagePath() != null && !menu.getImagePath().trim().isEmpty()) {
					imgPath = menu.getImagePath();
				}
			}
		} catch (Exception e) {
			// Fallback to request parameters if DAO fails
		}

		HttpSession session = req.getSession();
		session.setAttribute("restaurantid", restId);

		if (imgPath == null || imgPath.trim().isEmpty() || imgPath.startsWith("images/menu/") || imgPath.contains("biryani.png")) {
			String nameLower = itemName != null ? itemName.toLowerCase() : "";
			if (nameLower.contains("biryani") || nameLower.contains("rice") || nameLower.contains("pulao") || nameLower.contains("thali") || nameLower.contains("dosa") || nameLower.contains("idli")) {
				imgPath = "assets/images/biryani.png";
			} else if (nameLower.contains("burger") || nameLower.contains("sandwich") || nameLower.contains("wrap") || nameLower.contains("roll")) {
				imgPath = "assets/images/burger.png";
			} else if (nameLower.contains("pizza") || nameLower.contains("naan") || nameLower.contains("roti") || nameLower.contains("bread") || nameLower.contains("pasta")) {
				imgPath = "assets/images/pizza.png";
			} else if (nameLower.contains("sushi") || nameLower.contains("noodle") || nameLower.contains("ramen") || nameLower.contains("fish")) {
				imgPath = "assets/images/sushi.png";
			} else if (nameLower.contains("dessert") || nameLower.contains("cake") || nameLower.contains("ice cream") || nameLower.contains("sweet") || nameLower.contains("shake") || nameLower.contains("coffee")) {
				imgPath = "assets/images/dessert.png";
			} else {
				imgPath = "assets/images/paneertikka.png";
			}
		}

		CartItems cartItems = new CartItems(menuId, restId, itemName, price, quantity, imgPath);
		cart.addItems(cartItems);
	}
}
