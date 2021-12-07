<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>qa 목록</title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row mb-3">
		<div class="col-2">
			<%@ include file="../common/left.jsp"%>
		</div>
		<div class="col">
			<div class="row mb-3">
				<div class="col">
			<h4>
				<font color=#777777>Q & A</font> |
				상품 Q&A입니다.
			</h4>
				</div>
				</div>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");

	QaBoardDao qaBoardDao = QaBoardDao.getInstance();
	QaBoard qaBoard = qaBoardDao.getQuestionByNo(no);
	
	if(loginedUserInfo!= null &&( qaBoard.getUserId().equals(loginedUserInfo.getId()) || "admin".equals(loginedUserInfo.getId()))){
%>	
		<div class="col">
			<table class="table border p-3 bg-light">
				<tbody>
					<tr class="d-flex">
						<th class="col-2">게시글 번호</th>
						<td class="col-4"><%=qaBoard.getNo() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">제목</th>
						<td class="col-4"><%=qaBoard.getTitle() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">작성자</th>
						<td class="col-4"><%=qaBoard.getUserName() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">작성일</th>
						<td class="col-4"><%=qaBoard.getRegdate() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">내용</th>
						<td class="col-10" ><%=qaBoard.getContent() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">댓글</th>
						<td class="col-10"><%=qaBoard.getReply() %></td>
					</tr>
				</tbody>	
			</table>
			</div>
				
			</div>
		</div>
			<div class="mb-3 text-end">
				<a  href="modifyform.jsp?no=<%=qaBoard.getNo()%>&pageNo=<%=pageNo %>"" class="btn btn-dark">수정</a>
				<a  href="remove.jsp?no=<%=qaBoard.getNo()%>&pageNo=<%=pageNo %>"" class="btn btn-dark">삭제</a>
			</div>
			<form method="post" action="reply.jsp">
				<input type="hidden" name="no" value="<%=qaBoard.getNo()%>">
				<div class="mb-3">
					<label class="col-1 col-form-label text-front" >댓글</label>
					<textarea rows="6" class="form-control" name="reply"></textarea>
				</div>
				<div class="row mb-3">
					<div class="col">
						<div class="mb-3 text-end">
							<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-secondary" >목록</a>
							<button type="submit" class="btn btn-primary" name=>등록</button>
						</div>
					</div>
				</div>
			</form>
<%
	}else if(loginedUserInfo== null){
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}else if(!qaBoard.getUserId().equals(loginedUserInfo.getId()) || !"admin".equals(loginedUserInfo.getId())){
		response.sendRedirect("list.jsp?fail=other");
		return;
	}
%>	
		

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>