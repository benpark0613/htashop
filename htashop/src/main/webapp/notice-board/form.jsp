<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<title>공지사항 글쓰기</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "notice");
%>
<%@ include file="../common/navbar.jsp"%>
<%
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
%>

	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp" %>
			</div>
			<div class="col-10">
				<h2>공지사항 글쓰기</h2>
				<div class="row mb-3">
					<div class="col">
<%
	String error = request.getParameter("error");	
	if ("empty-title".equals(error)) {
%>
						<div class="alert alert-danger">
							<strong>게시글 등록 실패</strong> 게시글 제목은 필수입력값입니다.
						</div>
<%
	} else if ("empty-content".equals(error)) {
%>
						<div class="alert alert-danger">
							<strong>게시글 등록 실패</strong> 게시글 내용은 필수입력값입니다.
						</div>
<%
	}
%>
						<form class="border p-3 bg-light" method="post" action="register.jsp">
							<div class="mb-3">
								<label class="form-label" for="noticeboard-writer">작성자</label>
								<input type="text" class="form-control" name="writer" id="noticeboard-writer" value="<%=loginedUserInfo.getId() %>" disabled="disabled" />
							</div>
							<div class="mb-3">
								<label class="form-label" for="noticeboard-title">제목</label>
								<input type="text" class="form-control" name="title" id="noticeboard-title" />
							</div>
							<div class="mb-3">
								<label class="form-label" for="noticeboard-content">내용</label>
								<textarea class="form-control" rows="10" name="content"></textarea>
							</div>
							<div class="mb-3 text-end">
								<button type="submit" class="btn btn-dark">등록</button>
								<a href="list.jsp" class="btn btn-secondary">취소</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
