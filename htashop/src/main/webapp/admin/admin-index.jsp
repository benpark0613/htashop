<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title></title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "home");
	pageContext.setAttribute("leftMenu", "home");
%>
<%@ include file="../common/admin-navbar.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../common/admin-left.jsp" %>
		</div>
		<div class="col-10" id="main">
			<div class="row mt-3">
				<div class="col">금일 쇼핑몰 현황</div>
				<div class="col">여기에 날짜 넣기</div>
			</div>
			<div class="row mt-1">
				<div class="col">
					<table class="table table-bordered caption-top">
						<thead>
							<tr>
								<th>주문</th>
								<th>취소</th>
								<th>게시물</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td></td>
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