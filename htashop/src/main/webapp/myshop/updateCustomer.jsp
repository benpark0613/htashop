<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.shop.dao.CustomerDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../navigation/nav.jsp" %>    

<%
	String password = request.getParameter("password");

	String secretPassword = (String)DigestUtils.sha256Hex(password);

	String name = request.getParameter("name");
	
	String year = request.getParameter("year");
	
	String email = request.getParameter("email");
	
	String month = request.getParameter("month");
	
	String day = request.getParameter("day");
	
	String strBirthDay = year + month + day;
	
	String region = request.getParameter("region");
	
	
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	
	String tel = tel1 +"-" + tel2 +"-" + tel3;
	
	//SimpleDateFormat formatter = new SimpleDateFormat("yyyymmdd");
	
	//Date birthDay = formatter.parse(strBirthDay);
	
	
	customer.setPassword(secretPassword);
	customer.setName(name);
	//customer.setBirthday((java.sql.Date)birthDay);
	customer.setAddress(region);
	customer.setTel(tel);
	customer.setEmail(email);
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.updateCustomer(customer);
	if(password == null){
		response.sendRedirect("customerInfo.jsp?fail=password");
		return;
	}
	if(name == null){
		response.sendRedirect("customerInfo.jsp?fail=name");
		return;
	}
	if(email == null){
		response.sendRedirect("customerInfo.jsp?fail=email");
		return;
	}
	
	if(tel1 == null){
		response.sendRedirect("customerInfo.jsp?fail=tel");
		return;
	}
	if(tel2 == null){
		response.sendRedirect("customerInfo.jsp?fail=tel");
		return;
	}
	if(tel3 == null){
		response.sendRedirect("customerInfo.jsp?fail=tel");
		return;
	}
	
	if(region == null){
		response.sendRedirect("customerInfo.jsp?fail=region");
		return;
	}
	
	response.sendRedirect("customerInfo.jsp");
	
%>