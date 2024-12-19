package com.eazydeals.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;
import com.eazydeals.dao.UserDao;
import com.eazydeals.dao.UserDaoImpl;
import com.eazydeals.entities.Message;
import com.eazydeals.helper.ConnectionPool;

import com.eazydeals.helper.MailMessenger;

public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String referrer = request.getHeader("referer");
		ServletContext application = getServletConfig().getServletContext();
		// Tìm bộ quản lý kết nối
		ConnectionPool cp = (ConnectionPool)application.getAttribute("CPool");
		UserDao userDao = new UserDaoImpl(cp);
		HttpSession session = request.getSession();
		
		if(referrer.contains("forgot_password")) {
			String email = request.getParameter("email").trim();
			List<String> list = userDao.getAllEmail();
			if(list.contains(email)) {
				Random rand = new Random();
				int max = 99999, min = 10000;
				int otp = rand.nextInt(max - min + 1) + min;
				//System.out.println(otp);
				session.setAttribute("otp", otp);
				session.setAttribute("email", email);
				MailMessenger.sendOtp(email, otp);
				
				Message message = new Message("Chúng tôi đã gửi mã đặt lại mật khẩu tới "+email, "success", "alert-success");
				session.setAttribute("message", message);
				response.sendRedirect("otp_code.jsp");
			}else {
				Message message = new Message("Không tìm thấy email! Hãy thử với một email khác!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("forgot_password.jsp");
				return;
			}
		}else if(referrer.contains("otp_code")) {
			int code = Integer.parseInt(request.getParameter("code"));
			int otp = (int)session.getAttribute("otp");
			if(code == otp) {
				session.removeAttribute("otp");
				response.sendRedirect("change_password.jsp");
			}else {
				Message message = new Message("Mã xác minh không hợp lệ!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("otp_code.jsp");
				return;
			}
		}else if(referrer.contains("change_password")) {
			String password = request.getParameter("password");
			String email =(String)session.getAttribute("email");
			userDao.updateUserPasswordByEmail(password, email);
			session.removeAttribute("email");
			
			Message message = new Message("Cập nhật mật khẩu thành công", "error", "alert-success");
			session.setAttribute("message", message);
			response.sendRedirect("login.jsp");
		}
	}

}
