<%@page import="com.shop.dto.OrderCartDto"%>
<%@page import="com.shop.dto.CartDto"%>
<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.dao.PointChangeDao"%>
<%@page import="com.shop.vo.PointChange"%>
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
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	int pointUse = Integer.parseInt(request.getParameter("pointUse"));
	
	ProductDao productDao = ProductDao.getInstance();
	OrderDao orderDao = OrderDao.getInstance();
	OrderCartDto orderCartDto = new OrderCartDto();
	
	List<Cart> cartList = CartDao.getInstance().selectAllCartListByUserNo(loginedUserInfo.getUserNo());
	
	for (Cart cart : cartList) {
		orderCartDto.setCartNo(cart.getCartNo());
		orderCartDto.setCartQuantity(cart.getQuantity());
		orderCartDto.setUserNo(loginedUserInfo.getUserNo());
		orderCartDto.setProductNo(cart.getProductNo());
		orderCartDto.setOrderPrice(productDao.getProductDetailById(cart.getProductNo()).getPrice() * cart.getQuantity());
		orderCartDto.setPointUsed((int)(pointUse / cartList.size()));
		orderCartDto.setExpectedPoint((int)(productDao.getProductDetailById(cart.getProductNo()).getPrice() * cart.getQuantity() * 0.01));
		orderCartDto.setPointChange(orderCartDto.getExpectedPoint() - orderCartDto.getPointUsed());
		orderCartDto.setPointChangeReason("구매");
		orderCartDto.setCustomerPoint(loginedUserInfo.getPoint() + orderCartDto.getExpectedPoint() - orderCartDto.getPointUsed());
		orderDao.orderTransaction(orderCartDto);
	}
	
	response.sendRedirect("order-completed.jsp");
	
	
	
%>
