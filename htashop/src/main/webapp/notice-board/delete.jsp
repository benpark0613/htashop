<%@page import="com.shop.vo.NoticeBoard"%>
<%@page import="com.shop.dto.NoticeBoardListDto"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	NoticeBoardListDto dto = noticeBoardDao.getNoticeBoardByNo(no);
	
	if (!dto.getNoticeWriter().equals(loginedUserInfo.getId())) {
		response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo+"&error=deny-delete");
		return;
	}
	
	noticeBoardDao.deleteNoticeBoard(no);
	
	response.sendRedirect("list.jsp?pageNo=" + pageNo);
%>