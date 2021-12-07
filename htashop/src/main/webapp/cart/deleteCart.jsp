
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 주문정보 삭제 메소드
	
	// 회원 로그인 정보를 조회
	User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	if(loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	// 장바구니 번호 정보를 가져온다.
	int no = Integer.parseInt(request.getParameter("no"));
	
	// 장바구니 db 정보를 조회한다.
	CartDao cartDao = CartDao.getInstance();
	
	cartDao.deleteCartByNo(no);
	
	response.sendRedirect("cart.jsp");
%>