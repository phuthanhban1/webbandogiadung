<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Registration</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
label {
	font-weight: bold;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/nav_nologin.jsp"%>

	<div class="container-fluid mt-4">
		<div class="row g-0">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body px-5">

						<div class="container text-center">
							<img src="Images/signUp.png" style="max-width: 80px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Tạo tài khoản</h3>
						<%@include file="Components/alert_message.jsp"%>

						<!--registration-form-->
						<form id="register-form" action="RegisterServlet" method="post">
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Tên của bạn</label> <input type="text"
										name="user_name" class="form-control"
										placeholder="Nhập tên của bạn" required>
								</div>
								<div class="col-md-6 mt-2">
									<label class="form-label">Email</label> <input type="email"
										name="user_email" placeholder="Địa chỉ email"
										class="form-control" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 mt-2">
									<label class="form-label">Số điện thoại</label> <input
										type="number" name="user_mobile_no"
										placeholder="Số điện thoại" class="form-control">
								</div>
								<div class="col-md-6 mt-5">
									<label class="form-label pe-3">Giới tính</label> <input
										class="form-check-input" type="radio" name="gender"
										value="Male"> <span class="form-check-label pe-3 ps-1">
										Nam </span> <input class="form-check-input" type="radio"
										name="gender" value="Female"> <span
										class="form-check-label ps-1"> Nữ </span>
								</div>
							</div>
							<div class="mt-2">
								<label class="form-label">Địa chỉ</label> <input type="text"
									name="user_address"
									placeholder="Nhập địa chỉ"
									class="form-control" required>
							</div>  
							<div class="row">
								
								<div class="col-md-12 mt-2">
									<label class="form-label">Mã pin</label> <input
										class="form-control" type="number" name="pincode"
										placeholder="Mã pin" maxlength="6" required>
								</div>  
							</div>
							<div class="row">
								
								<div class="col-md-12 mt-2">
									<label class="form-label">Mật khẩu</label> <input
										type="password" name="user_password"
										placeholder="Nhập mật khẩu" class="form-control" required>
								</div>
							</div>

							<div id="submit-btn" class="container text-center mt-4">
								<button type="submit" class="btn btn-outline-primary me-3">Xác nhận</button>
								<button type="reset" class="btn btn-outline-primary">Tải lại</button>
							</div>
							<div class="mt-3 text-center">
								<h6>
									Bạn đã có tài khoản?<a href="login.jsp"
										style="text-decoration: none"> Đăng nhập</a>
								</h6>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>