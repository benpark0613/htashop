<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>HTA shop::로그인</title>
</head>
<body>
	<%
	pageContext.setAttribute("menu", "login");
	%>
	<%@ include file="common/navbar.jsp"%>
	<div class="container">
		<div class="row justify-content-md-center">
			<div class="col-5">
				<h1 class="fs-3 justify-content-md-center">로그인</h1>
			</div>
		</div>
		<div class="row justify-content-md-center">
			<div class="col-5">
				<%
				// 실패원인이 아이디일때
				String fail = request.getParameter("fail");
				// 문자 equals 변수명
				if ("id".equals(fail)) {
				%>
				<div class="alert alert-danger">
					<strong>[로그인 실패]</strong> 가입되지 않은 아이디입니다.
				</div>
				<%
				}
				if ("password".equals(fail)) {
				%>
				<div class="alert alert-danger">
					<strong>[로그인 실패]</strong> 비밀번호가 일치하지 않습니다.
				</div>
				<%
				}
				if ("login-required".equals(fail)) {
				%>
				<div class="alert alert-danger">
					<strong>[로그인 실패]</strong> 로그인이 필요한 페이지를 요청하였습니다.
				</div>
				<%
				}
				%>
				<form class="border p-3 bg-light" method="post" action="login.jsp">

					<div class="mb-3">
						<label class="form-label" for="user-id">아이디</label> <input
							type="text" class="form-control" name="id" id="user-id">
					</div>
					<div class="mb-3">
						<label class="form-label" for="user-password">비밀번호</label> <input
							type="password" class="form-control" name="password"
							id="user-password">
					</div>
					<div class="mb-3 text-end">
						<a href="registerform.jsp" class="btn btn-primary " type="button">회원가입</a>
						<button type="submit" class="btn btn-primary">로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>