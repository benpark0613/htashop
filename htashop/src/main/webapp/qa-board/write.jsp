<%@page import="com.shop.vo.User"%>
<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// loginform.jsp에서 제출한 폼입력값을 조호한다.
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	if (title != null && title.isBlank()) {
		response.sendRedirect("writeform.jsp?fail=emptyTitle");
		return;
	}
	
	if (content != null && content.isBlank()) {
		response.sendRedirect("writeform.jsp?fail=emptyContent");
		return;
	}
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	QaBoard qaBoard = new QaBoard();
	
	qaBoard.setTitle(title);
	qaBoard.setContent(content);
	qaBoard.setUserNo(loginedUserInfo.getUserNo());
	qaBoard.setProductNo(productNo);
	
	
	QaBoardDao qaBoardDao = QaBoardDao.getInstance();
	qaBoardDao.insertQaBoard(qaBoard);
	
	response.sendRedirect("list.jsp");
%>