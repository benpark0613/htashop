<%@page import="com.shop.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 클릭한 메뉴만 활성화되도록
	String menu = (String)pageContext.getAttribute("menu");

	// 로그인 전: [로그인, 조인,] 카트, 오더, 마이샵
	// 로그인 후: [로그아웃, 모디파이,] 카트, 오더, 마이샵
	Customer loginedCustomerInfo  = (Customer)session.getAttribute("logined_customer_info");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
		<button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbar-1">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbar-1">
			<ul class="navbar-nav mr-auto mb-2 mb-lg-0">
				<li class="nav-item"><a href="/htashop/index.jsp" class="nav-link <%="home".equals(menu) ? "active" : "" %>">HOME</a></li>
			</ul>
			<ul class="navbar-nav mx-auto mb-2 mb-lg-0">
<%
	if (loginedCustomerInfo == null) {
%>
				<li class="nav-item"><a href="/htashop/loginform.jsp" class="nav-link <%="login".equals(menu) ? "active" : "" %>">LOGIN</a></li>
				<li class="nav-item"><a href="/htashop/registerform.jsp" class="nav-link <%="join".equals(menu) ? "active" : "" %>">JOIN</a></li>
<%
	} else {
%>			
				<li class="nav-item"><a href="/htashop/index.jsp" class="nav-link">LOGOUT</a></li>
				<li class="nav-item"><a href="/htashop/myshop/modify.jsp" class="nav-link <%="modify".equals(menu) ? "active" : "" %>">MODIFY</a></li>
<%
	}
%>
				<li class="nav-item"><a href="/htashop/cart/main.jsp" class="nav-link <%="cart".equals(menu) ? "active" : "" %>">CART</a></li>
				<li class="nav-item"><a href="/htashop/order/main.jsp" class="nav-link <%="order".equals(menu) ? "active" : "" %>">ORDER</a></li>
				<li class="nav-item"><a href="/htashop/myshop/main.jsp" class="nav-link <%="myshop".equals(menu) ? "active" : "" %>">MYSHOP</a></li>
			</ul>
			<form class="d-flex" method="post" action="result.jsp">
      			<input type="search" name="search">
      			<button class="btn btn-primary btn-sm" type="submit" >검색</button>
    		</form>
		</div>
	</div>
</nav>