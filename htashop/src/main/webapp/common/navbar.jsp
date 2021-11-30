<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 클릭한 메뉴만 활성화되도록
	String menu = (String)pageContext.getAttribute("menu");

	// 로그인 전: [로그인, 조인,] 카트, 오더, 마이샵
	// 로그인 후: [로그아웃, 모디파이,] 카트, 오더, 마이샵
	// 관리자 페이지: 상점관리, 상품관리, 주문관리, 고객관리, 게시판관리
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");

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
	if (loginedUserInfo == null) {
%>
				<li class="nav-item"><a href="/htashop/loginform.jsp" class="nav-link <%="login".equals(menu) ? "active" : "" %>">LOGIN</a></li>
				<li class="nav-item"><a href="/htashop/registerform.jsp" class="nav-link <%="join".equals(menu) ? "active" : "" %>">JOIN</a></li>
<%
	} else {
		if ("admin".equals(loginedUserInfo.getUserType())) {
%>
				<li class="nav-item"><a href="/htashop/logout.jsp" class="nav-link"><%=loginedUserInfo.getName() %> LOGOUT</a></li>
<%			
		} else if ("customer".equals(loginedUserInfo.getUserType())) {
%>
				<li class="nav-item"><a href="/htashop/logout.jsp" class="nav-link"><%=loginedUserInfo.getName() %> LOGOUT</a></li>
				<li class="nav-item"><a href="/htashop/myshop/modify.jsp" class="nav-link <%="modify".equals(menu) ? "active" : "" %>">MODIFY</a></li>
<%
		}
	}
%>
				<li class="nav-item"><a href="/htashop/cart/main.jsp" class="nav-link <%="cart".equals(menu) ? "active" : "" %>">CART</a></li>
				<li class="nav-item"><a href="/htashop/order/main.jsp" class="nav-link <%="order".equals(menu) ? "active" : "" %>">ORDER</a></li>
				<li class="nav-item"><a href="/htashop/myshop/index.jsp" class="nav-link <%="myshop".equals(menu) ? "active" : "" %>">MYSHOP</a></li>
			</ul>
			<form class="d-flex" method="post" action="result.jsp">
      			<input type="search" name="search">
      			<button class="btn btn-primary btn-sm" type="submit" >검색</button>
    		</form>
		</div>
	</div>
</nav>