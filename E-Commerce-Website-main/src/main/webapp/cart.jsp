<%@page import="com.eazydeals.entities.OrderedProduct"%>
<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.entities.Cart"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@page import="com.eazydeals.dao.OrderedProductDaoImpl"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Giỏ hàng</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
.qty {
	display: inline-block;
	padding: 3px 6px;
	width: 46px;
	height: 32px;
	border-radius: 2px;
	background-color: #fff;
	border: 1px solid #c2c2c2;
	margin: 0 5px;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<%
	int totalPrice = 0;
	CartDao cartDao = new CartDaoImpl(null);
	List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
	if (listOfCart == null || listOfCart.size() == 0) {
	%>
	<div class="container text-center py-5 px-5">
		<img src="Images/empty-cart.png" style="max-width: 250px;"
			class="img-fluid">
		<h4 class="mt-5">Giỏ hàng của bạn trống trơn!</h4>
		<p>Thêm các sản phẩm vào giỏ ngay.</p>
		<a href="products.jsp" class="btn btn-primary btn-lg" role="button"
			aria-disabled="true">Mua sắm ngay</a>
	</div>
	<%
	} else {
	%>
	
	<div class="container mt-5">
		<%@include file="Components/alert_message.jsp"%>
		<div class="card px-3 py-3">
			<table class="table table-hover">
				<thead>
					<tr class="table-primary text-center" style="font-size: 18px;">
						<th>Sản phẩm</th>
						<th>Tên Sản phẩm</th>
						<th>Giá</th>
						<th>Số lượng</th>
						<th>Tổng tiền</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
					ProductDao productDao = new ProductDaoImpl(null);
					for (Cart c : listOfCart) {
						Product prod = productDao.getProductsByProductId(c.getProductId());						
					%>
					<tr class="text-center">
						<td><img src="Product_imgs\<%=prod.getProductImages()%>"
							style="width: 50px; height: 50px; width: auto;"></td>
						<td class="text-start"><%=prod.getProductName()%></td>
						<td><%=prod.getProductPriceFormat()%></td>
						<td>
							<%if(c.getQuantity() > 1){ %>
									<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
									role="button" class="btn btn-light" id="qtyDesc"
									style="border-radius: 50%; font-size: 8px;"> 
									<i class="fa-solid fa-minus fa-2xl"></i>
									</a>
								<%}else{ %>
								<a href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=2"
								role="button" class="btn btn-light disabled" id="qtyDesc"
								style="border-radius: 50%; font-size: 8px;"> <i
									class="fa-solid fa-minus fa-2xl"></i></a>
								<%} %>
				
						<div class="qty"><%=c.getQuantity()%></div>
							<a
							href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=1"
							role="button" class="btn btn-light"
							style="border-radius: 50%; font-size: 8px;"> <i
								class="fa-regular fa-plus fa-2xl"></i>
						</a>
						</td>

						<td><%=OrderedProduct.getPriceFormat(c.getQuantity() * prod.getProductPrice())%>&ensp;</td>
						<td><a
							href="CartOperationServlet?cid=<%=c.getCartId()%>&opt=3"
							><i class="btn btn-danger text-white fa-solid fa-trash"></i></a></td>
					</tr>
					<%
					totalPrice += c.getQuantity() * prod.getProductPrice();%>&ensp;
					<%
					}
					%>
					<tr>
						<td class="text-end" colspan="8"><h4 class='pe-5'>
								Tổng cộng : 
								<%=OrderedProduct.getPriceFormat(totalPrice)%>&ensp;</h4></td>
					</tr>
				</tbody>
			</table>
			<div class="text-end">
				<a href="products.jsp" class="btn btn-outline-primary" role="button"
					aria-disabled="true">Tiếp tục mua sắm</a>&nbsp; 
					<a href="checkout.jsp" id="checkout-btn"
					class="btn btn-outline-primary" role="button" aria-disabled="true">Thanh toán</a>
			</div>

		</div>
	</div>
	<%
	}
	%>
	<script>
		$(document).ready(function(){
			$('#checkout-btn').click(function(){
			<%
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("from", "cart");
			%>	
			});
		});
	</script>
	
</body>
<%@include file="footer.jsp"%>
</html>