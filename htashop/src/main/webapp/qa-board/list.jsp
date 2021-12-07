<%@page import="utils.Pagination"%>
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
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-10">
				<div class="row mb-3" id="container_title">
					<div class="col">
						<h1 class="fs-6">
							<strong>Q & A</strong> | 상품 Q&A입니다
						</h1>
					</div>
				</div>
				<%
				String fail = request.getParameter("fail");
				QaBoardDao qaBoardDao = QaBoardDao.getInstance();
				String pageNo = request.getParameter("pageNo");
				int totalRecords = qaBoardDao.getTotalRecords();

				// 페이징 처리 필요한 값을 계산하는 Pagination객체를 생성한다.
				Pagination pagination = new Pagination(pageNo, totalRecords);

				// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.

				List<QaBoard> qaBoardList = qaBoardDao.getAllQuestions(pagination.getBegin(), pagination.getEnd());
				%>
				<div class="row mb-3">
					<div class="row">
						<div class="col">
							<table class="table" border="1">
								<thead>
									<tr>
										<th>번호</th>
										<th>상품번호</th>
										<th>제목</th>
										<th>작성자번호</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>

									<%
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
										<td>
											<%=qaBoard.getNo()%>
										</td>
										<td>
											<a href="../products/detail.jsp?productNo=<%=qaBoard.getProductNo()%>&pageNo=<%=pagination.getPageNo()%>"><%=qaBoard.getProductNo()%></a>
										</td>
										<td>
											<a href="detail.jsp?no=<%=qaBoard.getNo()%>&pageNo=<%=pagination.getPageNo()%>"><%=qaBoard.getTitle()%></a>
										</td>
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
						<div class="row mb-3">
							<div class="col-6 offset-3">
								<nav>
									<ul class="pagination justify-content-center">
										<li
											class="page-item <%=!pagination.isExistPrev() ? "disabled" : ""%>"><a
											class="page-link"
											href="list.jsp?pageNo=<%=pagination.getPrevPage()%>">이전</a></li>
										<%
										// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
										%>
										<li
											class="page-item <%=pagination.getPageNo() == num ? "active" : ""%>"><a
											class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num%></a></li>
										<%
										}
										%>
										<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
										<li
											class="page-item <%=!pagination.isExistNext() ? "disabled" : ""%>"><a
											class="page-link"
											href="list.jsp?pageNo=<%=pagination.getNextPage()%>">다음</a></li>
									</ul>
								</nav>
							</div>
							<div class="col-3 text-end">
								<form class="border p-3 bg-light" method="post"
									action="writeform.jsp">
									<button type="submit" class="btn btn-primary">글쓰기</button>
								</form>
							</div>
						</div>
						<%
						if ("other".equals(fail)) {
						%>
						<div class="alert alert-danger">
							<strong>[작성자가 아닙니다.]</strong> 작성자 본인 또는 담당자만 문의를 확인 할 수 있습니다..
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>