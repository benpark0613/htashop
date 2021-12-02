<%@page import="com.shop.dto.NoticeBoardListDto"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if (title != null && title.isBlank()) {
		response.sendRedirect("modify.jsp?no="+no+"&pageNo"+pageNo+"&error=empty-title");
		return;
	}
	
	if (content != null && content.isBlank()) {
		response.sendRedirect("modify.jsp?no="+no+"&pageNo"+pageNo+"&error=empty-content");
		return;
	}
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	NoticeBoardListDto dto = noticeBoardDao.getNoticeBoardByNo(no);
	dto.setNoticeTitle(title);
	dto.setNoticeContent(content);
	
	noticeBoardDao.updateNoticeBoard(dto);
	
	response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo);
%>