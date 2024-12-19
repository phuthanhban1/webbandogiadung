<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@page import="com.eazydeals.dao.OrderedProductDaoImpl"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.entities.*"%>
<%@page errorPage="error_exception.jsp"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("Bạn cần đăng nhập trước!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
String from = (String)session.getAttribute("from");
int totalPriceOrder = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thanh toán</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container mt-5" style="font-size: 17px;">
		<div class="row">
			<!-- right column -->
			<div class="col-md-4">
				<div class="card">
					<div class="container px-3 py-3">
						<h4>Thành tiền</h4>
						<hr>
						<%
						if (from.trim().equals("cart")) {
							CartDao cartDao = new CartDaoImpl(null);
							int totalProduct = cartDao.getCartCountByUserId(user.getUserId());
							int totalPrice = (int) session.getAttribute("totalPrice");
							/* session.setAttribute("totalPrice", totalPrice + 40000); */
						%>
						<form action="OrderOperationServlet" method="post">
							<input class="form-control mt-3" type="number" placeholder="Nhập số thẻ" name="cardno">
						</form>
						<table class="table table-borderless">
							<tr>
								<td>Tổng sản phẩm</td>
								<td><%=totalProduct%></td>
							</tr>
							<tr>
								<td>Tổng tiền</td>
								<td> <%= Product.formatMoney(totalPrice) %> </td>
							</tr>
							<tr>
								<td>Phí giao hàng</td>
								<td>30.000 ₫</td>
							</tr>
							<tr>
								<td>Phí đóng gói</td>
								<td>10.000 ₫</td>
							</tr>
							<tr>
								<td><h5>Số tiền phải trả :</h5></td>
								<td><h5> <%= Product.formatMoney(totalPrice + 40000) %> </h5></td>
								<% totalPriceOrder = totalPrice + 40000; %>
							</tr>
						</table>
						<%
						} else {
							ProductDao productDao = new ProductDaoImpl(null);
							int pid = (int) session.getAttribute("pid");
							int price = productDao.getProductPriceById(pid);
						%>
						<table class="table table-borderless">
							<tr>
								<td>Tổng sản phẩm</td>
								<td>1</td>
							</tr>
							<tr>
								<td>Tổng tiền</td>
								<td><%=Product.formatMoney(price)%> </td>
							</tr>
							<tr>
								<td>Phí giao hàng</td>
								<td>30.000 ₫</td>
							</tr>
							<tr>
								<td>Phí đóng gói</td>
								<td>10 000 ₫</td>
							</tr>
							<tr>
								<td><h5>Số tiền phải trả: </h5></td>
								<td><h5><%= Product.formatMoney(price + 40000) %> </h5></td>
								<% totalPriceOrder = price + 40000; %>
							</tr>
						</table>
						<%
						}
						%>
					</div>
				</div>
			</div>
			<!-- left column -->
			<div class="col-md-8">
				<div class="card">
					<div class="container px-3 py-3">
						<div class="card">
							<div class="container-fluid text-white"
								style="background-color: #389aeb;">
								<h4>Địa chỉ giao hàng</h4>
							</div>
						</div>
						<div class="mt-3 mb-3">
							<h5><%=user.getUserName()%>
								&nbsp;
								<%=user.getUserPhone()%></h5>
							<%
							StringBuilder str = new StringBuilder();
							str.append(user.getUserAddress());
							out.println(str);
							%>
							<br>
							<div class="text-end">
								<button type="button" class="btn btn-outline-primary"
									data-bs-toggle="modal" data-bs-target="#exampleModal">
									Thay đổi Địa chỉ</button>
							</div>
						</div>
						<hr>
						<div class="card">
							<div class="container-fluid text-white"
								style="background-color: #389aeb;">
								<h4>Lựa chọn Thanh toán</h4>
							</div>
						</div>
						<form action="OrderOperationServlet" method="post">
							<div class="form-check mt-2">
								<input class="form-check-input" type="radio" name="payementMode"
									value="1" required><label class="form-check-label">Thẻ tín dụng
									/Thẻ ghi nợ /Thẻ ATM</label><br>
								<div class="mb-3">

									<input class="form-control mt-3" type="number"
										placeholder="Nhập số thẻ" name="cardno">
									<div class="row gx-5">
										<div class="col mt-3">
											<input class="form-control" type="number"
												placeholder="Nhập CVV" name="cvv">
										</div>
										<div class="col mt-3">
											<input class="form-control" type="text"
												placeholder="Có hiệu lực đến '07/23'">
										</div>
									</div>
									<input class="form-control mt-3" type="text"
										placeholder="Nhập tên chủ thẻ" name="name">
								</div>
								<input class="form-check-input" type="radio" name="payementMode"
									value="0"><label
									class="form-check-label">Thanh toán khi nhận hàng</label>
							</div>
							<input type="hidden" name="totalPrice" value="<%= totalPriceOrder%>">
							<div class="text-end">
								<button type="submit"
									class="btn btn-lg btn-outline-primary mt-3">Đặt hàng</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- end of column -->

			
			<!-- end of column -->
		</div>
	</div>


	<!--Change Address Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Thay đổi địa chỉ</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<form action="UpdateUserServlet" method="post">
					<input type="hidden" name="operation" value="changeAddress">
					<div class="modal-body mx-3">
						<div class="mt-2">
							<label class="form-label fw-bold">Địa chỉ</label>
							<textarea name="user_address" rows="3"
								placeholder="Nhập địa chỉ"
								class="form-control" required></textarea>
						</div>
						<div class="mt-2">
						</div>
						<div class="mt-2">
							<label class="form-label fw-bold">Mã PIN</label> <input
								class="form-control" type="number" name="pincode"
								placeholder="Nhập mã PIN" maxlength="6" required>
						</div>
						<div class="mt-2">
							
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Đóng</button>
						<button type="submit" class="btn btn-primary">Lưu</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- end modal -->

</body>
<%@include file="footer.jsp"%>
</html>