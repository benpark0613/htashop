<%@page import="com.shop.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title>관리자:회원현황</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "customer-status");
	pageContext.setAttribute("leftMenu", "customer-status");
	
	UserDao userDao = new UserDao();

%>
<%@ include file="../../common/admin-navbar.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-10" id="main">
			<div class="row mt-3">
				<div class="col">
					<h6>회원현황</h6>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th scope="col">신규회원</th>
								<th scope="col">탈퇴회원</th>
								<th scope="col">TOTAL</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td scope="row"><%=userDao.getNewUserCount() %></td>
								<td scope="row"><%=userDao.getOutUserCount() %></td>
								<td scope="row"><%=userDao.getTotalUserCount() - userDao.getOutUserCount() %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>