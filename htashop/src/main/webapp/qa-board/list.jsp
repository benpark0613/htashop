<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>qa 목록</title>
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

	<div class="row mb-3">
		<div class="row">
		<div class="col">
			<table class="table" border="1">
				<thead>
					<tr>
						<th>번호</th>
						<th>상품정보</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
<%
	QaBoardDao qaBoardDao = new QaBoardDao();
	List<QaBoard> qaBoardList = qaBoardDao.getAllQuestions();
%>					
<%
	for(QaBoard qaBoard : qaBoardList) {
%>						
					<tr>
						<td><%=qaBoard.getNo() %></td>
						<td><%=qaBoard.getProductNo() %></td>
						<td><%=qaBoard.getTitle() %></td>
						<td><%=qaBoard.getUserNo() %></td>
						<td><%=qaBoard.getRegdate() %></td>
					</tr>
<%
	}
%>					
				</tbody>			
			</table>
		</div>
		<div class="row mb-3">
			<div class="col">
				<form class="border p-3 bg-light" method="post" action="writeform.jsp">
					<button type="submit" style="text-align:center;" class="btn btn-primary">글쓰기</button>
				</form>
			
			</div>
		</div>
	</div>		
	</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>