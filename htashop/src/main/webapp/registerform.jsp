<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "register");
%>
<%@ include file="common/navbar.jsp"%>
<div class="container">    
	<div class="row justify-content-md-center">
		<div class="col-5">
			<h1 class="fs-3 justify-content-md-center">회원가입</h1>
		</div>
	</div>
	<div class="row justify-content-md-center">
		<div class="col-5">
			<form class="border p-3 bg-light" method="post" action="join.jsp">
				<div class="mb-3">
					<label class="form-label" for="user-id">아이디</label>
					<input type="text" class="form-control" name="id" id="user-id">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-password">비밀번호</label>
					<input type="password" class="form-control" name="password" id="user-password">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-name">이름</label>
					<input type="text" class="form-control" name="name" id="user-name">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-tel">전화번호</label>
					<input type="text" class="form-control" name="tel" id="user-tel">
				</div>
				<div class="mb-3">
					<label class="form-label" for="user-email">이메일</label>
					<input type="text" class="form-control" name="email" id="user-email">
				</div>
				
				<div class="mb-3">
					<label class="form-label" for="user-address">주소</label>
					<select class="form-select" name="address" id="user-address">
  						<option selected>거주하는 도시를 선택해주세요.</option>
  						<option value="서울">서울</option>
  						<option value="인천">인천</option>
  						<option value="경기">경기</option>
  						<option value="강원">강원</option>
  						<option value="충청">충청</option>
  						<option value="경남">경남</option>
  						<option value="경북">경북</option>
  						<option value="대전">대전</option>
  						<option value="전남">전남</option>
  						<option value="전북">전북</option>
  						<option value="세종">세종</option>
  						<option value="제주">제주</option>
					</select>
				</div>

				<div class="mb-3 text-end">
					<button type="submit" class="btn btn-primary">회원가입</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>