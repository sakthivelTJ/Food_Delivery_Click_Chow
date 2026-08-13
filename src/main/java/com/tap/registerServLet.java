package com.tap;

import java.io.IOException;

import java.io.PrintWriter;

import org.mindrot.jbcrypt.BCrypt;

import com.mysql.cj.Session;
import com.tap.daoIMP.userDAOImp;
import com.tap.model.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RegisterServlet")
public class registerServLet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String username = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		String role = req.getParameter("role");
		String address = req.getParameter("address");
		
		String hashpw = BCrypt.hashpw(password, BCrypt.gensalt(12));
		
		user user = new user(username, email, hashpw, role,address);
		
		userDAOImp userDAOImp = new userDAOImp();
		int res = userDAOImp.addUser(user);
		
		HttpSession session = req.getSession();
		session.setAttribute("username", username);

		
		
		
		
//		PrintWriter out = resp.getWriter();
//		out.print("Welcome , "+username);
		
	
		
		
		if(res>0) {
			
			resp.sendRedirect("registerSuccessful.jsp");
		}
		else {
			resp.sendRedirect("register.html");
		}
		
		
	}
	
}
