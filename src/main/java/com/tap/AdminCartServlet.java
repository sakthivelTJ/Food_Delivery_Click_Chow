package com.tap;

import java.io.IOException;
import com.tap.daoIMP.order_tableDAOIMP;
import com.tap.model.order_table;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminCartServlet")
public class AdminCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        order_tableDAOIMP orderDAO = new order_tableDAOIMP();

        try {
            if ("updateStatus".equalsIgnoreCase(action)) {
                int orderId = Integer.parseInt(req.getParameter("orderId"));
                String newStatus = req.getParameter("status");
                
                order_table order = orderDAO.getOrder(orderId);
                if (order != null) {
                    order.setStatus(newStatus);
                    orderDAO.updateOrder(order);
                    req.getSession().setAttribute("adminMsg", "Order #" + orderId + " status updated to " + newStatus);
                }
            } else if ("deleteOrder".equalsIgnoreCase(action)) {
                int orderId = Integer.parseInt(req.getParameter("orderId"));
                orderDAO.deleteOrder(orderId);
                req.getSession().setAttribute("adminMsg", "Order #" + orderId + " removed from records.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError", "Failed to update order: " + e.getMessage());
        }

        resp.sendRedirect("adminCart.jsp");
    }
}
