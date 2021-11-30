<%@page import="com.shop.vo.User"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if (title != null && title.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-title");
		return;
	}
	
	if (content != null && content.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-content");
		return;
	}
	
	User loginedCustomerInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedCustomerInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
	}
	
	NoticeBoard noticeBoard = new NoticeBoard();
	
	noticeBoard.setUserNo(loginedCustomerInfo.getUserNo());
	noticeBoard.setTitle(title);
	noticeBoard.setContent(content);
	
	NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
	response.sendRedirect("list.jsp");
%>













