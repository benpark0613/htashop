<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
    <% pageContext.setAttribute("menu", "notice"); %> <%@ include
    file="../common/navbar.jsp"%>
<div class="container">    
	<div class="row mb-3">
		<div class="col">
			<h1>삭제가 완료되었습니다.</h1>
			<a href="list.jsp" class="btn btn-primary">목록으로 돌아가기</a>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>