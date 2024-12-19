package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.eazydeals.dao.CartDao;
import com.eazydeals.dao.CartDaoImpl;
import com.eazydeals.dao.ProductDao;
import com.eazydeals.dao.ProductDaoImpl;
import com.eazydeals.entities.Message;
import com.eazydeals.helper.ConnectionPool;


public class CartOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		CartDao cartDao = new CartDaoImpl(cp);
		ProductDao productDao = new ProductDaoImpl(cp);
		int cid =Integer.parseInt(request.getParameter("cid"));
		int opt =Integer.parseInt(request.getParameter("opt"));
		
		int qty = cartDao.getQuantityById(cid);
		int pid = cartDao.getProductId(cid);
		int quantity = productDao.getProductQuantityById(pid);	
		
		if(opt == 1) {
			if(quantity > 0) {
				cartDao.updateQuantity(cid, qty+1);
				//updating(decreasing) quantity of product in database
				productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
				response.sendRedirect("cart.jsp");
				
			}else {
				HttpSession session = request.getSession();
				Message message = new Message("Sản phẩm đã hết hàng!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("cart.jsp");
			}
			
		}else if(opt == 2) {
			cartDao.updateQuantity(cid, qty-1);
			
			//updating(increasing) quantity of product in database
			productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) + 1);
			response.sendRedirect("cart.jsp");
			
		}else if(opt == 3) {
			cartDao.removeProduct(cid);
			HttpSession session = request.getSession();
			Message message = new Message("Sản phẩm đã bị xóa khỏi giỏ hàng!", "success", "alert-success");
			session.setAttribute("message", message);
			
			//updating quantity of product in database
			//adding all the product qty back to database
			productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) + qty);
			response.sendRedirect("cart.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
