<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>HTA shop::메인페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "home");
%>
<%@include file="common/navbar.jsp"%>
<div class="container">
	<div class="row justify-content-end">
		<div  class="col-sm-2">
			<%@ include file="common/left.jsp" %>
		</div>
<%

%>		
		
		<div class="col-sm-10 align-self-end">
		
	<!-- 로그인 안하고 MYSHOP 접근했을 때 오류 표시 -->	
<%
	String failReason = request.getParameter("fail");
	if("unlogined".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">로그인 후 이용하세요!</div>
<%
	}
%>
		
			<div class="row mb-3">
				<div class="col-sm-4 mb-3">
				
					<div class="card mt-3">
						<img src="resources/images/가디건.jpg" class="card-img-top" />
						<div class="card-body">
							<h5 class="card-title text-center">상품이름</h5>
							<p class="card-text text-danger text-center">
								<strong class="fw-bold">상품가격</strong> 원
							</p>
						</div>
					</div>
					
				</div>
			</div>
			
			
			
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>