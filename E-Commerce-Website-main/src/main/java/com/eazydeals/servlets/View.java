package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.eazydeals.dao.CartDao;
import com.eazydeals.dao.CartDaoImpl;
import com.eazydeals.dao.OrderDao;
import com.eazydeals.dao.OrderDaoImpl;
import com.eazydeals.dao.OrderedProductDao;
import com.eazydeals.dao.OrderedProductDaoImpl;
import com.eazydeals.dao.ProductDao;
import com.eazydeals.dao.ProductDaoImpl;
import com.eazydeals.entities.Cart;
import com.eazydeals.entities.Order;
import com.eazydeals.entities.OrderedProduct;
import com.eazydeals.entities.Product;
import com.eazydeals.entities.User;
import com.eazydeals.helper.ConnectionPool;
import com.eazydeals.helper.MailMessenger;
import com.eazydeals.helper.OrderIdGenerator;

/**
 * Servlet implementation class View
 */
public class View extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public View() {
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

		String operation = request.getParameter("operation");
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		if (operation.trim().equals("viewOrder")) {
			response.sendRedirect("admin_order.jsp");
		} 
	}

}
