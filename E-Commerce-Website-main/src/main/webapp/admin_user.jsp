<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.dao.UserDao"%>
<%@page import="com.eazydeals.dao.UserDaoImpl"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.entities.*"%>
<%@page import="com.eazydeals.dao.*"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.entities.Message"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.eazydeals.dao.UserDao"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.dao.UserDaoImpl"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@page import="com.eazydeals.dao.OrderedProductDaoImpl"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Quản lý</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- fontawea -->


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
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<%@include file="Components/sidebar_admin.jsp"%>
	<!-- End Sidebar-->

	<!-- Begin main  -->
	<main class="main" id="main">
		<div class="row">
			<div class="pagetitle col-3">
				<h1>Tài khoản người dùng</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">Trang chủ</li>
						<li class="breadcrumb-item active">Tài khoản người dùng</li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->
		</div>
		
		<%@include file="Components/alert_message.jsp"%>
		
		<table class="table table-hover align-middle">
			<tr class="text-center table-primary" style="font-size: 18px;">
				<th>Họ và tên</th>
				<th>Email</th>
				<th>Số điện thoại</th>
				<th>Giới tính</th>
				<th>Địa chỉ</th>
				<th>Ngày đăng ký</th>

			</tr>
			<%
			UserDao userDao = new UserDaoImpl(null);
			List<User> userList = userDao.getAllUser();
			for (User u : userList) {
			%>
			<tr class="text-center">
				<td><%=u.getUserName()%></td>
				<td><%=u.getUserEmail()%></td>
				<td><%=u.getUserPhone()%></td>
				<td><%=u.getUserGender()%></td>
				<td><%=userDao.getUserAddress(u.getUserId())%></td>
				<td><%=u.getDateTime()%></td>
				<!--<td><a href="UpdateUserServlet?operation=deleteUser&uid=<%=u.getUserId()%>" ><i class="btn btn-danger text-white fa-solid fa-trash-can"></i></a></td>-->
			</tr>
			<%
			}
			%>
		</table>
	</main>

	

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
<script>
		var element = document.getElementById("nguoidung");
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