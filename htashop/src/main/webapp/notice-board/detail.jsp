<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.dto.NoticeBoardDto"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
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
<title>공지</title>
</head>
<body>
<%
pageContext.setAttribute("menu", "notice");
%>
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row mb-3">
		<div class="col">
			<h1 class="fs-3">게시글 상세</h1>
		</div>
	</div>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	String error = request.getParameter("error");
	
	NoticeBoardDto noticeBoardDto = new NoticeBoardDto();
	NoticeBoard noticeBoard = noticeBoardDto.getNoticeBoardDetailByNo(no);
	noticeBoard.setViewCount(noticeBoard.getViewCount() + 1);
	
	NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
	noticeBoardDao.updateNoticeBoard(noticeBoard);
	
	UserDao userDao = new UserDao();
	User user = userDao.getUserByNo(noticeBoard.getUserNo());
%>
	<div class="row mb-3">
		<div class="col">
			<table class="table">
				<tbody>
					<tr class="d-flex">
						<th class="col-2">번호</th>
						<td class="col-4"><%=noticeBoard.getNo() %></td>
						<th class="col-2">등록일</th>
						<td class="col-4"><%=noticeBoard.getRegDate() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">제목</th>
						<td class="col-4"><%=noticeBoard.getTitle() %></td>
						<th class="col-2">작성자</th>
						<td class="col-4"><%=user.getId() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">조회수</th>
						<td class="col-4"><%=noticeBoard.getViewCount() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">내용</th>
						<td class="col-10 row-20"><%=noticeBoard.getContent() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="d-flex justify-content-between">
				<div>
<%
	if (loginedCustomerInfo != null && "admin".equals(loginedCustomerInfo.getUserType())) {
%>
					<a href="delete.jsp?no=<%=noticeBoard.getNo() %>&pageNo=<%=pageNo %>" class="btn btn-danger">삭제</a> 
					<a href="form.jsp" class="btn btn-warning">수정</a>
<%
	}
%>
				</div>
				<div>
					<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-primary">목록</a>
<%
	if (loginedCustomerInfo != null && "admin".equals(loginedCustomerInfo.getUserType())) {
%>
					<a href="form.jsp" class="btn btn-success">글쓰기</a>
<%
	}
%> 
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
