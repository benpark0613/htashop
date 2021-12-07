
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	if(loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	//이전페이지에서 얻어야할 요청값 상품번호, 장바구니수량
	int no = Integer.parseInt(request.getParameter("no"));
	int qty = Integer.parseInt(request.getParameter("quantity"));

	// 장바구니 번호로 제품수량을 조회하여 업데이트함.
	CartDao cartDao = CartDao.getInstance();
	
	Cart cart = new Cart();
	cart.setQuantity(qty);
	cart.setCartNo(no);
	cartDao.updateCartQuantityByNo(cart);
	
	response.sendRedirect("cart.jsp");
%>