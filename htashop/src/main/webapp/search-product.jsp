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
<div class="container">    
	<h1>상품명으로 검색하기</h1>
		
	<form class="d-flex" method="post" action="search-result.jsp">
    	<input type="text" name="searchProductName" placeholder="상품명을 입력하세요.">
      	<button class="btn btn-primary btn-sm" type="submit" >검색</button>
    </form>
	
	
	<!-- 
	검색기능 구현하기 
	검색결과가 없으면 '검색결과가 없습니다'
	결과가 있으면 search-product.jsp재요청하고 테이블 표시?
	-->
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>