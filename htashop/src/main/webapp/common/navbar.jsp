<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 클릭한 메뉴만 활성화되도록
	String menu = (String)pageContext.getAttribute("menu");
	
	// 로그인 전: <로그인, 조인,> 카트, 오더, 마이샵
	
	// 로그인 후: <로그아웃, 모디파이,> 카트, 오더, 마이샵

<<<<<<< HEAD
=======
	
	
	

	



>>>>>>> 6e2d1c9b3a4fd9e225af9f75ddcae8b670081077
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
				<li class="nav-item"><a href="/htashop/loginform.jsp" class="nav-link <%="login".equals(menu) ? "active" : "" %>">LOGIN</a></li>
				<li class="nav-item"><a href="/htashop/registerform.jsp" class="nav-link <%="join".equals(menu) ? "active" : "" %>">JOIN</a></li>
				<!-- 로그인여부에 따라 다르게 표시되는 부분 -->
				<li class="nav-item"><a href="/htashop/index.jsp" class="nav-link">LOGOUT</a></li>
				<li class="nav-item"><a href="/htashop/myshop/modify.jsp" class="nav-link">MODIFY</a></li>
				
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

	