<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="com.shop.vo.User"%>
<%@page import="com.shop.dao.CartDao"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
   <link href="../resources/css/newstyle.css" rel="stylesheet">
    <title>HTA shop :: 장바구니 페이지</title>
</head>
<style>
img {width:50px; height:50px; }
</style>
<body>

<%
	pageContext.setAttribute("menu", "cart");
%>
<%@include file = "../common/navbar.jsp" %> 
<%//로그인 안하면 장바구니페이지로 이동 불가

	if(loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	CartDao cartDao = CartDao.getInstance();
	ProductDao productDao = ProductDao.getInstance();

	List<Cart> carts = cartDao.getAllCartListByUserNo(loginedUserInfo.getUserNo());
 %>
 
<div class="container">    
<div class="row justify-content-start">
	<div class="col-sm-2">
		<%@ include file="../common/left.jsp" %>
		</div>
		<div class="col-10 align-self-end">
			<div class="row mb-3">
				<div class="col-10 mb-3 ">
					<table class="col-10 table table-hover">
						<thead>
							
							<tr>
								<th></th>
								<th>이미지</th>
								<th>상품명</th>
								<th>상품가격</th>
								<th>수량</th>
								<th>예상적립금</th>
								<th>총 결제금액</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
<%
	for (Cart cart : carts) {
		Product product = productDao.getProductDetailById(cart.getProductNo());
%>						
						<tr>
							<td><input type="checkbox" id="ck-<%=cart.getCartNo() %>" name="no" value="<%=cart.getCartNo() %>"/></td>
							<td><img src="/htashop/resources/images/<%=product.getImage()%>"/></td>
							<td><%=product.getName() %></td>
							<td><%=product.getPrice() %>원</td>
							<td><div class="product-stock">
									<span class="minus" onclick="minus(<%=cart.getCartNo() %>)"></span>
									<input type="number" id="Qty-<%=cart.getCartNo() %>" class="count" value="<%=cart.getQuantity() %>" min="1" max="20" />
									<span class="plus" onclick="plus(<%=cart.getCartNo() %>)"></span>
								</div>
								<div>
									<button class="btn-modify" type="button" onclick="changeQty(<%=cart.getCartNo() %>)">변경</button>
								</div>
								</td>
							<td><%=product.getPrice() * cart.getQuantity() * 0.01 %>원</td>
							<td><%=product.getPrice() * cart.getQuantity()%>원</td>
							<td>
							<button type="button" class="btn btn-primary btn-sm" onclick="deleteCart(<%=product.getNo() %>)">삭제</button>
							</td>
						</tr>
<%
}
%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function deleteCart(productNo){
		location.href="deleteCart.jsp?productNo="+productNo;
	}
</script>
</body>
</html>