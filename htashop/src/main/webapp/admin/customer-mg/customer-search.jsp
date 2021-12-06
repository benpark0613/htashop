<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title>관리자:회원정보조회</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "customer-search");
	pageContext.setAttribute("leftMenu", "customer-status");
%>
<%@ include file="../../common/admin-navbar.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-10">
			<div class="row">
				<h1>회원정보조회</h1>
			</div>
			<div class="row">
				<h1>회원정보조회폼</h1>
			</div>
			<div class="row">
				<h1>검색버튼</h1>
			</div>
			<div class="row">
				<h1>회원목록</h1>
			</div>
			<div class="row">
				<h1>회원조회리스트</h1>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>