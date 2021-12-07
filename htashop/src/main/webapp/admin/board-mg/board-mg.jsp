<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title></title>
</head>
    <style>
      table {
        width: 800px;
        height: 70px;
      }
      td, th {
        text-align: center;
      }
    </style>
<body>
<%
	pageContext.setAttribute("menu", "home");
	pageContext.setAttribute("leftMenu", "home");
%>


<%@ include file="../../common/admin-navbar.jsp" %>
<%
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	QaBoardDao qaBoardDao = QaBoardDao.getInstance();
	
%>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-10" id="main">
			<div class="row mt-3">
				<div class="col">게시판 목록</div>
			</div>
			<div class="row mt-1">
				<div class="col">
					<table class="col-10 table table-hover" id="boardAll">
						<thead>							
							<tr>								
								<th>게시판유형</th>
								<th>분류</th>
								<th>게시판제목</th>
								<th>권한(쓰기/읽기)</th>
								<th>새 게시글 / 총 게시물</th>
							</tr>
						</thead>
						<tbody>					
							<tr>
								<td>기본</td>
								<td>운영</td>
								<td><a href="../../notice-board/list.jsp">공지사항</a></td>
								<td>관리자 / 비회원</td>
								<td><%=noticeBoardDao.getTodayTotalRecords() %> / <%=noticeBoardDao.getTotalRecords() %></td>
							</tr>
							<tr>
								<td>기본</td>
								<td>상품</td>
								<td><a href="../../qa-board/list.jsp">상품 Q&A</a></td>
								<td>회원 / 비회원</td>
								<td><%=qaBoardDao.getTodayTotalRecords() %> / <%=qaBoardDao.getTotalRecords() %></td>
							</tr>
						
						</tbody>
					</table>	
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">


</script>
</body>
</html>