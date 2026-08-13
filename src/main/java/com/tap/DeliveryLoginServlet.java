package com.tap;

import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;
import com.tap.daoIMP.userDAOImp;
import com.tap.model.user;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeliveryLoginServlet")
public class DeliveryLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String usernameInput = req.getParameter("user_name");
        String passwordInput = req.getParameter("password");

        userDAOImp userDAO = new userDAOImp();
        user userObj = userDAO.getUserByUsername(usernameInput);

        if (userObj != null && userObj.getPassword() != null) {
            boolean validPass = false;
            try {
                validPass = BCrypt.checkpw(passwordInput, userObj.getPassword());
            } catch (Exception e) {
                validPass = passwordInput.equals(userObj.getPassword());
            }

            if (validPass) {
                String role = userObj.getRole();
                if (LogInServlet.isDeliveryRole(role) || LogInServlet.isAdminRole(role)) {
                    HttpSession session = req.getSession();
                    session.setAttribute("deliveryUser", userObj);
                    session.setAttribute("role", "delivery");
                    session.setAttribute("loggedInUser", userObj);
                    resp.sendRedirect("deliveryApp.jsp");
                    return;
                } else {
                    req.setAttribute("msg", "Access Denied: Account is not registered as a Delivery Partner.");
                }
            } else {
                req.setAttribute("msg", "Invalid Username or Password.");
            }
        } else {
            req.setAttribute("msg", "Delivery Partner account not found.");
        }

        RequestDispatcher rd = req.getRequestDispatcher("deliveryLogin.jsp");
        rd.forward(req, resp);
    }
}
