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
List<Category> categoryList = (List<Category>) session.getAttribute("category");
UserDao userDao = new UserDaoImpl(null);
ProductDao productDao = new ProductDaoImpl(null);
CategoryDao catDao = new CategoryDaoImpl(null);
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
				<h1>Danh mục</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">Trang chủ</li>
						<li class="breadcrumb-item active">Sản phẩm</li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->
			<div class="col-9">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal"
					data-bs-target="#add-product">
					<i class="fa-solid fa-plus fa-xs"></i>Thêm sản phẩm
				</button>


			</div>
		</div>

		<%@include file="Components/alert_message.jsp"%>
		<table class="table table-hover">
			<tr class="table-primary text-center" style="font-size: 20px;">
				<th>Ảnh</th>
				<th>Tên</th>
				<th class="text-start">Danh mục</th>
				<th>Price</th>
				<th class="text-start">Số lượng</th>
				<th>Hoạt động</th>
			</tr>
			<%
			List<Product> productList = productDao.getAllProducts();
			for (Product prod : productList) {
				String category = catDao.getCategoryName(prod.getCategoryId());
			%>
			<tr class="text-center">
				<td><img src="Product_imgs\<%=prod.getProductImages()%>"
					style="width: 60px; height: 60px; width: auto;"></td>
				<td class="text-start"><%=prod.getProductName()%></td>
				<td><%=category%></td>
				<td><%=prod.getProductPriceFormat()%></td>
				<td><%=prod.getProductQuantity()%></td>
				<td><a href="update_product.jsp?pid=<%=prod.getProductId()%>"><i
						class="btn btn-primary text-white bi bi-pencil-square"></i></a>&emsp;<a
					href="Category_ProductServlet?pid=<%=prod.getProductId()%>&operation=deleteProduct"><i
						class="btn btn-danger text-white bi bi-trash"></i></a></td>
			</tr>
			<%
			}
			%>
		</table>
	</main>

	<!-- add product modal-->
	<div class="modal fade" id="add-product" tabindex="-1"
		aria-labelledby="addProductModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="addProductModalLabel">Thêm
						Sản phẩm</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Đóng"></button>
				</div>
				<form action="Category_ProductServlet" method="post"
					name="addProductForm" enctype="multipart/form-data">
					<div class="modal-body">
						<input type="hidden" name="operation" value="addProduct">
						<div>
							<label class="form-label"><b>Tên Sản phẩm</b></label> <input
								type="text" name="name" placeholder="Nhập tên Sản phẩm"
								class="form-control" required>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Mô tả Sản phẩm</b></label>
							<textarea class="form-control" name="description" rows="4"
								placeholder="Nhập mô tả sản phẩm"></textarea>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Giá</b></label> <input
									type="number" name="price" placeholder="Nhập giá"
									class="form-control" required>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Số lượng sản phẩm</b></label> <input
									type="number" name="quantity"
									placeholder="Nhập số lượng sản phẩm" class="form-control">
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label"><b>Lựa chọn Danh mục</b></label> <select
									name="categoryType" class="form-control">
									<option value="0">--Chọn Danh mục--</option>
									<%
									for (Category c : categoryList) {
									%>
									<option value="<%=c.getCategoryId()%>">
										<%=c.getCategoryName()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
						<div class="mb-2">
							<label class="form-label"><b>Ảnh Sản phẩm</b></label> <input
								type="file" name="photo" class="form-control" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary me-3">Thêm
							Sản phẩm</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- END product modal -->
	<!-- end main  -->






	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
	<script>
		var element = document.getElementById("sanpham");
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