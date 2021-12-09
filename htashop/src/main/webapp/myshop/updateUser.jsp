<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.shop.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp" %>

<%
  		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("confirmPassword");
    	String secretPassword = (String)DigestUtils.sha256Hex(password);
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	String year = request.getParameter("year");
    	String month = request.getParameter("month");
    	String day = request.getParameter("day");
    	String region = request.getParameter("region");
    	String tel1 = request.getParameter("tel1");
    	String tel2 = request.getParameter("tel2");
    	String tel3 = request.getParameter("tel3");
    	String tel = tel1 +"-" + tel2 +"-" + tel3;
    	String strBirthDay = year + "-" + month + "-" + day;
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	java.util.Date birthDay = sdf.parse(strBirthDay);
    	
    	User user = loginedUserInfo;
    	
    	user.setPassword(secretPassword);
    	user.setName(name);
    	user.setBirthday(new Date(birthDay.getTime()));
    	user.setAddress(region);
    	user.setTel(tel);
    	user.setEmail(email);
    	

    	
    	if(password.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=password");
    		return;
    	}
    	if(password != passwordConfirm){
    		response.sendRedirect("userInfo.jsp?fail=confirmPassword");
    		return;
    	}
    	if(name.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=name");
    		return;
    	}
    	if(email.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=email");
    		return;
    	}
    	
    	if(tel1.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=tel");
    		return;
    	}
    	if(tel2.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=tel");
    		return;
    	}
    	if(tel3.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=tel");
    		return;
    	}
    	
    	if(region.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=region");
    		return;
    	}
    	
    	if(year.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=birthday");
    		return;
    	}
    	if(month.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=birthday");
    		return;
    	}
    	if(day.isEmpty()){
    		response.sendRedirect("userInfo.jsp?fail=birthday");
    		return;
    	}
    	
    	UserDao userDao = new UserDao();
    	userDao.updateUser(user);

    	
    		response.sendRedirect("../index.jsp?userInfoChange=complete");
  %>