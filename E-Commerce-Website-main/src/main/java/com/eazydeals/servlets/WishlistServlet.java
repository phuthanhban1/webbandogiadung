package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

import com.eazydeals.dao.OrderDao;
import com.eazydeals.dao.OrderedProductDao;
import com.eazydeals.dao.ProductDao;
import com.eazydeals.dao.WishlistDao;
import com.eazydeals.dao.WishlistDaoImpl;
import com.eazydeals.entities.Order;
import com.eazydeals.entities.OrderedProduct;
import com.eazydeals.entities.Product;
import com.eazydeals.entities.Wishlist;
import com.eazydeals.helper.ConnectionPool;

import com.eazydeals.helper.MailMessenger;
import com.eazydeals.helper.OrderIdGenerator;

public class WishlistServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int uid = Integer.parseInt(request.getParameter("uid"));
		int pid = Integer.parseInt(request.getParameter("pid"));
		String op = request.getParameter("op");
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		WishlistDao wishlistDao = new WishlistDaoImpl(cp);
		if (op.trim().equals("add")) {
			Wishlist wishlist = new Wishlist(uid, pid);
			wishlistDao.addToWishlist(wishlist);
			response.sendRedirect("products.jsp");
		} else if (op.trim().equals("remove")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect("products.jsp");
		}else if(op.trim().equals("delete")) {
			wishlistDao.deleteWishlist(uid, pid);
			response.sendRedirect("profile.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
