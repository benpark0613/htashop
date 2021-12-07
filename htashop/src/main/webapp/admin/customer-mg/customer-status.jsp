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
<%
	if (loginedUserInfo == null || !"admin".equals(loginedUserInfo.getUserType())) {
		response.sendRedirect("../../loginform.jsp?fail=login-required");
		return;
	}
%>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-6" id="main">
			<div class="row">
				<div class="col m-1 mt-5">
					<table class="table table-bordered caption-top offset-4  fs-3"> 
					<caption class="fs-4 fw-bold">회원목록</caption>
						<thead>
							<tr>
								<th class="col-2 text-center" scope="col">신규회원</th>
								<th class="col-2 text-center" scope="col">탈퇴회원</th>
								<th class="col-2 text-center" scope="col">TOTAL</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col-2 text-center" scope="row"><%=userDao.getNewUserCount() %></td>
								<td class="col-2 text-center" scope="row"><%=userDao.getOutUserCount() %></td>
								<td class="col-2 text-center" scope="row"><%=userDao.getTotalUserCount() - userDao.getOutUserCount() %></td>
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