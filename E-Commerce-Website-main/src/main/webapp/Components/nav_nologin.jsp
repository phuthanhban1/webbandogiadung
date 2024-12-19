<%@page import="com.eazydeals.entities.Admin"%>
<%@page import="com.eazydeals.entities.Cart"%>
<%@page import="com.eazydeals.dao.CartDao"%>
<%@page import="com.eazydeals.entities.User"%>
<%@page import="java.util.List"%>
<%@page import="com.eazydeals.entities.Category"%>
<%@page import="com.eazydeals.helper.ConnectionPoolImpl"%>
<%@page import="com.eazydeals.dao.CategoryDaoImpl"%>
<%@page import="com.eazydeals.dao.CategoryDao"%>
<%@page import="com.eazydeals.dao.CartDaoImpl"%>
<%@page import="com.eazydeals.dao.OrderedProductDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
User user = (User) session.getAttribute("activeUser");
Admin admin = (Admin) session.getAttribute("activeAdmin");

CategoryDao catDao = new CategoryDaoImpl(null);
List<Category> categoryList = catDao.getAllCategories();
%>
<style>
.navbar {
	font-weight: 500;
}

.nav-link {
	color: rgb(255 255 255/ 100%) !important;
}

.dropdown-menu {
	background-color: #ffffff !important;
	border-color: #949494;
}

.dropdown-menu li a:hover {
	background-color: #808080 !important;
	color: white;
}
</style>
<nav class="navbar navbar-expand-lg custom-color" data-bs-theme="dark">

	<!-- for all -->
	<div class="container w-100">
		<div class="d-flex justify-content-between w-100">
			<div>
				<a class="navbar-brand" href="index.jsp">
					<i class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;GFShop
				</a>
			</div>
		
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active pe-2"><a class="nav-link"
					aria-current="page" href="register.jsp"> <i
						class="fa-solid fa-user-plus" style="color: #ffffff;"></i>&nbsp;Đăng
						ký
				</a></li>
				<li class="nav-item pe-2"><a class="nav-link"
					aria-current="page" href="login.jsp"><i
						class="fa-solid fa-user-lock" style="color: #fafafa;"></i>&nbsp;Đăng
						nhập</a></li>
				<li class="nav-item pe-2"><a class="nav-link"
					aria-current="page" href="adminlogin.jsp">&nbsp;Admin</a></li>
			</ul>
		</div>
	</div>

	<!-- end  -->
</nav>

