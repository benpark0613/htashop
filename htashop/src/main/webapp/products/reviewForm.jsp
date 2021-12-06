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
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>HTA shop::리뷰등록 페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "home");
%>
<%@include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row justify-content-end">
		<div  class="col-sm-2">
			<%@ include file="../common/left.jsp" %>
		</div>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String pageNo = request.getParameter("pageNo");
	ReviewDao reviewDao = new ReviewDao();
//	ReviewDto reviewDto = reviewDao.getReviewDetailByNo(reviewNo);
%>		
		<div class="col-sm-10 align-self-end mt-4">
			<div class="row mb-3">
<%
	String error = request.getParameter("error");
	if ("empty-title".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>리뷰 등록 실패!!</strong> 리뷰 제목은 필수입력값입니다.
			</div>
<%
	} else if ("empty-content".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>리뷰 등록 실패!!</strong> 리뷰 내용은 필수입력값입니다.
			</div>
<%
	}
%>
			<form class="border p-3 bg-light" method="post" action="reviewRegister.jsp?productNo=<%=productNo%>">
				<div class="mb-3">
					<label class="form-label" for="board-title">제목</label>
					<input type="text" class="form-control" name="title" id="board-title">
				</div>
				<div class="mb-3">
					<label class="form-label" for="board-content">내용</label>
					<textarea rows="6" class="form-control" name="content"></textarea>
				</div>
				<div class="mb-3 text-end">
					<a href="list.jsp" class="btn btn-secondary">취소</a>
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