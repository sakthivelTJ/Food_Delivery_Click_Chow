package com.tap;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;
import com.tap.daoIMP.userDAOImp;
import com.tap.model.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {

    private String normalizeRole(String roleParam) {
        if (roleParam == null) return "Customer";
        String r = roleParam.trim().toLowerCase().replace("_", "").replace(" ", "");
        if (r.equals("delivery") || r.equals("deliverypartner")) {
            return "DeliveryPartner";
        } else if (r.equals("admin") || r.equals("administrator")) {
            return "Admin";
        } else {
            return "Customer";
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        userDAOImp userDAO = new userDAOImp();

        try {
            if ("delete".equalsIgnoreCase(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                userDAO.deleteUser(userId);
                req.getSession().setAttribute("adminMsg", "User ID #" + userId + " deleted successfully.");

            } else if ("update".equalsIgnoreCase(action)) {
                int userId = Integer.parseInt(req.getParameter("userId"));
                String username = req.getParameter("user_name");
                String email = req.getParameter("email");
                String role = normalizeRole(req.getParameter("role"));
                String address = req.getParameter("address");

                user existingUser = userDAO.getUser(userId);
                if (existingUser != null) {
                    existingUser.setUser_name(username);
                    existingUser.setEmail(email);
                    existingUser.setRole(role);
                    existingUser.setAddress(address);

                    String passwordParam = req.getParameter("password");
                    if (passwordParam != null && !passwordParam.trim().isEmpty()) {
                        String hashedPassword = BCrypt.hashpw(passwordParam, BCrypt.gensalt());
                        existingUser.setPassword(hashedPassword);
                    }

                    userDAO.updateUser(existingUser);
                    req.getSession().setAttribute("adminMsg", "User '" + username + "' updated successfully.");
                } else {
                    req.getSession().setAttribute("adminError", "User not found.");
                }

            } else if ("add".equalsIgnoreCase(action)) {
                String username = req.getParameter("user_name");
                String email = req.getParameter("email");
                String rawPassword = req.getParameter("password");
                String role = normalizeRole(req.getParameter("role"));
                String address = req.getParameter("address");

                String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
                user newUser = new user(username, email, hashedPassword, role, address);

                int result = userDAO.addUser(newUser);
                if (result > 0) {
                    req.getSession().setAttribute("adminMsg", "New user '" + username + "' created successfully.");
                } else {
                    req.getSession().setAttribute("adminError", "Failed to add user.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("adminError", "Error processing user operation: " + e.getMessage());
        }

        resp.sendRedirect("adminUsers.jsp");
    }
}
