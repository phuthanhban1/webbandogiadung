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
import com.eazydeals.entities.Cart;
import com.eazydeals.entities.Message;
import com.eazydeals.helper.ConnectionPool;


public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int uid = Integer.parseInt(req.getParameter("uid"));
		int pid = Integer.parseInt(req.getParameter("pid"));
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		CartDao cartDao = new CartDaoImpl(cp);
		int qty = cartDao.getQuantity(uid, pid);
		HttpSession session = req.getSession();
		Message message = null;
		
		if (qty == 0) {
			Cart cart = new Cart(uid, pid, qty + 1);
			cartDao.addToCart(cart);
			message = new Message("Sản phẩm được thêm vào giỏ hàng thành công!", "success", "alert-success");
			
		}else {
			int cid = cartDao.getIdByUserIdAndProductId(uid, pid);
			cartDao.updateQuantity(cid, qty+1);
			message = new Message("Số lượng sản phẩm đã được tăng lên!", "success", "alert-success");
		}
		//updating quantity of product in database
		ProductDao productDao = new ProductDaoImpl(cp);
		productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
		session.setAttribute("message", message);
		resp.sendRedirect("viewProduct.jsp?pid="+pid);
	}

}
