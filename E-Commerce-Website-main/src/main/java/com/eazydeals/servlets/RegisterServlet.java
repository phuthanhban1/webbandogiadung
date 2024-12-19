package com.eazydeals.servlets;

import java.io.IOException;

import com.eazydeals.dao.UserDao;
import com.eazydeals.dao.UserDaoImpl;
import com.eazydeals.entities.Message;
import com.eazydeals.entities.User;
import com.eazydeals.helper.ConnectionPool;

import com.eazydeals.helper.MailMessenger;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String userName = request.getParameter("user_name");
			String userEmail = request.getParameter("user_email");
			String userPassword = request.getParameter("user_password");
			String userPhone = request.getParameter("user_mobile_no");
			String userGender = request.getParameter("gender");
			String userAddress = request.getParameter("user_address");
			String userPincode = request.getParameter("pincode");
			ServletContext application = getServletConfig().getServletContext();
			// Tìm bộ quản lý kết nối
			ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
			User user = new User(userName, userEmail, userPassword, userPhone, userGender, userAddress, userPincode);
			UserDao userDao = new UserDaoImpl(cp);
			boolean flag = userDao.saveUser(user);

			HttpSession session = request.getSession();
			Message message;
			if (flag) {
				message = new Message("Đăng ký thành công!", "success", "alert-success");
				MailMessenger.successfullyRegister(userName, userEmail);
			} else {
				message = new Message("Đã có lỗi xảy ra!Vui lòng thử lại!", "error", "alert-danger");
			}
			session.setAttribute("message", message);
			response.sendRedirect("register.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
