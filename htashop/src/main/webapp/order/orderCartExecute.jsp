<%@page import="com.shop.vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Order"%>
<%@page import="com.shop.vo.OrderList"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	if (loginedUserInfo == null) {
		
		return;
	}
	
	List<Cart> cartList = CartDao.getInstance().selectAllCartListByUserNo(loginedUserInfo.getUserNo());
	
	
	
%>
