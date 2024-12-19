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
import com.eazydeals.dao.UserDao;
import com.eazydeals.dao.UserDaoImpl;
import com.eazydeals.entities.Admin;
import com.eazydeals.entities.Message;
import com.eazydeals.entities.User;
import com.eazydeals.helper.ConnectionPool;


public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String login = request.getParameter("login");
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		if (login.trim().equals("user")) {
			try {
				String userEmail = request.getParameter("user_email");
				String userPassword = request.getParameter("user_password");
				
				// getting user through entered email and passsword
				UserDao userDao = new UserDaoImpl(cp);
				User user = userDao.getUserByEmailPassword(userEmail, userPassword);

				// storing current user in session
				HttpSession session = request.getSession();
				if (user != null) {
					session.setAttribute("activeUser", user);
					response.sendRedirect("index.jsp");
				} else {
					Message message = new Message("Tài khoản hoặc mật khẩu sai!\nThử lại!", "error", "alert-danger");
					session.setAttribute("message", message);
					response.sendRedirect("login.jsp");
					return;
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (login.trim().equals("admin")) {
			try {
				String userName = request.getParameter("email");
				String password = request.getParameter("password");

				AdminDao adminDao = new AdminDaoImpl(cp);
				Admin admin = adminDao.getAdminByEmailPassword(userName, password);
				
				HttpSession session = request.getSession();
				if (admin != null) {
					session.setAttribute("activeAdmin", admin);
					response.sendRedirect("do_thi.jsp");
				} else {
					Message message = new Message("Tài khoản hoặc mật khẩu sai!\nThử lại!", "error", "alert-danger");
					session.setAttribute("message", message);
					response.sendRedirect("adminlogin.jsp");
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
