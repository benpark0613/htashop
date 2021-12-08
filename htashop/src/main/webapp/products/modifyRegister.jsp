<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String pageNo = request.getParameter("pageNo");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if (title != null && title.isBlank()) {
		response.sendRedirect("modifyRegister.jsp?reviewNo="+reviewNo+"&pageNo="+pageNo+"&error=empty-title");
		return;
	}
	
	if (content != null && content.isBlank()) {
		response.sendRedirect("modifyRegister.jsp?reviewNo="+reviewNo+"&pageNo="+pageNo+"&error=empty-content");
		return;
	}
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto dto = reviewDao.getReviewDetailByNo(reviewNo);
	dto.setTitle(title);
	dto.setReviewContent(content);	
	reviewDao.updateReviewDetail(dto);	
	response.sendRedirect("reviewDetail.jsp?reviewNo="+reviewNo+"&pageNo="+pageNo);
%>