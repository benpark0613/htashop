<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<title>공지사항 글쓰기</title>
</head>
<body>
<%
pageContext.setAttribute("menu", "notice");
%>
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row mb-3">
		<div class="col">
			<h2>공지사항 글쓰기</h2>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<form class="border p-3 bg-light" method="post" action="register.jsp">
				<div class="mb-3">
					<label class="form-label" for="noticeboard-title">제목</label> 
					<input type="text" class="form-control" name="title" id="noticeboard-title" />
				</div>
				<div class="mb-3">
					<label class="form-label" for="noticeboard-content">내용</label>
					<textarea class="form-control" rows="10" name="content"></textarea>
				</div>
				<div class="mb-3">
					<a href="list.jsp" class="btn btn-secondary">취소</a>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
