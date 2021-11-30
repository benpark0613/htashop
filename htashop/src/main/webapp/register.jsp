<%@page import="com.shop.dao.CustomerDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="com.shop.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 회원가입 = 가입폼에서 입력받은 값을 db에 저장하는 것
	
	// 동일한 아이디 가입불가
	// 동일한 이메일 가입불가
	
	// 가입폼에서 입력받은 값 꺼내오기
	// 아이디, 비밀번호, 이름, 전화번호, 이메일, (주소)
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String secretPassword = DigestUtils.sha256Hex(password);	// 비밀번호는 암호화
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");
	
	
	// 요청파라미터에서 꺼낸 값 Customer객체에 저장하기
	// 새롭게 가입한 회원이라 newCustomer로 변수명을 정했음
	Customer newCustomer = new Customer();
	newCustomer.setCustomerId(id);
	newCustomer.setCustomerPassword(secretPassword);
	newCustomer.setCustomerName(name);
	newCustomer.setCustomerTel(tel);
	newCustomer.setCustomerEmail(email);

	
	// 신규회원정보를 기존회원정보(oldCustomer)와 비교하기
	// 회원가입조건: 동일한 아이디 가입불가, 동일한 이메일 가입불가
	// 				getCustomerById		 getCustomerByEmail
	
	Customer oldCustomer = new Customer();
	CustomerDao customerDao = new CustomerDao();
	
	// 1. 입력폼에서 입력받은 아이디로 기존회원 검색
	oldCustomer = customerDao.getCustomerById(id);
	// 그 결과가 null이 아님 = 이미 동일한 아이디로 가입한 기존회원이 있음
	if (oldCustomer != null) {
		response.sendRedirect("registerform,jsp?fail=id");
	}
	
	// 2. 입력폼에서 입력받은 이메일로 기존회원 검색
	oldCustomer = customerDao.getCustomerByEmail(email);
	// 결과가 null이 아니면 이미 동일한 이메일이 존재한다는 의미
	if (oldCustomer != null) {
		response.sendRedirect("registerform.jsp?fail=email");
	}
	
	
	// 조건을 모두 통과했으면 가입성공!
	
	
	
%>