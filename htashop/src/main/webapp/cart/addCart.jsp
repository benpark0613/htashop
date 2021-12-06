
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	// TODO 사용자 로그인 여부 체크
	// loginUserInfo 변수에 인증된 사용자 정보가 포함되어 있는지 여부
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	// 상세페이지에서 수량선택은 1부터 가능하므로 이에대한 오류는 필요없는 것 같다.
	// TODO 수량선택을 안한 경우다. products/detail.jsp 페이지에 오류를 받는 코드 추가하기 
	//if (quantity <= 0) {
		//response.sendRedirect("../products/detail.jsp?error=empty-quantity");
		//return;
	//}
	
	CartDao cartDao = CartDao.getInstance();
	Cart cart = cartDao.getCartByProductNo(productNo);
	
	if (cart != null) {
		cart.setQuantity(cart.getQuantity() + quantity);
		cartDao.updateCart(cart);
		
	} else {
		cart = new Cart();
		cart.setUserNo(loginedUserInfo.getUserNo());
		cart.setProductNo(productNo);
		cart.setQuantity(quantity);
		cartDao.insertCart(cart);
	}
	response.sendRedirect("cart.jsp");
%>