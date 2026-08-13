package com.tap;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Provider.Service;

import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class servLet extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String name = req.getParameter("name");
		
		PrintWriter out = resp.getWriter();
		
		out.print("welcome "+name);
		
	}
	
	
	
	
}
