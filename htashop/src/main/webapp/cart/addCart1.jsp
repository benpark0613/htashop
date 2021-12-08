<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/*
		products > detail 에서 구매 버튼을 눌렀을 때 실행되는 로직이다.
		로직 실행 후 카트 화면으로 넘어간다.
	*/
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	// loginUserInfo 변수에 인증된 사용자 정보가 포함되어 있는지 여부
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	CartDao cartDao = CartDao.getInstance();
	Cart cart = cartDao.selectCartByProductNo(productNo);
	
	if (cart != null) {
		cart.setQuantity(cart.getQuantity() + quantity);
		cartDao.updateCartQuantityByNo(cart);
		
	} else {
		cart = new Cart();
		cart.setUserNo(loginedUserInfo.getUserNo());
		cart.setProductNo(productNo);
		cart.setQuantity(quantity);
		cartDao.insertCart(cart);
	}
	response.sendRedirect("../cart/cart.jsp");
%>