package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.eazydeals.dao.AdminDao;
import com.eazydeals.dao.AdminDaoImpl;
import com.eazydeals.entities.Admin;
import com.eazydeals.entities.Message;
import com.eazydeals.helper.ConnectionPool;

public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String operation = request.getParameter("operation");
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		AdminDao adminDao = new AdminDaoImpl(cp);
		HttpSession session = request.getSession();
		Message message = null;
		if(operation.trim() != null) {
			if(operation.trim().equals("save")) {
				
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String phone = request.getParameter("phone");
				
				Admin admin = new Admin(name, email, phone, password);
				boolean flag = adminDao.saveAdmin(admin);

				if(flag) {
					message = new Message("Đăng ký tài khoản quản trị mới thành công!", "success", "alert-success");
				}else {
					message = new Message("Xin lỗi! Đã xảy ra lỗi", "error", "alert-danger");
				}
				

			}else if(operation.trim().equals("delete")) {
				
				int id = Integer.parseInt(request.getParameter("id"));
				boolean flag = adminDao.deleteAdmin(id);
				if(flag) {
					message = new Message("Admin deleted successfully!", "success", "alert-success");
				}else {
					message = new Message("Sorry! Something went wrong", "error", "alert-danger");
				}
			}
			session.setAttribute("message", message);
			response.sendRedirect("admin_add.jsp");
		}
		
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
