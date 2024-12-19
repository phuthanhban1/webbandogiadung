<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.entities.*"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.dao.*"%>
<!DOCTYPE html>
<html lang="en">
<%

%>
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Quản lý</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->


<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="vendor/quill/quill.snow.css" rel="stylesheet">
<link href="vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="vendor/simple-datatables/style.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="CSS/style_admin.css" rel="stylesheet">


</head>

<body>

	<!-- ======= Header ======= -->
	<%@include file="Components/header_admin.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@include file="Components/sidebar_admin.jsp"%>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<div class="d-flex justify-content-center">
			<div class="col-md-4">
				<div class="card">
					<div class="card-body px-3">
						<div class="container text-center">
							<img src="Images/admin.png" style="max-width: 100px;"
								class="img-fluid">
						</div>
						<h3 class="text-center">Thêm Admin</h3>
						<%@include file="Components/alert_message.jsp"%>

						<!--admin-form-->
						<form action="AdminServlet?operation=save" method="post">
							<div class="mb-3">
								<label class="form-label">Tên</label> <input type="text"
									name="name" placeholder="Nhập tên" class="form-control"
									required>
							</div>
							<div class="mb-3">
								<label class="form-label">Email</label> <input type="email"
									name="email" placeholder="Địa chỉ email" class="form-control"
									required>
							</div>
							<div class="mb-3">
								<label class="form-label">Mật khẩu</label> <input
									type="password" name="password" placeholder="Nhập mật khẩu"
									class="form-control" required>
							</div>
							<div class="mb-3">
								<label class="form-label">Điện thoại</label> <input type="number"
									name="phone" placeholder="Số điện thoại"
									class="form-control" required>
							</div>
							<div class="d-grid gap-2 col-6 mx-auto py-3">
								<button type="submit" class="btn btn-primary me-3">Đăng ký</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
	<!-- End #main -->



	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<script>
		var element = document.getElementById("danhmuc");
		element.classList.remove("collapsed");
	</script>
	<!-- Vendor JS Files -->
	<script src="vendor/apexcharts/apexcharts.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/chart.js/chart.umd.js"></script>
	<script src="vendor/echarts/echarts.min.js"></script>
	<script src="vendor/quill/quill.js"></script>
	<script src="vendor/simple-datatables/simple-datatables.js"></script>
	<script src="vendor/tinymce/tinymce.min.js"></script>
	<script src="vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->


</body>

</html>