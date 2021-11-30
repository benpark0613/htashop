<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
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
	ProductDao productDao = new ProductDao();
	List<Product> productList = productDao.getAllProducts();
%>		
		<div class="col-sm-10 align-self-end mt-4">
			<div class="row mb-3">
<%
	for (Product product : productList) {
%>
				<div class="col-sm-4 mb-3">
					<div class="card mt-4">
						<img src="resources/images/<%=product.getName() %>.jpg" class="card-img-top" />
						<div class="card-body">
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
<!-- 페이지네이션........ -->
		<div class="row mb-5">
			<div class="col-6 offset-3">
				<ul class="pagination justify-content-center">
				
    				<li class="page-item">
      					<a class="page-link" href="#" aria-label="Previous">
        				<span aria-hidden="true">&laquo;</span>
      					</a>
    				</li>
    				
    				<li class="page-item"><a class="page-link" href="#">1</a></li>
    				<li class="page-item"><a class="page-link" href="#">2</a></li>
    				<li class="page-item"><a class="page-link" href="#">3</a></li>
    				
    				<li class="page-item">
      					<a class="page-link" href="#" aria-label="Next">
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