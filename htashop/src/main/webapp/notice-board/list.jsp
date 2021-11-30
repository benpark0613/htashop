<%@page import="com.shop.dto.NoticeBoardListDto"%>
<%@page import="utils.Pagination"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<title>NOTICE - htashop</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "notice");
	pageContext.setAttribute("leftMenu", "notice");
%>
<%@ include file="../common/navbar.jsp"%>
<%
	String pageNo = request.getParameter("pageNo");
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	List<NoticeBoardListDto> noticeBoards = noticeBoardDao.getNoticeBoardList(); 
	int totalRecords = noticeBoardDao.getTotalRecords();
	Pagination pagination = new Pagination(pageNo, totalRecords);
%>
	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp" %>
			</div>
			<div class="col-10">
				<div class="row mb-3" id="container_title">
					<div class="col">
						<h1 class="fs-3">NOTICE | 공지사항입니다.</h1>
					</div>
				</div>
				<div class="row mb-3" id="board_list">
					<div class="col">
						<table class="table">
							<thead>
								<tr>
									<th class="col-2">번호</th>
									<th class="col-6">제목</th>
									<th class="col-2">작성자</th>
									<th class="col-2">조회</th>
								</tr>
							</thead>
							<tbody>
<%
	if (noticeBoards.isEmpty()) {
%>
								<tr>
									<td class="text-center" colspan="6">게시글이 존재하지 않습니다.</td>
								</tr>
<%
	} else {
		for (NoticeBoardListDto dto : noticeBoards) {
%>
								<tr>
									<td class="col-2"><%=dto.getNoticeNo() %></td>
									<td class="col-6"><a href="detail.jsp?no=<%=dto.getNoticeNo() %>&pageNo=<%=pagination.getPageNo()%>"><%=dto.getNoticeTitle() %></a></td>
									<td class="col-2"><%=dto.getNoticeWriter() %></td>
									<td class="col-2"><%=dto.getNoticeViewCount() %></td>
								</tr>
		<%
				}
			}
		%>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-6 offset-3">
						<ul class="pagination justify-content-center">
							<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list?pageNo=<%=pagination.getPrevPage() %>">이전</a></li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
							<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num %>"><%=num %></a></li>
<%
	}
%>
							<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>"><a class="page-link" href="list?pageNo=<%=pagination.getNextPage() %>">다음</a></li>
						</ul>
					</div>
<%
	if (loginedUserInfo != null && "admin".equals(loginedUserInfo.getUserType())) {
%>
					<div class="col-3" id="board_write">
						<a href="form.jsp" class="btn btn-outline-primary">새 글</a>
					</div>
<%
	}
%>
				</div>
				<div class="row">
					<div class="col d-flex justify-content-center" id="board_search">
						<form action="" class="row row-cols-md-auto g-2 align-items-center">
							<div class="col-12">
								<select name="" id="" class="form-select">
									<option value="">제목</option>
									<option value="">내용</option>
									<option value="">글쓴이</option>
								</select>
							</div>
							<div class="col-12">
								<input type="text" value="검색어(필수)" class="form-control" />
							</div>
							<div class="col-12">
								<input type="submit" value="검색" class="btn btn-primary" />
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
