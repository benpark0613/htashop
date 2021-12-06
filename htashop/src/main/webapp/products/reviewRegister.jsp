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
	// Board객체를 생성한다.
	// 생성한 Board객체에 제목, 작성자, 내용을 저장한다.
	ReviewDto review = new ReviewDto();
	
	review.setTitle(title);
	review.setProductNo(productNo);
	review.setUserNo(loginedUserInfo.getUserNo());
	review.setReviewContent(content);
	
	// 게시글 관련 기능을 제공하는 BoardDao 객체를 획득한다.
	ReviewDao reviewDao = new ReviewDao();
	// 게시글 정보를 테이블에 저장시킨다.
	reviewDao.insertReview(review);
	// 클라이언트에게 게시글 목록(list.jsp)은 재요청하게 하는 응답을 보내다.
	response.sendRedirect("detail.jsp?productNo=" + productNo);
%>