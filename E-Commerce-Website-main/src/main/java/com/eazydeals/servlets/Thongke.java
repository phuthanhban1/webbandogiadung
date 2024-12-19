package com.eazydeals.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.dao.*;
import com.eazydeals.entities.Order;

/**
 * Servlet implementation class Thongke
 */
public class Thongke extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Thongke() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		ServletContext application = getServletConfig().getServletContext();
//		// Tìm bộ quản lý kết nối
//		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
//		Set<Integer> listYear = new TreeSet<>();
//		OrderDao od = new OrderDaoImpl(cp);
//		List<Order> li = od.getOrderByStatus();
//		for(Order x : li) {
//			listYear.add(Order.getYear(x.getDate()));
//		}
		
		System.out.println(11111);
	}
	public static void main(String[] args) {
		Set<Integer> listYear = new TreeSet<>();
		OrderDao od = new OrderDaoImpl(null);
		List<Order> li = od.getOrderByStatus();
//		for(Order x : li) {
//			listYear.add(Order.getYear(x.getDate()));
//			//System.out.println(x.getDate() + " " + x.getTotalPrice());
//		}
//		for(int x : listYear) {
//			System.out.println(x);
//		}
//		List<Long> revenueYear = new ArrayList<>();
//		for(int x : listYear) {
//			revenueYear.add(od.getRevenueYear(li, x));
//		}
//		for(long x : revenueYear) {
//			System.out.println(x);
//		}
//		System.out.println(Order.listLongString(revenueYear));
//		for(int x : listYear) {
//			for(int i = 1; i < 13; i++) {
//				
//			}
//			revenueYear.add(od.getRevenueYear(li, x));
//		}
		
//		StringBuilder s = new StringBuilder();
//		s.append("{");
//		
//		for (Order x : li) {
//			listYear.add(x.getDate().getYear());
//		}
//		for(int i : listYear) {
//			s.append("\\\"" + i + "\\\"" + " : " + od.getRevenueMonth(li, i) + ", ");
//		}
//		s.delete(s.length() - 2, s.length() - 1);
//		s.append("}");
//		System.out.println(s.toString());
	}
}
