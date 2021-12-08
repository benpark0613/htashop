<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html;
charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>Order</title>
</head>
<body>
<%@include file="../common/navbar.jsp"%>
<% 
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity")); 
	
	UserDao userDao = new UserDao();
	User user = userDao.getUserByNo(loginedUserInfo.getUserNo()); 
	
	CartDao cartDao = CartDao.getInstance(); ProductDao productDao = ProductDao.getInstance();
 	Product product = productDao.getProductDetailById(productNo); 
%>
<div class="container">
	<div class="row">
		<div class="col-2">
			<%@ include file="../common/left.jsp"%></div>
		<div class="col-10">
			<form method="get" action="orderExecute.jsp">
				<div class="row">
					<div class="col">
						<h1 class="fs-6">
							<strong>ORDER PAGE</strong> | Orderer Information.
						</h1>
					</div>
					<hr />
				</div>
				<div class="row mb-4">
					<div class="row mb-2">
						<div class="col-2">
							<label for="firstName" class="col-form-label">이름</label>
						</div>
						<div class="col-4">
							<input type="text" class="form-control" id="Name" value="<%=user.getName()%>" />
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-2">
							<label for="firstName" class="col-form-label">등급</label>
						</div>
						<div class="col-4">
							<input type="text" class="form-control" id="Name" value="<%=user.getGrade()%>" />
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-2">
							<label for="email" class="col-form-label">전화번호 <span class="text-muted"></span></label>
						</div>
						<div class="col-4">
							<input type="Tel" class="form-control" id="Tel" value="<%=user.getTel()%>" />
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-2">
							<label for="address" class="col-form-label">주소</label>
						</div>
						<div class="col-4">
							<input type="text" class="form-control" id="address" value="<%=user.getAddress()%>" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<h1 class="fs-6">
							<strong>Cart Products</strong>
						</h1>
						<hr />
					</div>
				</div>
				<div class="row">
					<div class="col">
						<input type="hidden" name="productNo" value="<%=product.getNo() %>" />
						<table class="col-10 table table-hover" id="cart">
							<thead>
								<tr>
									<th class="col-2">이미지</th>
									<th class="col-2">상품명</th>
									<th class="col-2">상품가격</th>
									<th class="col-2">수량</th>
									<th class="col-2">예상적립금</th>
									<th class="col-2">Total 가격</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<img src="/htashop/resources/images/<%=product.getImage()%>" style="widhth: 100px; height: 100px" />
									</td>
									<td><%=product.getName() %></td>
									<td><%=product.getPrice() %>원</td>
									<td><%=quantity%>개</td>
									<td><%=Math.round(product.getPrice()*quantity*0.01) %>원</td>
									<td><%=product.getPrice()*quantity %>원
									</td>
								</tr>
							</tbody>
							<tbody>
								<tr>
									<th class="col-2 text-end" colspan="5">Total 결제금액:</th>
									<td class="col-4">
										<%=product.getPrice() * quantity%>원
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-2 offset-5">
					<div class="row">
						<button class="btn btn-secondary" type="submit">주문하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
