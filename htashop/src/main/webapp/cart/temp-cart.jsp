
<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.dao.TempCartDao"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>HTA shop::장바구니페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "cart");
%>
<%@include file="../common/navbar.jsp"%>
<%
	TempCartDao tempCartDao = TempCartDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();
	
	List<Cart> carts = tempCartDao.getAllCartListByUserNo(loginedUserInfo.getUserNo());
%>
<div class="container">
	<div class="row justify-content-start">
		<div class="col-sm-2">
			<%@ include file="../common/left.jsp"%>
		</div>
		<div class="col-10 align-self-end">
			<div class="row mb-3">
				<div class="col-10 mb-3">
					<table class="col-10 table table-hover">
						<thead>
							<tr>
								<th>
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
										<label class="form-check-label" for="flexCheckDefault"> </label>
									</div>
								</th>
								<th>장바구니번호</th>
								<th>이미지</th>
								<th>상품명</th>
								<th>상품가격</th>
								<th>수량</th>
								<th>총 금액</th>
								<th>적립금</th>
								<th>배송여부</th>
							</tr>
						</thead>
						<tbody>
<%
	for (Cart cart : carts) {
		Product product = productDao.getProductDetailById(cart.getProductNo());
%>
							<tr>
								<td>
									<div class="form-check">
										<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
										<label class="form-check-label" for="flexCheckDefault"> </label>
									</div>
								</td>
								<td><%=cart.getCartNo()%></td>
								<td><img src="../resources/images/<%=product.getImage()%>" /></td>
								<td><%=product.getName()%></td>
								<td><%=product.getPrice()%></td>
								<td><%=cart.getQuantity()%></td>
								<td><%=product.getPrice() * cart.getQuantity()%></td>
								<td><%=product.getPrice() * cart.getQuantity() * 0.05%></td>
								<td>배송완료</td>
							</tr>
<%
	}
%>
						</tbody>
					</table>
					<div class="d-flex justify-content-end">
						<button class="btn btn-primary m-2">수정</button>
						<button class="btn btn-primary m-2">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>