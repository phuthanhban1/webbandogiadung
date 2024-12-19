<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
ProductDao productDao = new ProductDaoImpl(null);
List<Product> productList = productDao.getAllLatestProducts();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.cus-card {
	border-radius: 50%;
	border-color: transparent;
	max-height: 200px;
	max-width: 200px;
	max-height: 200px;
}

.card-title {
	font-size: 1.1rem;
	font-weight: 500;
	margin: 0.5rem 0;
}

.card-price {
	font-size: 1rem;
	font-weight: 700;
	color: #333;
}


.container-fluid {
	background-color: #f0f0f0;
}

.card {
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.card-img-top {
	object-fit: contain;
	height: 200px;
	width: 100%;
}

.card-body {
	padding: 15px;
	flex: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!-- Category list -->
	<div class="container-fluid px-3 py-3"
		style="background-color: #e3f7fc;">
		<div class="row">
			<div class="card-group">
				<%
				for (Category c : categoryList) {
				%>
				<div class="col text-center">
					<a href="products.jsp?category=<%=c.getCategoryId()%>"
						style="text-decoration: none;">
						<div class="card cus-card h-100">
							<div class="container text-center">
								<img src="Product_imgs\<%=c.getCategoryImage()%>" class="mt-3 "
									style="max-width: 100%; max-height: 100px; width: auto; height: auto;">
							</div>
							<h6><%=c.getCategoryName()%></h6>
						</div>
					</a>
				</div>

				<%
				}
				%>
			</div>
		</div>
	</div>
	<!-- end of list -->

	<!-- Carousel -->
	<div id="carouselAutoplaying"
		class="carousel slide carousel-dark mt-3 mb-3" data-bs-ride="carousel">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="Images/scroll_img2.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/scroll_img1.png" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="Images/scroll_img3.png" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"
				style="color: black;"></span> <span class="visually-hidden">Trước</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselAutoplaying" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Sau</span>
		</button>
	</div>
	<!-- end of carousel -->

	<!-- latest product listed -->
	<div class="container-fluid py-3 px-3" style="background: #f2f2f2;">
		<div class="row row-cols-1 row-cols-md-4 g-3">
			<div class="col">
				<div class="container text-center px-5 py-5">
					<h1>Sản phẩm mới nhất</h1>
					<img src="Images\product.png" class="card-img-top"
						style="max-width: 100%; max-height: 200px; width: auto;">
				</div>
			</div>
			<%
			for (int i = 0; i < Math.min(3, productList.size()); i++) {
			%>
			<div class="col">
				<a href="viewProduct.jsp?pid=<%=productList.get(i).getProductId()%>"
					style="text-decoration: none;">
					<div class="card h-70">
					<img src="Product_imgs/<%=productList.get(i).getProductImages()%>" class="card-img-top" alt="<%=productList.get(i).getProductName()%>">
						<div class="card-body">
							<h5 class="card-title text-center"><%=productList.get(i).getProductName()%></h5>
						 <div class="text-center">
								<span class="card-price"><%= productList.get(i).getProductPriceFormat()%></span>
							</div> 
						</div>
					</div>
				</a>
			</div>

			<%
			}
			%>
		</div>
	</div>
	<!-- end of list -->

	<!-- confirmation message for successful order -->
	<%
	String order = (String) session.getAttribute("order");
	if (order != null) {
	%>
	<script type="text/javascript">
		console.log("testing..4...");
		Swal.fire({
		  icon : 'success',
		  title: 'Đặt hàng thành công\nCảm ơn bạn!',
		  text: 'Xác nhận sẽ được gửi tới <%=user.getUserEmail()%>',
		  width: 600,
		  padding: '3em',
		  showConfirmButton : false,
		  timer : 3500,
		  backdrop: `
		    rgba(0,0,123,0.4)
		  `
		});
	</script>
	<%
	}
	session.removeAttribute("order");
	%>
	<!-- end of message -->
	
</body>
<%@include file="footer.jsp"%>
</html>