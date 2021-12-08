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
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row">
		<div class="col-2">
			<%@ include file="../common/left.jsp" %>
		</div>
		<div class="col-10">
			<div class="row">
				<h1 class="fs-1 text-center mt-5">주문이 완료되었습니다.</h1>
			</div>
			<div class="row mt-3">
				<div class="d-flex justify-content-center">
					<a href="/htashop/index.jsp" class="btn btn-primary">메인화면으로 돌아가기</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>