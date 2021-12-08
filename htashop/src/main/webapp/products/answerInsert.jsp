<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String answerContent = request.getParameter("answerContent");	
		if (answerContent != null && answerContent.isBlank()) {
			response.sendRedirect("replyForm.jsp?reviewNo="+reviewNo+"&error=empty-content");
			return;
		}
		System.out.print(reviewNo);
		User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
		
		if (loginedUserInfo == null) {
			response.sendRedirect("../loginform.jsp?error=login-required");
			return;
		}	
		if (!"admin".equals(loginedUserInfo.getUserType())) {
			response.sendRedirect("../loginform.jsp?error=login-required");
			return;
		}
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto dto = reviewDao.getReviewDetailByNo(reviewNo);
	dto.setAnswerContent(answerContent);	
	reviewDao.insertReply(dto);	
	response.sendRedirect("reviewDetail.jsp?reviewNo="+reviewNo);
%>