<%@page import="com.eazydeals.dao.WishlistDao"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page import="com.eazydeals.dao.CategoryDao"%>
<%@page import="com.eazydeals.dao.WishlistDaoImpl"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>

<%@page import="com.eazydeals.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
User u = (User) session.getAttribute("activeUser");
WishlistDao wishlistDao = new WishlistDaoImpl(null);

String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryDao categoryDao = new CategoryDaoImpl(null);
String message = "";

ProductDao productDao = new ProductDaoImpl(null);
List<Product> prodList = null;
if (searchKey != null) {
	if (!searchKey.isEmpty()) {
		message = "Kết quả cho \"" + searchKey + "\"";
	} else {
		message = "Không tìm thấy sản phẩm nào!";
	}
	prodList = productDao.getAllProductsBySearchKey(searchKey);

} else if (catId != null && !(catId.trim().equals("0"))) {
	prodList = productDao.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
	message = "Danh mục " + categoryDao.getCategoryName(Integer.parseInt(catId.trim())) + "";
} else {
	prodList = productDao.getAllProducts();
	message = "Tất cả sản phẩm";
}

if (prodList != null && prodList.size() == 0) {

	message = "Không tìm thấy kết quả cho \""
	+ (searchKey != null ? searchKey : categoryDao.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";

	prodList = productDao.getAllProducts();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Sản phẩm</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
.real-price {
	font-size: 22px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}

.wishlist-icon {
	cursor: pointer;
	position: absolute;
	right: 10px;
	top: 10px;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	border: 1px solid #f0f0f0;
	box-shadow: 0 1px 4px 0 rgba(0, 0, 0, .1);
	padding-right: 40px;
	background: #fff;
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

.btn-primary {
	font-size: 1rem;
	font-weight: 500;
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

.card-footer {
	text-align: center;
	background-color: #ffffff;
}
</style>
</head>
<body style="background-color: #f0f0f0;">
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<!--show products-->
	<h4 class="text-center mt-2"><%=message%></h4>
	<div class="container-fluid my-3 px-5">

		<div class="row row-cols-1 row-cols-md-4 g-3">
			<%
			for (Product p : prodList) {
			%>
			<div class="col">

				<div class="card h-100">
					<img src="Product_imgs/<%=p.getProductImages()%>" class="card-img-top" alt="<%=p.getProductName()%>">
					<div class="card-body">
						<div class="wishlist-icon">
							<%
							if (u != null) {
								if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
							%>
							<button
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')"
								class="btn btn-link" type="submit">
								<i class="fa-sharp fa-solid fa-heart" style="color: #ff0303;"></i>
							</button>
							<%
							} else {
							%>
							<button type="submit"
								onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=add', '_self')"
								class="btn btn-link">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							} else {
							%>
							<button onclick="window.open('login.jsp', '_self')"
								class="btn btn-link" type="submit">
								<i class="fa-sharp fa-solid fa-heart" style="color: #909191;"></i>
							</button>
							<%
							}
							%>
						</div>
						<h5 class="card-title text-center"><%=p.getProductName()%></h5>
						<div class="text-center">
							<span class="card-price"><%=p.getProductPriceFormat()%></span>
						</div>
					</div>
					<div class="card-footer">
						<button type="button"
							onclick="window.open('viewProduct.jsp?pid=<%=p.getProductId()%>', '_self')"
							class="btn btn-primary text-white">Xem chi tiết</button>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
</body>
<%@include file="footer.jsp"%>
</html>