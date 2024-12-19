package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.eazydeals.dao.CategoryDao;
import com.eazydeals.dao.CategoryDaoImpl;
import com.eazydeals.dao.ProductDao;
import com.eazydeals.dao.ProductDaoImpl;
import com.eazydeals.entities.Category;
import com.eazydeals.entities.Message;
import com.eazydeals.entities.Product;
import com.eazydeals.helper.ConnectionPool;


@WebServlet("/Category_ProductServlet")
@MultipartConfig
public class Category_ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operation = request.getParameter("operation");
		
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		CategoryDao catDao = new CategoryDaoImpl(cp);
		ProductDao pdao = new ProductDaoImpl(cp);
		HttpSession session = request.getSession();
		Message message = null;
		
		// Category
		if (operation.trim().equals("category")) {
			
			List<Category> li = catDao.getAllCategories();
			session.setAttribute("category", li);
			response.sendRedirect("admin_category.jsp");
		} else if (operation.trim().equals("addCategory")) {

			String categoryName = request.getParameter("category_name");
			Part part = request.getPart("category_img");
			Category category = new Category(categoryName, part.getSubmittedFileName());
			boolean flag = catDao.saveCategory(category);

			String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
					+ part.getSubmittedFileName();

			try {
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();
				byte[] data = new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.flush();
				fos.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

			if (flag) {
				message = new Message("Thêm danh mục thành công!", "success", "alert-success");
				List<Category> li = catDao.getAllCategories();
				session.setAttribute("category", li);
			} else {
				message = new Message("Đã xảy ra lỗi!Vui lòng thử lại!", "error", "alert-danger");
			}
			session.setAttribute("message", message);
			response.sendRedirect("admin_category.jsp");

		} else if (operation.trim().equals("updateCategory")) {

			int cid = Integer.parseInt(request.getParameter("cid"));
			String name = request.getParameter("category_name");
			Part part = request.getPart("categoryimg");
			// 
			if (part.getSubmittedFileName().isEmpty()) {
				String image = request.getParameter("image");
				Category category = new Category(cid, name, image);
				catDao.updateCategory(category);
			} else {
				Category category = new Category(cid, name, part.getSubmittedFileName());
				catDao.updateCategory(category);
				String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
						+ part.getSubmittedFileName();
				try {
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();
					byte[] data = new byte[is.available()];
					is.read(data);
					fos.write(data);
					fos.flush();
					fos.close();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			message = new Message("Cập nhật danh mục thành công!", "success", "alert-success");
			session.setAttribute("message", message);
			List<Category> li = catDao.getAllCategories();
			session.setAttribute("category", li);
			response.sendRedirect("admin_category.jsp");

		} else if (operation.trim().equals("deleteCategory")) {
			int cid = Integer.parseInt(request.getParameter("cid"));
			catDao.deleteCategory(cid);
			List<Category> li = catDao.getAllCategories();
			session.setAttribute("category", li);
			response.sendRedirect("admin_category.jsp");

		} else if(operation.trim().equals("product")) {
			List<Category> licate = catDao.getAllCategories();
			session.setAttribute("category", licate);
			List<Product> li = pdao.getAllProducts();
			session.setAttribute("product", li);
			response.sendRedirect("admin_product.jsp");
		} else if (operation.trim().equals("addProduct")) {

			// add product to database
			String pName = request.getParameter("name");
			String pDesc = request.getParameter("description");
			int pPrice = Integer.parseInt(request.getParameter("price"));
//			int pDiscount = Integer.parseInt(request.getParameter("discount"));
//			if (pDiscount < 0 || pDiscount > 100) {
//				pDiscount = 0;
//			}
			int pQuantity = Integer.parseInt(request.getParameter("quantity"));
			Part part = request.getPart("photo");
			int categoryType = Integer.parseInt(request.getParameter("categoryType"));

			Product product = new Product(pName, pDesc, pPrice, pQuantity, part.getSubmittedFileName(), categoryType);
			boolean flag = pdao.saveProduct(product);

			String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
					+ part.getSubmittedFileName();
			try {
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();
				byte[] data = new byte[is.available()];
				is.read(data);
				fos.write(data);
				fos.flush();
				fos.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
			if (flag) {
				message = new Message("Thêm sản phẩm thành công!", "success", "alert-success");
			} else {
				message = new Message("Đã xảy ra lỗi!Vui lòng thử lại!", "error", "alert-danger");
			}
			session.setAttribute("message", message);
			
			List<Product> li = pdao.getAllProducts();
			session.setAttribute("product", li);
			response.sendRedirect("admin_product.jsp");

		} else if (operation.trim().equals("updateProduct")) {
			// 
			int pid = Integer.parseInt(request.getParameter("pid"));
			String name = request.getParameter("name");
			int price = Integer.parseInt(request.getParameter("price"));
			String description = request.getParameter("description");
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			Part part = request.getPart("product_img");
			int cid = Integer.parseInt(request.getParameter("categoryType"));
			if (cid == 0) {
				cid = Integer.parseInt(request.getParameter("category"));
			}
			if (part.getSubmittedFileName().isEmpty()) {
				String image = request.getParameter("image");
				Product product = new Product(pid, name, description, price, quantity, image, cid);
				pdao.updateProduct(product);
			} else {

				Product product = new Product(pid, name, description, price, quantity, part.getSubmittedFileName(), cid);
				pdao.updateProduct(product);
				// product image upload
				String path = request.getServletContext().getRealPath("/") + "Product_imgs" + File.separator
						+ part.getSubmittedFileName();
				try {
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();
					byte[] data = new byte[is.available()];
					is.read(data);
					fos.write(data);
					fos.flush();
					fos.close();

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			message = new Message("Cập nhật sản phẩm thành công!", "success", "alert-success");
			session.setAttribute("message", message);
			List<Product> li = pdao.getAllProducts();
			session.setAttribute("product", li);
			response.sendRedirect("admin_product.jsp");

		} else if (operation.trim().equals("deleteProduct")) {

			int pid = Integer.parseInt(request.getParameter("pid"));
			pdao.deleteProduct(pid);
			List<Product> li = pdao.getAllProducts();
			session.setAttribute("product", li);
			response.sendRedirect("admin_product.jsp");

		}
		return;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
}
