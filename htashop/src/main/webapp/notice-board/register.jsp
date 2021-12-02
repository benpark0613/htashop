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
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	NoticeBoard noticeBoard = new NoticeBoard();
	noticeBoard.setUserNo(loginedUserInfo.getUserNo());
	noticeBoard.setTitle(title);
	noticeBoard.setContent(content);
	
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	noticeBoardDao.insertNoticeBoard(noticeBoard);
	response.sendRedirect("list.jsp");
%>













