<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.shop.dao.CustomerDao"%>
<%@page import="com.shop.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 로그인폼에서 입력받아서 요청메세지에 들어있는 값 꺼내기
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	// 비밀번호는 db에 암호화된 상태로 저장되어 있음 1111
	String secretPassword = DigestUtils.sha256Hex(password);

	// 입력받은 아이디와 패스워드로 기존 사용자정보 조회하기
	CustomerDao customerDao = new CustomerDao();
	
	// 1. 아이디로 조회하기
	// 조회할 결과를 Customer객체에 담고
	Customer customer = customerDao.getCustomerById(id);
	// 아이디로 조회한 결과가 없으면 로그인폼 재요청
	if (customer == null) {
		response.sendRedirect("loginform.jsp?fail=id");
		return;
	}
	
	// 2. 비밀번호로 조회하기
	// "문자".equals(변수명)
	if (!customer.getCustomerPassword().equals(secretPassword)) {
		response.sendRedirect("loginform.jsp?fail=password");
		return;
	}

	
	// 위 조건들을 통과했으면 세션객체에 사용자정보 저장
	session.setAttribute("logined_customer_info", customer);

	response.sendRedirect("index.jsp");

%>