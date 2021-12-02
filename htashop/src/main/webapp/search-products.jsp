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
<div class="container">    
	<h1>검색결과</h1>

	<!-- 
		검색기능 구현하기: search-result.jsp
		검색결과가 없으면 '검색결과가 없습니다'
		결과가 있으면 search-product.jsp재요청하고 테이블 표시?
	-->
	
<%
	// 사용자가 입력한 값을 꺼내기
	// 이름, 가격, 카테고리, 페이지
	int pageNo = Integer.parseInt(request.getParameter("page"));
	String name = request.getParameter("name");
	String searchProductPrice = request.getParameter("price");
	String searchProductCategory = request.getParameter("category");
	
	
	
	
%>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>