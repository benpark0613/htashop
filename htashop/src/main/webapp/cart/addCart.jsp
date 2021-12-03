
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	// TODO 사용자가 같은 상품을 다시 장바구니에 담는 경우 구현
    if () {   	
    	
    }
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	// TODO 사용자 로그인 여부 체크
	// loginUserInfo 변수에 인증된 사용자 정보가 포함되어 있는지 여부
	if (loginUserInfo == null) {
%>
<div class="alert alert-danger alert-dismissable">
	<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
	<strong>상품을 장바구니에 담을 수 없습니다.</strong> 로그인 후 장바구니에 담아주세요.
</div>
<%
	} else {
%>
<div class="alert alert-info">
	<strong>상품이 장바구니에 추가되었습니다.</strong><a href="#"	class="alert-link"></a>.
</div>
<%
} 
%>

<% 
Cart cart = new Cart(); //객체생성후, 위의 productNo, quantity, 로그인세션정보를 저장한다.
cart.setUserNo(loginedUserInfo.getUserNo());
cart.setProductNo(productNo); cart.setQuantity(quantity); CartDao
tempCartDao = CartDao.getInstance(); // cartDao를 불러와 cart값을 저장한다.
tempCartDao.insertCart(cart); response.sendRedirect("cart.jsp"); 
%>
