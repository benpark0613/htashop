<%@page import="utils.Pagination_index"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="utils.Pagination" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>HTA shop::메인페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "home");
%>
<%@include file="common/navbar.jsp"%>
<div class="container">
	<div class="row justify-content-end">
		<div  class="col-sm-2">
			<%@ include file="common/left.jsp" %>
		</div>
<%
	ProductDao productDao = ProductDao.getInstance();
	List<Product> productList = productDao.getAllProducts();
%>		
		<div class="col-sm-10 align-self-end">
		
	<!-- 로그인 안하고 MYSHOP 접근했을 때 오류 표시 -->	
<%
	String failReason = request.getParameter("fail");
	if("unlogined".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">로그인 후 이용하세요!</div>
<%
	}
%>
			<div class="row mt-2">
<%
	// 페이징 처리하기
	
	// 인덱스에서 페이지부분을 누를때마다 pageNo라는 이름으로 현재페이지번호를 보낸다.
	// 페이지번호가 없으면 1로 되게 페이지네이션 유틸에 구현되어 있음
	String pageNo = request.getParameter("pageNo");
	
	// productdao 생성하고 전체 데이터 갯수 구하기
	int totalProductsRecord = productDao.getTotalRecords();
	
	// 페이지네이션 객체 생성: 조회한 현재 페이지 번호, 전체 데이터 갯수
	Pagination_index paginationIndex = new Pagination_index(pageNo, totalProductsRecord);

	// productDao의 getProductListByRN메소드 호출
	// 페이지네이션 안에서 현재 페이지 번호에 해당하는 범위를 계산함
	List<Product> products = productDao.getProductListByRN(paginationIndex.getBegin(), paginationIndex.getEnd());
	
	// 이제 products에 들어있는 상품정보를 화면에 출력
	for (Product product : products) {
%>
				<div class="col-sm-4 mb-3">
					<div class="card mt-3">
						<img src="resources/images/<%=product.getName() %>.jpg" class="card-img-top" />
						<div class="card-body">
							<!-- 클릭하면 상품상세정보페이지로 이동 -->
							<h5 class="card-title text-center"><%=product.getName() %></h5>
							<p class="card-text text-danger text-center">
								<strong class="fw-bold"><%=product.getPrice() %></strong> 원
							</p>
						</div>
					</div>
				</div>
<%
	}
%>					
			</div>
		</div>
		<!-- 페이지네이션 -->
		<div class="row mt-5 mb-3">
			<div class="col-6 offset-3">
				<ul class="pagination justify-content-center">
					<!-- 이전버튼 -->
    				<li class="page-item <%=!paginationIndex.isExistPrev() ? "disabled" : "" %>">
      					<a class="page-link" href="index.jsp?pageNo=<%=paginationIndex.getPrevPage() %>" aria-label="Previous">
        				<span aria-hidden="true">&laquo;</span>
      					</a>
    				</li>
<%
	for (int num = paginationIndex.getBeginPage(); num <= paginationIndex.getEndPage(); num++) {
%>
    				<li class="page-item <%=paginationIndex.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="index.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>
    				<!-- 다음버튼 -->
    				<li class="page-item <%=!paginationIndex.isExistNext() ? "disabled" : "" %>">
      					<a class="page-link" href="index.jsp?pageNo=<%=paginationIndex.getNextPage() %>" aria-label="Next">
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