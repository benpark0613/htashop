<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String pageNo = request.getParameter("pageNo");
	
	User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto dto = reviewDao.getReviewDetailByNo(reviewNo);

	if ("admin".equals(loginedUserInfo.getUserType())) {	
		reviewDao.deleteReview(reviewNo);
		response.sendRedirect("detail.jsp?productNo="+productNo+"&pageNo="+pageNo);
		return;
	}
	
	if (dto.getUserNo() != loginedUserInfo.getUserNo()) {
		response.sendRedirect("detail.jsp?productNo="+ productNo +"&reviewNo="+ reviewNo + "&pageNo=" + pageNo);
		return;
	}
	
	
	reviewDao.deleteReview(reviewNo);
	response.sendRedirect("detail.jsp?productNo="+productNo+"&pageNo="+pageNo);
	
%>