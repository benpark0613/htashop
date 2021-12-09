<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
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
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>qa 목록</title>
</head>
<body>
	<%@ include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-sm-10">
				<div class="row mt-2" id="container_title">
					<div class="col">
						<h4 class="fs-6">
							<font color=#777777>Q & A</font> | Q&A 상세
						</h4>
					</div>
				</div>
				<%
				int no = Integer.parseInt(request.getParameter("no"));
				String pageNo = request.getParameter("pageNo");
				String fail = request.getParameter("fail");

				QaBoardDao qaBoardDao = QaBoardDao.getInstance();
				QaBoard qaBoard = qaBoardDao.getQuestionByNo(no);
				qaBoard.setViewCount(qaBoard.getViewCount() + 1);
				qaBoardDao.updateViewCount(qaBoard);

				if (loginedUserInfo != null
						&& (qaBoard.getUserId().equals(loginedUserInfo.getId()) || "admin".equals(loginedUserInfo.getId()))) {
				%>
				<div class="col">
					<table class="table border p-3 bg-light">
						<tbody>
							<tr class="d-flex">
								<th class="col-2">게시글 번호</th>
								<td class="col-4"><%=qaBoard.getNo()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">제목</th>
								<td class="col-4"><%=qaBoard.getTitle()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">작성자</th>
								<td class="col-4"><%=qaBoard.getUserName()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">작성일</th>
								<td class="col-4"><%=qaBoard.getRegdate()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">내용</th>
								<td class="col-10"><%=qaBoard.getContent()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">댓글</th>
								<td class="col-10"><%=qaBoard.getReply()%></td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="mb-3 text-end">
					<a href="modifyform.jsp?no=<%=qaBoard.getNo()%>&pageNo=<%=pageNo%>"
						" class="btn btn-dark">수정</a> <a
						href="remove.jsp?no=<%=qaBoard.getNo()%>&pageNo=<%=pageNo%>"
						" class="btn btn-dark">삭제</a> <a
						href="list.jsp?pageNo=<%=pageNo%>" class="btn btn-secondary">목록</a>
				</div>
				<%
				if ("admin".equals(loginedUserInfo.getId())) {
				%>
				<form method="post" action="reply.jsp">
					<input type="hidden" name="no" value="<%=qaBoard.getNo()%>">
					<div class="mb-3">
						<label class="col-1 col-form-label text-front">댓글</label>
						<textarea rows="6" class="form-control" name="reply"></textarea>
					</div>
					<div class="row mb-3">
						<div class="col">
							<div class="mb-3 text-end">
								<button type="submit" class="btn btn-primary" name=>댓글등록</button>
							</div>
						</div>
					</div>
			</div>
		</div>
		</form>
		<%
		}
		} else if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
		} else if (!qaBoard.getUserId().equals(loginedUserInfo.getId()) || !"admin".equals(loginedUserInfo.getId())) {
		response.sendRedirect("list.jsp?fail=other");
		return;
		} else if ("notAdmin".equals(fail)) {
		%>
		<div class="alert alert-danger">
			<strong>[관리자 권한]</strong> 관리자만 댓글을 달 수 있습니다.
		</div>
		<%
		} else if ("other".equals(fail)) {
		%>
		<div class="alert alert-danger">
			<strong>[불가]</strong> 관리자 또는 작성자의 권한입니다..
		</div>
		<%
		}
		%>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>