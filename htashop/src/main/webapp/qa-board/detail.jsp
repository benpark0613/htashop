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
	qaBoard = qaBoardDao.getQuestionDetail(no);
	
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
//여기서부터 @@@@
			if("admin".equals(loginedUserInfo.getId()) ){
				if(qaBoard.getAnswer() != null && qaBoard.getAnswer().isBlank()){
%>
				<form action="qnswer.jsp">
					<label class="col-1 col-form-label text-front" for="qa-answer">댓글</label>
					<input class="form-control" name="qa-answer" id="qa-answer"></input>
					<button type="submit" class="btn btn-primary" name="select" value="insert">등록</button>
				</form>
				
<%					
				}else{
%>					<form action="answer.jsp">
						<table class="table">
							<tr class="d-flex">
								<th class="col-2">댓글</th>
								<td class="col-4"><%=qaBoard.getAnswer() %></td>
							</tr>
						</table>
						<a href="answer.jsp" class="btn btn-primary " name="select" type="button" value="delete">삭제</a>
						<button type="submit" class="btn btn-primary" name="select" value="modify">수정</button>
					</form>
<%				
				}
			}
//@@@여기까지 완전 다시해야함
%>		
		</div>
	</div>
	
		
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>