<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>HTA shop::메인페이지</title>
<link href="../resources/css/newstyle.css" rel="stylesheet" />
</head>
<body>

<%
	pageContext.setAttribute("menu", "home");
%>
<%@include file="../common/navbar.jsp"%>
<%
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
%>
<div class="container">
	<div class="row justify-content-end">
		<div  class="col-sm-2">
			<%@ include file="../common/left.jsp" %>
		</div>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String pageNo = request.getParameter("pageNo");
	ReviewDao reviewDao = new ReviewDao();
	ReviewDto reviewDto = reviewDao.getReviewDetailByNo(reviewNo);
%>		
		<div class="col-sm-10 align-self-end mt-4">
			<div class="row mb-3">
<%
	// form.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 새 글 링크를 눌러서 form.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 새 글 등록에 실패한 경우에만 form.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");

	if ("empty-title".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>게시글 등록 실패!!</strong> 게시글 제목은 필수입력값입니다.
			</div>
<%
	} else if ("empty-content".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>게시글 등록 실패!!</strong> 게시글 내용은 필수입력값입니다.
			</div>
<%
	}
%>
			<!-- 
				게시글 정보 입력폼이다.
				title, content 정보를 입력받아서 register.jsp로 제출한다.
				register.jsp에서 게시글을 등록하고, 오류가 발생하면 이 페이지를 재요청하는 URL을 응답으로 보낸다.
				register.jsp에서 게시글 등록이 완료되면, list.jsp를 재요청하는 URL을 클라이언트에 응답으로 보낸다. 
			 -->
			<form class="border p-3 bg-light" method="post" action="modifyRegister.jsp?reviewNo=<%=reviewNo%>&pageNo=<%=pageNo%>">
				<div class="mb-3">
					<label class="form-label" for="board-title">제목</label>
					<input type="text" class="form-control" name="title" value ="<%=reviewDto.getTitle()%>">
				</div>
				<div class="mb-3">
					<label class="form-label" for="board-content">내용</label>
					<textarea rows="6" class="form-control" name="content"><%=reviewDto.getReviewContent()%></textarea>
				</div>
				<div class="mb-3 text-end">
					<a href="reviewDetail.jsp?reviewNo=<%=reviewNo %>" class="btn btn-secondary">취소</a>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
			</div>
		</div>
	</div>
</div>				
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>