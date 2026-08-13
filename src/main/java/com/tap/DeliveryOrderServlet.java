package com.tap;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.tap.daoIMP.order_tableDAOIMP;
import com.tap.model.order_table;
import com.tap.daoIMP.RestaurantDAOImp;
import com.tap.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeliveryOrderServlet")
public class DeliveryOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        order_tableDAOIMP orderDAO = new order_tableDAOIMP();

        if ("fetchNewOrder".equalsIgnoreCase(action)) {
            resp.setContentType("application/json");
            PrintWriter out = resp.getWriter();

            HttpSession session = req.getSession();
            @SuppressWarnings("unchecked")
            Set<Integer> declinedOrders = (Set<Integer>) session.getAttribute("declinedOrders");
            if (declinedOrders == null) {
                declinedOrders = new HashSet<>();
            }

            List<order_table> orders = orderDAO.getAllOrder();
            order_table newOrder = null;

            if (orders != null) {
                for (order_table o : orders) {
                    String st = o.getStatus();
                    if (!declinedOrders.contains(o.getOrderID()) && 
                        (st == null || "Pending".equalsIgnoreCase(st) || "Processing".equalsIgnoreCase(st))) {
                        newOrder = o;
                        break;
                    }
                }
            }

            if (newOrder != null) {
                RestaurantDAOImp restDAO = new RestaurantDAOImp();
                Restaurant rest = restDAO.getRestaurant(newOrder.getRestaurantID());
                String restName = (rest != null) ? rest.getName() : "Restaurant #" + newOrder.getRestaurantID();
                String restAddress = (rest != null && rest.getAddress() != null) ? rest.getAddress() : "Main Kitchen Hub";

                out.print("{"
                    + "\"hasOrder\": true,"
                    + "\"orderId\": " + newOrder.getOrderID() + ","
                    + "\"userId\": " + newOrder.getUserID() + ","
                    + "\"restaurantName\": \"" + restName.replace("\"", "\\\"") + "\","
                    + "\"restaurantAddress\": \"" + restAddress.replace("\"", "\\\"") + "\","
                    + "\"totalAmount\": " + newOrder.getTotalAmount() + ","
                    + "\"paymentMethod\": \"" + (newOrder.getPaymentMethod() != null ? newOrder.getPaymentMethod() : "UPI/Card") + "\""
                    + "}");
            } else {
                out.print("{\"hasOrder\": false}");
            }
            return;
        }
        
        resp.sendRedirect("deliveryApp.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        order_tableDAOIMP orderDAO = new order_tableDAOIMP();
        HttpSession session = req.getSession();

        @SuppressWarnings("unchecked")
        Set<Integer> declinedOrders = (Set<Integer>) session.getAttribute("declinedOrders");
        if (declinedOrders == null) {
            declinedOrders = new HashSet<>();
            session.setAttribute("declinedOrders", declinedOrders);
        }

        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            if ("decline".equalsIgnoreCase(action)) {
                declinedOrders.add(orderId);
                session.setAttribute("deliveryMsg", "Order #" + orderId + " declined. Viewing remaining orders.");
            } else {
                order_table order = orderDAO.getOrder(orderId);

                if (order != null) {
                    if ("accept".equalsIgnoreCase(action) || "take".equalsIgnoreCase(action)) {
                        order.setStatus("Out for Delivery");
                        orderDAO.updateOrder(order);
                        session.setAttribute("activeOrderId", orderId);
                        declinedOrders.remove(orderId);
                        session.setAttribute("deliveryMsg", "Order #ORD-" + orderId + " TAKEN successfully! Customer details loaded below.");
                    } else if ("pickup".equalsIgnoreCase(action)) {
                        order.setStatus("Out for Delivery");
                        orderDAO.updateOrder(order);
                        session.setAttribute("deliveryMsg", "Food picked up from restaurant! On the way to customer.");
                    } else if ("deliver".equalsIgnoreCase(action)) {
                        order.setStatus("Delivered");
                        orderDAO.updateOrder(order);
                        session.removeAttribute("activeOrderId");
                        session.setAttribute("deliveryMsg", "Order #" + orderId + " marked as DELIVERED! Great job!");
                    }
                } else {
                    session.setAttribute("deliveryError", "Order #" + orderId + " not found.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("deliveryError", "Error updating order: " + e.getMessage());
        }

        resp.sendRedirect("deliveryApp.jsp");
    }
}
