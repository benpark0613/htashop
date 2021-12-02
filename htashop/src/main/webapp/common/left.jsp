<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title></title>
</head>
<body>
<%
	String leftMenu = (String) pageContext.getAttribute("leftMenu");
%>
	<div id="page-wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li><a href="#">BEST 20</a></li>
				<li><a href="#">TOP</a></li>
				<li><a href="#">BOTTOM</a></li>
				<li><a href="/htashop/notice-board/list.jsp">NOTICE</a></li>
				<li><a href="/htashop/qa-board/list.jsp">Q&A</a></li>
				<li><a href="#">REVIEW</a></li>
			</ul>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>