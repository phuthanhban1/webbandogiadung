package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.eazydeals.dao.OrderDao;
import com.eazydeals.dao.OrderDaoImpl;
import com.eazydeals.dao.UserDao;
import com.eazydeals.dao.UserDaoImpl;
import com.eazydeals.entities.Order;
import com.eazydeals.helper.ConnectionPool;

import com.eazydeals.helper.MailMessenger;

public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		OrderDao orderDao = new OrderDaoImpl(cp);
		
		int oid = Integer.parseInt(request.getParameter("oid"));
		Order od = orderDao.getOrderById(oid);
		byte status = Byte.parseByte(request.getParameter("status"));
//		if(status)
		
		orderDao.updateOrderStatus(oid, status);
		
		if (status == 2 || status == 3) {
			Order order = orderDao.getOrderById(oid);
			UserDao userDao = new UserDaoImpl(cp);
			MailMessenger.orderShipped(userDao.getUserName(order.getUserId()), userDao.getUserEmail(order.getUserId()),
					order.getOrderId(), order.getDate().toString());
		}
		response.sendRedirect("admin_order.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
