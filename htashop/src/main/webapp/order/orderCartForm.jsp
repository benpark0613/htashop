<%@page import="com.shop.dto.CartDto"%>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Checkout</title>
<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/checkout/">
<!-- Bootstrap core CSS -->
</head>

<body>
	<%@include file="../common/navbar.jsp"%>
	<div class="container ">
		<div class="row">
			<div class="col-2">
				<%@include file="../common/left.jsp" %>
			</div>
			<div class="col-10">
				<div class="row mb-3 p-3 border">
					<div class="col">
						<div class="py-5 text-center">
							<h1>
								<strong>ORDER PAGE</strong>
							</h1>
						</div>
						<h4 class=" mb-3">
							<strong>Orderer Information</strong>
						</h4>
						<div class="row g-3">
							<div class="col-sm-8">
								<label for="firstName" class="form-label">이름</label> 
								<input type="text" class="form-control" id="Name" value="<%=loginedUserInfo.getName()%>">
							</div>
							<div class="col-sm-8">
								<label for="firstName" class="form-label">등급</label> 
								<input type="text" class="form-control" id="Name" value="<%=loginedUserInfo.getGrade()%>">
							</div>
							<div class="col-8">
								<label for="email" class="form-label">전화번호 
								<span class="text-muted"></span></label> 
								<input type="Tel" class="form-control" id="Tel" value="<%=loginedUserInfo.getTel()%>">
							</div>
							<div class="col-8">
								<label for="address" class="form-label">주소</label> 
								<input type="text" class="form-control" id="address" value="<%=loginedUserInfo.getAddress()%>">
							</div>
						</div>
					</div>
				</div>
	
				<div class="row mb-3 p-3 border">
					<div class="col">
						<h4 class="mb-3">
							<strong>Cart Products</strong>
						</h4>
						<form method="post" action="orderCartExecute.jsp">
							<table class="table table-hover" id="cart">
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
<%
	// 1. 로그인된 사용자 번호를 조회한다.
	// 2. 장바구니 테니블에서 사용자번호로 등록된 모든 상품정보를 조회한다.
	// 3. 모든 상품 정보를 출력한다.
	
	List<CartDto> cartDtoList = CartDao.getInstance().getAllMyCarts(loginedUserInfo.getUserNo());
	int totalPrice = 0;
	for (CartDto item : cartDtoList) {
		totalPrice += item.getProductPrice()*item.getQuantity();
%>
								<tr>
									
									<td>
										<img src="/htashop/resources/images/<%=item.getProductImage()%>" style="widhth: 100px; height: 100px;" />
									</td>
									<td><%=item.getProductName() %></td>
									<td><%=item.getProductPrice() %>원</td>
									<td><%=item.getQuantity() %>개</td>
									<td><%=Math.round(item.getProductPrice()*item.getQuantity()*0.01) %>원</td>
									<td><%=item.getProductPrice()*item.getQuantity()%>원</td>
								</tr>
<%
	}
%>
								</tbody>
								<tfoot>
									<tr>
										<td></td>
										<td><strong>Total 결제금액: </strong></td>
										<td><%=totalPrice%>원</td>
									</tr>
								</tfoot>
							</table>
							<div class="text-center">
								<button class="w-50 btn btn-primary btn-lg mb-5" type="submit" >주문하기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
<%
	/*
		1. loginedUserInfo가 null이면 로그인폼으로 리다이렉션 시킨다.
		2. loginedUserInfo의 사용자정보를 아래에 표시한다.	
	*/
	if(loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}

	UserDao userDao = new UserDao();
	loginedUserInfo = userDao.getUserByNo(loginedUserInfo.getUserNo());

%>
		
	</div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" ></script>
	<script src="form-validation.js"></script>
</body>
</html>