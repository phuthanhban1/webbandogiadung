<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Cập nhật sản phẩm</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- update product -->
	<%
	/* Integer.parseInt(request.getParameter("pid")) */
	int pid = Integer.parseInt(request.getParameter("pid"));
	ProductDao productDao = new ProductDaoImpl(null);
	Product product = productDao.getProductsByProductId(pid);
	%>
	<div class="container mt-3">
		<div class="row ">
			<div class="col">
				<div class="card">
					<div class="card-header text-center">
						<h3>Sửa sản phẩm</h3>
					</div>
					<form action="Category_ProductServlet" method="post"
						name="updateProductForm" enctype="multipart/form-data">
						<div class="card-body">
							<input type="hidden" name="operation" value="updateProduct">
							<input type="hidden" name="pid" value="<%=pid%>">
							<div class="row">
								<div class="col-md-6 mb-2">
									<label class="form-label"><b>Tên sản phẩm</b></label> <input
										type="text" name="name" value="<%=product.getProductName()%>"
										class="form-control">
								</div>
								<div class="col-md-6 mb-2">
									<label class="form-label"><b>Đơn giá</b></label> <input
										class="form-control" type="number" name="price"
										value="<%=product.getProductPrice()%>" required>
								</div>
							</div>
							<div class="mb-2">
								<label class="form-label"><b>Mô tả sản phẩm</b></label>
								<textarea class="form-control" name="description" rows="3"><%=product.getProductDescription()%></textarea>
							</div>
							<div class="row">
								<div class="col-md-6 mb-2">
									<label class="form-label"><b>Số lượng</b></label> <input
										type="number" name="quantity"
										value="<%=product.getProductQuantity()%>" class="form-control">
								</div>
							</div>
							<div class="row">
								<div class="col-md-6 mb-2">
									<label class="form-label"><b>Ảnh sản phẩm</b></label><input
										class="form-control" type="file" name="product_img">
								</div>
								<div class="col-md-6 mb-2">
									<label class="form-label"><b>Chọn kiểu danh mục</b></label> <select
										name="categoryType" class="form-control">
										<option value="0">--Chọn danh mục--</option>
										<%
										for (Category c : categoryList) {
										%>
										<option value="<%=c.getCategoryId()%>">
											<%=c.getCategoryName()%></option>
										<%
										}
										%>
									</select> <input type="hidden" name="category"
										value="<%=product.getCategoryId()%>">
								</div>
							</div>
							<div class="mb-3">
								<label class="form-label"><b>Ảnh đã tải:&nbsp;</b></label><%=product.getProductImages()%>
								&emsp;<img src="Product_imgs\<%=product.getProductImages()%>"
									style="width: 80px; height: 80px; width: auto;"> <input
									type="hidden" name="image"
									value="<%=product.getProductImages()%>">
							</div>
						</div>
						<div class="card-footer text-center">
							<button type="submit" class="btn btn-lg btn-primary me-3">Cập nhật</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- end -->

	<script type="text/javascript">
		function validate() {
			var dis = document.updateProductForm.discount.value;
			if (dis > 100 || dis < 0) {
				alert("Discount need tobe between 0-100 !");
				return false;
			}
		}
	</script>
</body>
</html>