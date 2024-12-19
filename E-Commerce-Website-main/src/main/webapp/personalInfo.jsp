<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.entities.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
User user1 = (User) session.getAttribute("activeUser");
if (user1 == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;
}
%>

<style>
label {
	font-weight: bold;
}
</style>
<div class="container px-3 py-3">
	<h3>Thông tin cá nhân</h3>
	<form id="update-user" action="UpdateUserServlet" method="post">
		<input type="hidden" name="operation" value="updateUser">
		<div class="row">
			<div class="col-md-6 mt-2">
				<label class="form-label">Tên của bạn</label> <input type="text"
					name="name" class="form-control" placeholder="First and last name"
					value="<%=user1.getUserName()%>">
			</div>
			<div class="col-md-6 mt-2">
				<label class="form-label">Email</label> <input type="email"
					name="email" placeholder="Email address" class="form-control"
					value="<%=user1.getUserEmail()%>">
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 mt-2">
				<label class="form-label">Số điện thoại</label> <input type="number"
					name="mobile_no" placeholder="Mobile number" class="form-control"
					value="<%=user1.getUserPhone()%>">
			</div>
			<div class="col-md-6 mt-5">
				<label class="form-label pe-3">Giới tính</label>
				<%
				String gender = user1.getUserGender();
				if (gender.trim().equals("Male")) {
				%>
				<input class="form-check-input" type="radio" name="gender"
					value="Male" checked> <span
					class="form-check-label pe-3 ps-1"> Nam </span> <input
					class="form-check-input" type="radio" name="gender" value="Female">
				<span class="form-check-label ps-1"> Nữ </span>

				<%
				} else {
				%>
				<input class="form-check-input" type="radio" name="gender"
					value="Male"> <span class="form-check-label pe-3 ps-1">
					Nam </span> <input class="form-check-input" type="radio" name="gender"
					value="Female" checked> <span class="form-check-label ps-1">
					Nữ </span>
				<%
				}
				%>

			</div>
		</div>
		<div class="mt-2">
			<label class="form-label">Địa chỉ</label> <input type="text"
				name="address" placeholder="Nhập địa chỉ"
				class="form-control" value="<%=user1.getUserAddress()%>">
		</div>
		<div class="row">
			<div class="col-md-12 mt-2">
				<label class="form-label">Mã pin</label> <input
					class="form-control" type="number" name="pincode"
					placeholder="Mã pin" maxlength="6"
					value="<%=user1.getUserPincode()%>">
			</div>
		</div>
		
		
		<div id="submit-btn" class="container text-center mt-3">
			<button type="submit" class="btn btn-outline-primary me-3">Cập nhật</button>
			<button type="reset" class="btn btn-outline-primary">Làm mới</button>
		</div>
	</form>
</div>

















