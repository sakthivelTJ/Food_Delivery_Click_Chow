package com.tap;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/login")
public class cookie_servlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("user_name");
		String password = req.getParameter("password");
		
		Cookie cd1 = new Cookie("name", name);
		Cookie cd2 = new Cookie("password", password);
		
		resp.addCookie(cd1);
		resp.addCookie(cd2);
		
		Cookie[] cookies = req.getCookies();
		
		for( Cookie x :cookies) {
			System.out.println("name "+x.getName()+" password"+x.getValue());
		}
		
		
		
	}
	
}
