<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.vo.Review"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String pageNo = request.getParameter("pageNo");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	if (title != null && title.isBlank()) {
		response.sendRedirect("reviewform.jsp?error=empty-title");
		return;
	}
	if (content != null && content.isBlank()) {
		response.sendRedirect("reviewform.jsp?error=empty-content");
		return;
	}
	User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	ReviewDto review = new ReviewDto();
	review.setTitle(title);
	review.setProductNo(productNo);
	review.setUserNo(loginedUserInfo.getUserNo());
	review.setReviewContent(content);
	ReviewDao reviewDao = new ReviewDao();
	reviewDao.insertReview(review);
	response.sendRedirect("detail.jsp?productNo=" + productNo);
%>