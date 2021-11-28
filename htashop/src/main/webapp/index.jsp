<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductsDao"%>
<%@page import="com.shop.vo.Products"%>
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
<%@include file="common/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-sm-2 mt-3">
				<ul class="list-group">
					<li class="list-group-item">BEST 20</li>
					<li class="list-group-item">TOP</li>
					<li class="list-group-item">BOTTOM</li>
				</ul>
				<ul class="list-group mt-3">
					<li class="list-group-item">NOTICE</li>
					<li class="list-group-item">Q&A</li>
					<li class="list-group-item">REVIEW</li>
				</ul>
			</div>
			<div class="col-sm-10">
				<div class="row mt-10">
					<div class="col-4">
						<div class="card mt-3">
							<img src="resources/images/10kim1.jpg" class="card-img-top" />
							<div class="card-body">
								<h5 class="card-title text-center">상품이름</h5>
								<p class="card-text text-danger text-center">
									<strong class="fw-bold">상품가격</strong> 원
								</p>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card mt-3">
							<img src="resources/images/10kim1.jpg" class="card-img-top" />
							<div class="card-body">
								<h5 class="card-title text-center">상품이름</h5>
								<p class="card-text text-danger text-center">
									<strong class="fw-bold">상품가격</strong> 원
								</p>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card mt-3">
							<img src="resources/images/10kim1.jpg" class="card-img-top" />
							<div class="card-body">
								<h5 class="card-title text-center">상품이름</h5>
								<p class="card-text text-danger text-center">
									<strong class="fw-bold">상품가격</strong> 원
								</p>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card mt-3">
							<img src="resources/images/10kim1.jpg" class="card-img-top" />
							<div class="card-body">
								<h5 class="card-title text-center">상품이름</h5>
								<p class="card-text text-danger text-center">
									<strong class="fw-bold">상품가격</strong> 원
								</p>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card mt-3">
							<img src="resources/images/10kim1.jpg" class="card-img-top" />
							<div class="card-body">
								<h5 class="card-title text-center">상품이름</h5>
								<p class="card-text text-danger text-center">
									<strong class="fw-bold">상품가격</strong> 원
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>