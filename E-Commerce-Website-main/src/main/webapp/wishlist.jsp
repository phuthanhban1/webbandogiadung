<%@page import="com.eazydeals.entities.Message"%>
<%@page import="com.eazydeals.entities.Product"%>
<%@page import="com.eazydeals.dao.ProductDao"%>
<%@page import="com.eazydeals.entities.Wishlist"%>
<%@page import="java.util.List"%>
<%@page errorPage="error_exception.jsp"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.dao.WishlistDao"%>

<%@page import="com.eazydeals.dao.WishlistDaoImpl"%>
<%@page import="com.eazydeals.dao.ProductDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
User u1 = (User) session.getAttribute("activeUser");
if (u1 == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
WishlistDao wishListDao = new WishlistDaoImpl(null);
List<Wishlist> wlist = wishListDao.getListByUserId(u1.getUserId());
ProductDao pDao = new ProductDaoImpl(null);
%>
<div class="container px-3 py-3">
	<%
	if (wlist == null || wlist.size() == 0) {
	%>
	<div class="container mt-5 mb-5 text-center">
		<img src="Images/wishlist.png" style="max-width: 200px;"
			class="img-fluid">
		<h4 class="mt-3">Danh sách yêu thích trống</h4>
		Bạn không có sản phẩm yêu thích. Bắt đầu thêm ngay!
	</div>
	<%
	} else {
	%>
	<h4>
		Danh sách yêu thích của tôi (<%=wlist.size()%>)
	</h4>
	<hr>
	<div class="container">
		<table class="table table-hover">
			<%
			for (Wishlist w : wlist) {
				Product p = pDao.getProductsByProductId(w.getProductId());
			%>
			<tr class="text-center">
				<td><img src="Product_imgs\<%=p.getProductImages()%>"
					style="width: 50px; height: 50px; width: auto;"></td>
				<td class="text-start"><%=p.getProductName()%></td>
				<td><%=p.getProductPriceFormat()%></td>
				<!-- <td><a
					href="OrderOperationServlet?uid=<%=u1.getUserId()%>&pid=<%=p.getProductId()%>&op=buy"
					><i class="btn btn-primary text-white fa-solid fa-money-bill"></i></a></td> -->
				<td><a
					href="WishlistServlet?uid=<%=u1.getUserId()%>&pid=<%=p.getProductId()%>&op=delete"
					><i class="btn btn-danger text-white fa-solid fa-trash"></i></a></td>
			</tr>
			<%
			}
			%>
		</table>
	</div>
	<%
	}
	%>
</div>
