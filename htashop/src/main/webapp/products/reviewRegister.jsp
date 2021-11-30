<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// 입력값 title이 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 게시글 정보를 입력하는 form.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (title != null && title.isBlank()) {
		response.sendRedirect("reviewform.jsp?error=empty-title");
		return;
	}
	// 입력값 content가 없거나 비어있으면 게시글을 등록할 수 없다.
	// 클라이언트에게 게시글 정보를 입력하는 form.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 사용자인증 실패원인을 포함시킨다.
	if (content != null && content.isBlank()) {
		response.sendRedirect("reviewform.jsp?error=empty-content");
		return;
	}
	
	// Board객체를 생성한다.
	// 생성한 Board객체에 제목, 작성자, 내용을 저장한다.
	Review review = new Review();
	review.setTitle(title);
	//review.setReview(content);
	
	// 게시글 관련 기능을 제공하는 BoardDao 객체를 획득한다.
	ReviewDao reviewDao = new ReviewDao();
	
	// 게시글 정보를 테이블에 저장시킨다.
	reviewDao.insertReview(review);
	
	// 클라이언트에게 게시글 목록(list.jsp)은 재요청하게 하는 응답을 보내다.
	response.sendRedirect("list.jsp");

	
%>