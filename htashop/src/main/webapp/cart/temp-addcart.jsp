<%@page import="com.shop.dao.TempCartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));

	
	// TODO 사용자가 같은 상품을 다시 장바구니에 담는 경우 구현
    // if () {}
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");

	// TODO 사용자 로그인 여부 체크
	// if () {}
	
	Cart cart = new Cart();
	cart.setUserNo(loginedUserInfo.getUserNo());
	cart.setProductNo(productNo);
	cart.setQuantity(quantity);
	
	TempCartDao tempCartDao = TempCartDao.getInstance();
	tempCartDao.insertCart(cart);
	
	response.sendRedirect("temp-cart.jsp");
%>