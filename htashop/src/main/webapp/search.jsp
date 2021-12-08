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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/newstyle.css" rel="stylesheet" />
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
<title>HTA shop::상품검색</title>
</head>
<body>
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row mb-3">
		<div class="col-2">
			<%@ include file="../common/left.jsp"%>
		</div>
<%
	ProductDao productDao = ProductDao.getInstance();
	List<Product> productList = productDao.getAllProducts();
%>
		<div class="col-10 align-self-center">
			<div class="row mt-3 mb-3">
				<div class="col">
					<form class="d-flex justify-content-center" id="form-search" name="search" method="post" action="search.jsp">
						<!-- 검색 키워드 선택 -->
						<div class="col-5 mt-5">
							<input class="form-control" type="text" name="searchText" placeholder="찾으시는 상품명을 입력하세요." />
						</div>
						<div class="col-2 mt-5">
							<button class="btn btn-dark" type="submit">검색</button>
						</div>
						
						<!-- 
						검색키워드 변경시 옆에 셀렉트박스 내용도 바뀌는 부분
						<div>
							<div class="col">
								<select name="searchRequirement" onchange="categoryChange(this)">
									<option>조건선택</option>
									<option value="price">가격</option>
									<option value="category">카테고리</option>
								</select>
							
								<select id="requirement">
									<option></option>
								</select>
							</div>
						</div>
						 -->
						<!-- 검색어 입력필드 -->
					</form>
				</div>
			</div>
<%
	// 사용자가 입력한 값을 꺼내기
	// 검색하고자 하는 키워드를 선택한 후 입력창에 문자를 입력하고 검색버튼을 누른다.
	// 검색키워드 선택버튼 searchKeyword -> 이름, 가격, 카테고리 이거 중에서
	// 검색할 내용 입력하는 인풋필드 searchText -> '%사용자가 입력한 문자%'로 조회하기
	// db에서 조회하려면 키워드searchKeyword가 null이면 안되고(!=null) 사용자가 선택을 해야하며(!isempty)
	// 입력필드searchText도 null이면 안되고(!=null) 사용자가 문자를 입력해야 한다(!isempty).
	// 조건을 모두 만족하면 db에서 조회 시작
	String searchText = request.getParameter("searchText");
	
	List<Product> productResults = null;
	if (searchText != null && !searchText.isEmpty()) {
		productResults = productDao.getProductListBySearch(searchText);
%>
			<div class="row justify-content-center mt-5">
				<div class="col-10 justify-content-center mt-3">
					<table class="table">
						<thead>
							<tr class="d-flex">
								<th class="col-3">카테고리</th>
								<th class="col-4">상품명</th>
								<th class="col-3">가격</th>
								<th class="col-2">품절여부</th>
							</tr>
						</thead>
						<tbody>
<%
		for (Product product : productResults) {
%>
							<tr class="d-flex">
								<td class="col-3"><%=product.getCategory()%></td>
								<td class="col-4"><%=product.getName()%></td>
								<td class="col-3"><%=product.getPrice()%> 원</td>
								<td class="col-2"><%=product.isSoldOut()%></td>
							</tr>
<%
		}
%>
						</tbody>
					</table>
				</div>
			</div>
<%
	}
%>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 
<script>
	function categoryChange(e) {
		var requirement_price = ["낮은가격순", "높은가격순"];
		var requirement_category = ["TOP", "BOTTOM"];
		var target = document.getElementById("requirement");
		
		if (e.value == "price") var requirement = requirement_price;
		else if (e.value == "category") var requirement = requirement_category;
		
		target.options.length = 0;
		
		for (x in requirement) {
			var opt = document.createElement("option");
			opt.value = requirement[x];
			opt.innerHTML = requirement[x];
			target.appendChild(opt);
		}
	}
</script>
 -->
</body>
</html>