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
				<%@ include file="../common/left.jsp" %>
			</div>	
			<div class="col-10">
				<div class="row mb-3" id="container_title">
					<div class="col">
						<h1 class="fs-6"><strong>Q & A</strong> | 상품 Q&A입니다</h1>
					</div>
				</div>
		<div class="row mb-3">
			<div class="row">
				<div class="col">
					<table class="table" border="1">
						<thead>
							<tr>
								<th>번호</th>
								<th>상품명</th>
								<th>제목</th>
								<th>작성자번호</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<%
							QaBoardDao qaBoardDao = QaBoardDao.getInstance();
							List<QaBoard> qaBoardList = qaBoardDao.getAllQuestions();
							if (qaBoardList.isEmpty()) {
							%>
							<tr>
								<td class="text-center" colspan="6">게시글이 존재하지 않습니다.</td>
							</tr>
							<%
							} else {
							for (QaBoard qaBoard : qaBoardList) {
							%>
							<tr>
								<td><a href="detail.jsp?no=<%=qaBoard.getNo()%>"><%=qaBoard.getNo()%></a></td>
								<td><%=qaBoard.getProductNo()%></td>
								<td><%=qaBoard.getTitle()%></td>
								<td><%=qaBoard.getUserNo()%></td>
								<td><%=qaBoard.getRegdate()%></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				// 로그인되지 않은 경우 새 글 버튼이 출력되지않는다.
				if (loginedUserInfo != null) {
				%>
				<div class="row mb-3">
					<div class="col">
						<form class="border p-3 bg-light" method="post"
							action="writeform.jsp">
							<button type="submit" class="btn btn-primary">글쓰기</button>
						</form>

					</div>
				</div>
				<%
				}
				%>
				</div>
		</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>