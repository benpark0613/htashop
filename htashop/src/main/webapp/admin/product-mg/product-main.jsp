<%@page import="utils.Pagination"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Favicon-->
	<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
	<!-- Bootstrap icons-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
	<title>관리자페이지::상품관리</title>
<style type="text/css"> 
	a { 
		text-decoration:none;
		color : black;
	 } 
</style> 
</head>
<body>
<%@ include file="../../common/admin-navbar.jsp" %>		
<%
	pageContext.setAttribute("menu", "productMain");
	pageContext.setAttribute("leftMenu", "productMain");
%>
<div class="container-fluid">
	<div class="row justify-content-center text-center mb-3">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		
			<div class="col-10 justify-content-center text-center mt-3">
				<!-- 상품현황 요약 -->
				<div class="row">
					<div class="col m-1 mt-5">
						<table class="table"> 
							<thead>
								<tr class="d-flex ">
									<th class="col-4">전체등록 상품</th>
									<th class="col-4">품절 상품</th>
									<th class="col-4">판매중 상품</th>
								</tr>
							</thead>

							<tbody>
								<tr class="d-flex">
<%
	ProductDao productDao = ProductDao.getInstance();
	int productCount = productDao.getTotalRecords();
	int soldOutCount = productDao.getCountSoldOut();	
	
%>
									<td class="col-4"><%=productCount %> 건</td>
									<td class="col-4"><%=soldOutCount %> 건</td>				
									<td class="col-4"><%=productCount - soldOutCount %> 건</td>				
								</tr>
							</tbody>
						</table>
<%

	String pageNo = request.getParameter("pageNo");
	int totalRecords = productDao.getTotalRecords();
	
	Pagination pagination = new Pagination(pageNo, totalRecords);
	List<Product> productList = productDao.getProductListByRN(pagination.getBegin(), pagination.getEnd());
%>		
						<!-- 전체상품정보 테이블 -->
						<table class="table mt-5">
							<thead>
								<tr class="d-flex">
									<th class="col-1">번호</th>
									<th class="col-2">카테고리</th>
									<th class="col-2">상품명</th>
									<th class="col-2">가격</th>
									<th class="col-2">재고</th>
									<th class="col-2">품절</th>
									<th class="col-1">수정</th>
								</tr>
							</thead>
							<tbody>
<%
		for (Product product : productList) {
%>
								<tr class="d-flex">
									<td class="col-1"><%=product.getNo() %></td>
									<td class="col-2"><%=product.getCategory() %></td>
									<td class="col-2"><a href="../../../htashop/products/detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=1 %>"><%=product.getName() %></a></td>
									<td class="col-2"><%=product.getPrice() %> 원</td>
									<td class="col-2"><%=product.getStock() %> 개</td>
<%
	String soldOut = Boolean.toString(product.isSoldOut());
	
			if (soldOut == "true") {
%>
								<td class="col-2 text-info"><strong><%=product.isSoldOut() %></strong></td>
<%
			} else {
%>
								<td class="col-2"><%=product.isSoldOut() %></td>
<%
			}
%>
								<td class="col-1"><a href="product-modifyform.jsp?productNo=<%=product.getNo() %>" class="btn-sm btn-secondary" type="button"><i class="bi bi-pencil"></i></a></td>
<%			
		}
%>			
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	
		<!-- 페이지네이션 -->
		<div class="row mt-5 mb-3">
			<div class="col-6 offset-3">
				<ul class="pagination justify-content-center">
					<!-- 이전버튼 -->
	   				<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>">
	     					<a class="page-link bg-white text-black" href="product-main.jsp?pageNo=<%=pagination.getPrevPage() %>" aria-label="Previous">
	       				<span aria-hidden="true">&laquo;</span>
	     					</a>
	   				</li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
    				<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link bg-white text-black" href="product-main.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>
   				<!-- 다음버튼 -->
	   				<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
	     					<a class="page-link bg-white text-black" href="product-main.jsp?pageNo=<%=pagination.getNextPage() %>" aria-label="Next">
	       				<span aria-hidden="true">&raquo;</span>
	     					</a>
	   				</li>
	  			</ul>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>