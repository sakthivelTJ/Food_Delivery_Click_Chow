package com.tap;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/calculate_number")
public class register_dispatcher1 extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int p1 =Integer.parseInt( req.getParameter("number1"));
		int p2 = Integer.parseInt( req.getParameter("number2"));
		
		int sum = p1+p2;
		int product = p1*p2;
		
		PrintWriter out = resp.getWriter();
		out.print("sum :"+sum);
		
		
		req.setAttribute("product", product);
		
//		RequestDispatcher rd = req.getRequestDispatcher("display");
//		rd.include(req, resp);
		
		resp.sendRedirect("display");
	}
}
