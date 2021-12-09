<%@page import="com.shop.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String[] orderNo = request.getParameterValues("orderNo");
	String orderState = request.getParameter("orderState");
	
	OrderListDao orderListDao = new OrderListDao();
	
	int[] orderNos = new int[orderNo.length];
	for(int i=0; i<orderNo.length; i++){
		
		orderNos[i] = Integer.parseInt(orderNo[i]);
		orderListDao.updateState(orderNos[i], orderState);
		System.out.println(orderNo);
		System.out.println(orderState);
	}
	
	response.sendRedirect("orderList.jsp");
%>

	