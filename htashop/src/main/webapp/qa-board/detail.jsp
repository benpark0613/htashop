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
    <title></title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
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

	QaBoard qaBoard = new QaBoard();
	QaBoardDao qaBoardDao = new QaBoardDao();
	qaBoard = qaBoardDao.getQuestionByNo(no);
	
	if(loginedUserInfo.getId().equals(qaBoard.getUserId()) || "admin".equals(qaBoard.getUserId())){
%>	
	
			<table class="table">
				<tbody>
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
						<td class="col-10"><%=qaBoard.getContent() %></td>
					</tr>
				</tbody>				
			</table>
<%
			if("admin".equals(qaBoard.getUserId())){
%>				
					<form action="register">
						<div class="mb-3">
							<label class="col-1 col-form-label text-front">댓글</label>
							<textarea rows="6" class="form-control" name="answer"></textarea>
						</div>
					</form>
<%
			}
%>	
<%
	}else{
%>
		<p><%=loginedUserInfo.getId() %></p>
		<p><%=qaBoard.getUserId() %></p>
<%		
	response.sendRedirect("list.jsp");
	}
%>	
		
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>