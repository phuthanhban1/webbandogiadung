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
List<Category> categoryList = (List<Category>) session.getAttribute("category");
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
		<div class="row">
			<div class="pagetitle col-3">
				<h1>Danh mục</h1>
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item">Trang chủ</li>
						<li class="breadcrumb-item active">Danh mục</li>
					</ol>
				</nav>
			</div>
			<!-- End Page Title -->
			<div class="col-9">
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#add-category">
					<i class="fa-solid fa-plus fa-xs"></i>Thêm danh mục
				</button>
				</li>
				<!-- <button class="btn btn-primary">Thêm</button> -->
			</div>
		</div>
		<!-- add category modal-->
		<div class="modal fade" id="add-category" tabindex="-1"
			aria-labelledby="addCategoryModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5" id="addCategoryModalLabel">Thêm
							Danh mục</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Đóng"></button>
					</div>
					<form action="Category_ProductServlet" method="post" enctype="multipart/form-data">
						<div class="modal-body">
							<input type="hidden" name="operation" value="addCategory">

							<div class="mb-3">
								<label class="form-label"><b>Tên Danh mục</b></label> <input
									type="text" name="category_name"
									placeholder="Nhập tên Danh mục" class="form-control" required>
							</div>
							<div class="mb-3">
								<label for="formFile" class="form-label"><b>Ảnh Danh
										mục</b></label> <input class="form-control" type="file"
									name="category_img" id="formFile">
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary me-3">Thêm
								Danh mục</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- end of modal -->
		<!-- Body category-->
		<div class="col-12 mt-3">
			<%@include file="Components/alert_message.jsp"%>
			<table class="table table-hover align-middle">
				<tr class="table-primary text-center" style="font-size: 20px;">
					<th>Hình ảnh</th>
					<th>Tên danh mục</th>
					<th>Hành động</th>
				</tr>
				<%
				for (Category c : categoryList) {
				%>
				<tr class="text-center">
					<td><img src="Product_imgs\<%=c.getCategoryImage()%>"
						style="width: 60px; height: 60px; width: auto;"></td>
					<td><%=c.getCategoryName()%></td>
					<td><a href="update_category.jsp?cid=<%=c.getCategoryId()%>">
							<i class="btn btn-primary text-white bi bi-pencil-square"></i>
					</a>&emsp; <a
						href="Category_ProductServlet?cid=<%=c.getCategoryId()%>&operation=deleteCategory">
							<i class="btn btn-danger text-white bi bi-trash"></i>
					</a></td>
				</tr>
				<%
				}
				%>
			</table>
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