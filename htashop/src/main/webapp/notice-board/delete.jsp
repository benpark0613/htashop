<%@page import="com.shop.vo.NoticeBoard"%>
<%@page import="com.shop.dto.NoticeBoardDto"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	
	User loginedCustomerInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedCustomerInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	NoticeBoardDto noticeBoardDto = new NoticeBoardDto();
	NoticeBoard noticeBoard = noticeBoardDto.getNoticeBoardDetailByNo(no);
	
	if (noticeBoard.getNo() != loginedCustomerInfo.getUserNo()) {
		response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo+"&error=deny-delete");
		return;
	}
	
	NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
	noticeBoardDao.deleteNoticeBoard(no);
	
	response.sendRedirect("list.jsp?pageNo=" + pageNo);
%>