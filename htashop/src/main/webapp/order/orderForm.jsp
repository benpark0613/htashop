<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>Checkout</title>
	<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/checkout/">
     <!-- Bootstrap core CSS -->
</head>

<body>
<%@include file = "../common/navbar.jsp" %> 
<%
/*
	정보 받아오기
*/
	// 구매상품 정보
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));

	// 구매자 정보
	UserDao userDao = new UserDao();
	User user = userDao.getUserByNo(loginedUserInfo.getUserNo());
	
	// 받은 상품번호로 상품정보 조회 (이미지, 가격, 이름......)
	CartDao cartDao = CartDao.getInstance();

	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductDetailById(productNo);
	
/*
	받아온 정보로 화면에 출력하기.
*/	
	// 구매자 정보출력
	
	// 상품정보 출력.
	
%>
	<div class="container ">
		<div class="row">

			<div class="col-1"></div>

			<div class="col-9">

				<div class="py-5 text-center">
					<h1><strong>ORDER  PAGE</strong></h1>
				</div>
						<h4 class=" mb-3"><strong>Orderer Information</strong></h4>
						<form class="needs-validation" novalidate action="orderExev">
							<div class="row g-3">
								<div class="col-sm-8">
									<label for="firstName" class="form-label">이름</label> <input type="text" class="form-control" id="Name" value="<%=user.getName()%>">
						
								</div>
								<div class="col-sm-8">
									<label for="firstName" class="form-label">등급</label> <input type="text" class="form-control" id="Name" value="<%=user.getGrade()%>">
								</div>
								<div class="col-8">
									<label for="email" class="form-label">전화번호 <span class="text-muted"></span></label> <input type="Tel" class="form-control" id="Tel"value="<%=user.getTel()%>" >
							
								</div>
								<div class="col-8">
									<label for="address" class="form-label">주소</label> <input type="text" class="form-control" id="address" value="<%=user.getAddress()%>">
								</div>
							</div>
						   <h4 class=" mb-3"><strong>Cart Products</strong></h4>
							<table class="col-10 table table-hover" id="cart">
						    <thead>
						    	<tr>
									<th>이미지</th>
									<th>상품명</th>
									<th>상품가격</th>
									<th>수량</th>
									<th>예상적립금</th>
									<th>Total 가격</th>
								</tr>
						</thead>
						<tbody>
								<tr>
									<input type="hidden" name="productNo" value="<%=product.getNo() %>">
									<td><img src="/htashop/resources/images/<%=product.getImage()%>" style="widhth:100px; height:100px;"/></td>
									<td><%=product.getName() %></td>
									<td><%=product.getPrice() %>원</td>
									<td><%=quantity%>개</td>
									<td><%=Math.round(product.getPrice()*quantity*0.01) %>원</td>
									<td><%=product.getPrice()*quantity %>원</td>
								</tr>
						</tbody>	
						<tbody>
								<tr>
									<td></td>
									<td><strong>Total 결제금액: </strong></td>
									<td><%=product.getPrice()*quantity %>원</td>
								</tr>
						</tbody>	
						</table>		
						

							<button class="w-50 btn btn-primary btn-lg mb-5 type="submit" >주문하기</button>
						</form>
					</div>
				</div>
			</div>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	 <script src="form-validation.js"></script>
</body>
</html>