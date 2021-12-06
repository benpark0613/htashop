<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");

	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");

	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	QaBoardDao qaBoardDao = QaBoardDao.getInstance();

	QaBoard qaBoard = qaBoardDao.getQuestionByNo(no);
	
	
	qaBoardDao.deleteQuestion(no);
	response.sendRedirect("list.jsp?pageNo=" + pageNo);
%>
	