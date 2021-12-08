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
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>HTA shop::best20 페이지</title>
<style type="text/css"> 
a { text-decoration:none;
	color : black;
	 } 
</style>
</head>
<body>
<%
	pageContext.setAttribute("menu", "best20");
	pageContext.setAttribute("leftMenu", "best20");
%>
<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-sm-2">
				<%@ include file="../common/left.jsp" %>
			</div>		
<%
	ProductDao productDao = ProductDao.getInstance();
	List<Product> productList = productDao.getAllProducts();
%>		
				<div class="col-sm-10 align-self-end">
<%
	String failReason = request.getParameter("fail");
	if("unlogined".equals(failReason)){
%>
					<div class="alert alert-danger d-flex align-items-center" role="alert">로그인 후 이용하세요!</div>
<%
	}
%>
						<div class="row mt-2">
							<div class="row mb-3" id="container_title">
								<div class="col">
									<h1 class="fs-6"><strong>Best20</strong> | 가장 인기있는 20개의 제품입니다.</h1>
								</div>
						</div>
<%
	String pageNo = request.getParameter("pageNo");	
	int totalProductsRecord = 20;
	Pagination_index paginationIndex = new Pagination_index(pageNo, totalProductsRecord);
	List<Product> products = productDao.getProductListByBest20(paginationIndex.getBegin(), paginationIndex.getEnd());	
	for (Product product : products) {
%>
	<div class="col-sm-4 mb-3">
		<div class="card mt-3">
			<a href="../products/detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=1%>"><img src="../resources/images/<%=product.getImage() %>" class="card-img-top"/></a>
				</div>
					<div class="card-body">
						<h5 class="card-title text-center"><a href="../products/detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=1%>"><%=product.getName() %></a></h5>
						<p class="card-text text-danger text-center"><strong class="fw-bold"><%=product.getPrice() %></strong> 원</p>
					</div>
				</div>
<%
	}
%>					
			</div>
		</div>
	</div>
	<!-- 페이지네이션 -->
	<div class="row mt-5 mb-3">
		<div class="col-6 offset-3">
			<ul class="pagination justify-content-center">
				<!-- 이전버튼 -->
   				<li class="page-item <%=!paginationIndex.isExistPrev() ? "disabled" : "" %>">
     					<a class="page-link bg-white text-black" href="best20Index.jsp?pageNo=<%=paginationIndex.getPrevPage() %>" aria-label="Previous">
       						<span aria-hidden="true">&laquo;</span>
     					</a>
   				</li>
<%
	for (int num = paginationIndex.getBeginPage(); num <= paginationIndex.getEndPage(); num++) {
%>
    			<li class="page-item <%=paginationIndex.getPageNo() == num ? "active" : "" %>"><a class="page-link bg-white text-black" href="best20Index.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>
   				<!-- 다음버튼 -->
   				<li class="page-item <%=!paginationIndex.isExistNext() ? "disabled" : "" %>">
     					<a class="page-link bg-white text-black" href="best20Index.jsp?pageNo=<%=paginationIndex.getNextPage() %>" aria-label="Next">
       						<span aria-hidden="true">&raquo;</span>
     					</a>
   				</li>
  			</ul>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>