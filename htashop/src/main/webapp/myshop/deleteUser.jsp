<%@page import="com.shop.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp" %>

<%
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	UserDao userDao = new UserDao();
	userDao.deleteUser(userNo);
	
	response.sendRedirect("../index.jsp?quit=complete");
	
	
	
%>
