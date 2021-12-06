<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
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
		사용자는 검색하고자 하는 키워드를 선택한 후 입력창에 문자를 입력하고 검색버튼을 누른다.
		검색키워드 선택버튼 searchKeyword -> 이름, 가격, 카테고리 이거 중에서
		검색할 내용 입력하는 인풋필드 searchText -> '%사용자가 입력한 문자%'로 조회하기
		db에서 조회하려면 키워드searchKeyword가 null이면 안되고(!=null) 사용자가 선택을 해야하며(!isempty)
		입력필드searchText도 null이면 안되고(!=null) 사용자가 문자를 입력해야 한다(!isempty).
		조건을 모두 만족하면 db에서 조회 시작
	-->
	
<%
	//사용자가 입력한 값을 꺼내기
	// 사용자는 검색하고자 하는 키워드를 선택한 후 입력창에 문자를 입력하고 검색버튼을 누른다.
	// 검색키워드 선택버튼 searchKeyword -> 이름, 가격, 카테고리 이거 중에서
	// 검색할 내용 입력하는 인풋필드 searchText -> '%사용자가 입력한 문자%'로 조회하기
	// db에서 조회하려면 키워드searchKeyword가 null이면 안되고(!=null) 사용자가 선택을 해야하며(!isempty)
	// 입력필드searchText도 null이면 안되고(!=null) 사용자가 문자를 입력해야 한다(!isempty).
	// 조건을 모두 만족하면 db에서 조회 시작
	
	// 1. 사용자가 입력한 값을 꺼내기
	String searchKeyword = request.getParameter("searchKeyword");	// 셀렉트박스부분
	String searchText = request.getParameter("searchText");			// 인풋필드부분, 사용자가 입력하는 부분

	// db에서 조회하기 위해 dao 생성
	ProductDao productDao = ProductDao.getInstance();
	List<Product> results = null;
	
	// 검색조건, 검색어가 다 입력되어 있을 때
	if (searchKeyword != null && !searchKeyword.isEmpty() && searchText != null && !searchText.isEmpty()) {
		results = productDao.getProductListBySearch(searchKeyword, searchText);
	} else {
		response.sendRedirect("search.jsp?fail=noResults");
	}
	
	
	

	
	
%>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>