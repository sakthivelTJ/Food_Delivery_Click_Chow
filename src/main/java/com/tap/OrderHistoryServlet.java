package com.tap;

import java.io.IOException;
import java.util.List;

import com.tap.daoIMP.order_tableDAOIMP;
import com.tap.model.order_table;
import com.tap.model.user;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/orderHistory", "/OrderHistoryServlet"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        user loggedUser = (user) session.getAttribute("loggedInUser");
        int userId = loggedUser.getUser_id();

        try {
            order_tableDAOIMP orderDAO = new order_tableDAOIMP();
            List<order_table> userOrders = orderDAO.getOrdersByUserId(userId);
            req.setAttribute("userOrders", userOrders);
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = req.getRequestDispatcher("orderHistory.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
