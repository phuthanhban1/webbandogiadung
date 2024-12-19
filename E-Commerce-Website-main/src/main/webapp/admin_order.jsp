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
<%
OrderDao orderDao = new OrderDaoImpl(null);
OrderedProductDao ordProdDao = new OrderedProductDaoImpl(null);
List<Order> orderList = orderDao.getAllOrder();
UserDao userDao = new UserDaoImpl(null);
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
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
				<h1>Đơn hàng</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">Trang chủ</li>
						<li class="breadcrumb-item active">Đơn hàng</li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->
			
		</div>
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/empty-cart.png" style="max-width: 200px;"
				class="img-fluid">
			<h4 class="mt-3">Không có đơn hàng</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover align-middle">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Sản phẩm</th>
					<th>Mã đơn hàng</th>
					<th>Chi tiết sản phẩm</th>
					<th>Địa chỉ giao hàng</th>
					<th>Ngày mua</th>
					<th>Kiểu thanh toán</th>
					<th>Trạng thái</th>
					<th>Hoạt động</th>
					<th></th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>"
					method="post">
				<tr>
					<td class="text-center"><img
						src="Product_imgs\<%=orderProduct.getImage()%>"
						style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Số lượng: <%=orderProduct.getQuantity()%><br>Tổng tiền: <%=OrderedProduct.getPriceFormat(orderProduct.getPrice() * orderProduct.getQuantity())%></td>
					<td><%=userDao.getUserName(order.getUserId())%><br>Số điện thoại: <%=userDao.getUserPhone(order.getUserId())%><br><%=userDao.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate().toString()%></td>
					<td><%=order.getPayementTypeString()%></td>
					<td><%=order.getStatusString()%></td>
					<% if(order.getStatus() == 0) {%>
					<td><select id="operation" name="status" class="form-select">
							<option value="1">Xác nhận đơn hàng</option>
							<option value="2">Đang giao</option>
							<option value="3">Đã giao</option>
					</select></td>
					<% } else if(order.getStatus() == 1) { %>
					<td><select id="operation" name="status" class="form-select">
							<option value="2">Đang giao</option>
							<option value="3">Đã giao</option>
					</select></td>
					<% } else if(order.getStatus() == 2) { %>
					<td><select id="operation" name="status" class="form-select">
							<option value="3">Đã giao</option>
					</select></td>
					<% } else if(order.getStatus() == 3) {%>
					<td><select id="operation" name="status" class="form-select">
							<option value="3">Đã giao</option>
					</select></td>
					<% } %>
					<td>
						<%
						if (order.getStatus() != 3) {
						%>
						<button type="submit" class="btn btn-primary"><i
						class="text-white bi bi-pencil-square"></i></button>
						<%
						}
						%>
					</td>
				</tr>
				</form>
				<%
				}
				}
				%>
			</table>

		</div>
		<%
		}
		%>
	</main>


	<!-- end main  -->




	

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
<script>
		var element = document.getElementById("donhang");
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