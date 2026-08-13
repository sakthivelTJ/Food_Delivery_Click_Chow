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

@WebServlet("/LoginServlet")
public class LogInServlet extends HttpServlet {

    int attemptsLeft = 3;

    public static boolean isDeliveryRole(String role) {
        if (role == null) return false;
        String r = role.toLowerCase().replace("_", "").replace(" ", "");
        return r.equals("delivery") || r.equals("deliverypartner");
    }

    public static boolean isAdminRole(String role) {
        if (role == null) return false;
        String r = role.toLowerCase();
        return r.equals("admin") || r.equals("administrator");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userParam = req.getParameter("user_name");
        String passwordParam = req.getParameter("password");
        String loginRole = req.getParameter("login_role");
        if (loginRole == null || loginRole.isEmpty()) {
            loginRole = "customer";
        }

        String msg = "";
        userDAOImp userDAO = new userDAOImp();
        user userObj = userDAO.getUserByUsername(userParam);

        if (userObj == null || userObj.getPassword() == null) {
            req.setAttribute("msg", "Invalid Username or Password.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
            return;
        }

        String realPassword = userObj.getPassword();
        String role = userObj.getRole();

        boolean isPasswordValid = false;
        try {
            isPasswordValid = BCrypt.checkpw(passwordParam, realPassword);
        } catch (Exception e) {
            isPasswordValid = passwordParam.equals(realPassword);
        }

        if (isPasswordValid) {
            HttpSession session = req.getSession();
            session.setAttribute("loggedInUser", userObj);

            if ("admin".equalsIgnoreCase(loginRole)) {
                if (isAdminRole(role)) {
                    session.setAttribute("adminUser", userObj);
                    session.setAttribute("role", "admin");
                    resp.sendRedirect("adminMenu.jsp");
                    return;
                } else {
                    req.setAttribute("msg", "Access Denied: Account does not have Admin privileges.");
                    RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
                    rd.forward(req, resp);
                    return;
                }
            } else if ("delivery".equalsIgnoreCase(loginRole)) {
                if (isDeliveryRole(role) || isAdminRole(role)) {
                    session.setAttribute("deliveryUser", userObj);
                    session.setAttribute("role", "delivery");
                    resp.sendRedirect("deliveryApp.jsp");
                    return;
                } else {
                    req.setAttribute("msg", "Access Denied: Account is not registered as a Delivery Partner.");
                    RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
                    rd.forward(req, resp);
                    return;
                }
            } else {
                resp.sendRedirect("loggedin.html");
                return;
            }
        } else if (attemptsLeft > 0) {
            msg = "Invalid Combination. You have " + attemptsLeft-- + " attempt(s) left.";
            req.setAttribute("msg", msg);
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, resp);
        } else {
            resp.sendRedirect("blocked_login.html");
        }
    }
}
