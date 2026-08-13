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
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("editProfile.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        user userObj = (user) session.getAttribute("loggedInUser");
        if (userObj == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String newPassword = req.getParameter("new_password");

        if (username != null && !username.trim().isEmpty()) {
            userObj.setUser_name(username.trim());
        }

        if (email != null && !email.trim().isEmpty()) {
            userObj.setEmail(email.trim());
        }

        if (address != null) {
            userObj.setAddress(address.trim());
        }

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            String hashpw = BCrypt.hashpw(newPassword.trim(), BCrypt.gensalt(12));
            userObj.setPassword(hashpw);
        }

        try {
            userDAOImp userDAO = new userDAOImp();
            userDAO.updateUser(userObj);

            // Synchronize updated user object in active session
            session.setAttribute("loggedInUser", userObj);
            session.setAttribute("profileSuccess", "Your profile details have been updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("profileError", "Failed to update profile. Please try again.");
        }

        resp.sendRedirect("editProfile.jsp");
    }
}
