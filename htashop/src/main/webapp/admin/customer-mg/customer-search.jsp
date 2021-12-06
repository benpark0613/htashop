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
	pageContext.setAttribute("leftMenu", "customer-search");
%>
<%@ include file="../../common/admin-navbar.jsp" %>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-10">
			<div class="row mb-2">
				<div class="col m-1">
					<table class="table table-bordered caption-top">
						<caption class="fs-4 fw-bold">회원정보조회</caption>
						<tbody>
							<tr>
								<th class="col-2 table-light"><label>개인정보</label></th>
								<td class="col-2" colspan="4">
									<select name="">
										<option value="">이름
										<option value="">아이디
										<option value="">주소
										<option value="">휴대폰번호
									</select>
									<input type="text">
								</td>
							</tr>
							<tr>
								<th class="col-2 table-light"><label>회원등급</label></th>
								<td class="col-2" colspan="4">
									<select name="">
										<option value="">전체
										<option value="">다이아
										<option value="">골드
										<option value="">실버
										<option value="">브론즈
									</select>
								</td>
							</tr>
							<tr>
								<th class="col-2 table-light"><label>가입일</label></th>
								<td class="col-2" colspan="4"><input type="date"> ~ <input type="date"></td>
							</tr>
							<tr>
								<th class="col-2 table-light"><label>나이</label></th>
								<td class="col-4"><input type="number"> ~ <input type="number"></td>
								<th class="col-2 table-light"><label>성별</label></th>
								<td class="col-4">
									<input type="radio">전체&nbsp;&nbsp;
									<input type="radio">남&nbsp;&nbsp;
									<input type="radio">여&nbsp;&nbsp;
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col m-1">
					<table class="table caption-top">
						<caption class="fs-4 fw-bold">회원목록</caption>
						<thead>
							<tr>
								<th>가입일</th>
								<th>이름</th>
								<th>아이디</th>
								<th>등급</th>
								<th>휴대전화</th>
								<th>성별</th>
								<th>나이</th>
								<th>지역</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
								<td>1</td>
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