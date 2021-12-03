<%@page import="java.util.List"%>
<%@page import="com.shop.dao.TempCartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");

	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}

	// TODO 수량선택을 안한 경우 products/detail.jsp 페이지 오류 체크 코드 추가하기 
	if (quantity <= 0) {
		response.sendRedirect("../products/detail.jsp?error=empty-quantity");
		return;
	}
	
	TempCartDao tempCartDao = TempCartDao.getInstance();
	
	// TODO 사용자가 같은 상품을 다시 장바구니에 담는 경우 구현
	List<Cart> cartList = tempCartDao.getAllCartListByUserNo(loginedUserInfo.getUserNo());
	
	if (!cartList.isEmpty()) {
		for (Cart cart : cartList) {
			if (cart.getProductNo() == productNo) {
				cart.setQuantity(cart.getQuantity() + quantity);
				tempCartDao.updateCart(cart);
			} 
		}
		response.sendRedirect("temp-cart.jsp");
	}
		
	Cart cart = new Cart();
	cart.setUserNo(loginedUserInfo.getUserNo());
	cart.setProductNo(productNo);
	cart.setQuantity(quantity);
	
	tempCartDao.insertCart(cart);
	
	response.sendRedirect("temp-cart.jsp");
%>