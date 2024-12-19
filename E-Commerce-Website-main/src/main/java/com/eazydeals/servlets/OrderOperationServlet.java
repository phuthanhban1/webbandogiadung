package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
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

public class OrderOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String from = (String) session.getAttribute("from");
		Byte paymentType = Byte.parseByte(request.getParameter("payementMode"));
		User user = (User) session.getAttribute("activeUser");
		String orderId = OrderIdGenerator.getOrderId();
		Byte status = 0;

		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		
		ProductDao productDao = new ProductDaoImpl(cp);
		OrderDao orderDao = new OrderDaoImpl(cp);
		OrderedProductDao orderedProductDao = new OrderedProductDaoImpl(cp);
		
		
		if (from.trim().equals("cart")) {
			try {
				
				int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
				
				Order order = new Order(orderId, status, paymentType, user.getUserId(), totalPrice);
				
				int id = orderDao.insertOrder(order);
				if(id != 0) {
					CartDao cartDao = new CartDaoImpl(cp);
					List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
					
					for (Cart item : listOfCart) {

						Product prod = productDao.getProductsByProductId(item.getProductId());
						String prodName = prod.getProductName();
						int prodQty = item.getQuantity();
						
						String image = prod.getProductImages();
						int price = prod.getProductPrice();
						OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
						orderedProductDao.insertOrderedProduct(orderedProduct);
					}
					session.removeAttribute("from");
					session.removeAttribute("totalPrice");
					
					//removing all product from cart after successful order
					cartDao.removeAllProduct();
				} else {
					System.out.println("id đơn hàng trống");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (from.trim().equals("buy")) {
			try {
				int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
				
				int pid = (int) session.getAttribute("pid");
				System.out.println("pid = " + pid);
// thêm vào order
				System.out.println(orderId);
				System.out.println(status);
				System.out.println(paymentType);
				System.out.println(user.getUserId());
				
				Order order = new Order(orderId, status, paymentType, user.getUserId(), totalPrice);
				
				int id = orderDao.insertOrder(order);
				System.out.println("id = " + id);

		// lấy thông tin sản phẩm
				Product prod = productDao.getProductsByProductId(pid);
				
				String prodName = prod.getProductName();
				int prodQty = 1;
				int price = prod.getProductPrice();
				String image = prod.getProductImages();

		// thêm thông tin sản phẩm đã đặt
				OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
				if(orderedProductDao.insertOrderedProduct(orderedProduct)) {
					System.out.println("Them thanh cong");
				} else {
					System.out.println("Them that bai");
				}
				
				
				// trừ số lượng sản phẩm
				productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
				
				session.removeAttribute("from");
				session.removeAttribute("pid");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	    session.setAttribute("order", "success");
	    MailMessenger.successfullyOrderPlaced(user.getUserName(), user.getUserEmail(), orderId, new Date().toString());
        response.sendRedirect("index.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
