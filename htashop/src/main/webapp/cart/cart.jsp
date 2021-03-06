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

	List<Cart> carts = cartDao.selectAllCartListByUserNo(loginedUserInfo.getUserNo());
 %>
<div class="container">    
<div class="row justify-content-start">
	<div class="col-sm-2">
		<%@ include file="../common/left.jsp" %>
		</div>
		<div class="col-10">
			<div class="row mb-3">
				<form id="form-cart" onsubmit="checkForm(event)" class="" method="post" action="../order/orderCartForm.jsp">
					<table class="col ms-1 table table-hover align-middle" id="cart">
						<thead>
							<tr class="text-center">
								<th style="width: 10%;">이미지</th>
								<th style="width: 20%;">상품명</th>
								<th style="width: 20%;">상품가격</th>
								<th style="width: 15%;">수량</th>
								<th style="width: 20%;">예상적립금</th>
								<th style="width: 10%;">결제금액</th>
								<th style="width: 5%;"></th>
							</tr>
						</thead>
						<tbody>
<%
	int totalOrderPrice = 0;
	for (Cart cart : carts) {
		Product product = productDao.getProductDetailById(cart.getProductNo());
		totalOrderPrice += product.getPrice() * cart.getQuantity();
%>						
							<tr class="text-center">
								<td style="width: 10%;"><img src="/htashop/resources/images/<%=product.getImage()%>"/></td>
								<td style="width: 20%;"><%=product.getName() %></td>
								<td style="width: 20%;"><%=product.getPrice() %>원</td>
								<td style="width: 15%;">
									<div class="">
										<span class="minus" onclick="minus(<%=cart.getCartNo() %>)"></span>
										<input type="number" id="Qty-<%=cart.getCartNo() %>" class="count" value="<%=cart.getQuantity() %>" min="1" max="20" />
										<span class="plus" onclick="plus(<%=cart.getCartNo() %>)"></span>
										<button class="btn-modify btn-dark btn-sm" type="button" onclick="changeQty(<%=cart.getCartNo() %>)">변경</button>
									</div>
								</td>
								<td style="width: 20%;"><%=Math.round(product.getPrice() * cart.getQuantity() * 0.01) %>원</td>
								<td style="width: 10%;"><%=product.getPrice() * cart.getQuantity()%>원</td>
								<td style="width: 5%;">
									<button type="button" class="btn btn-outline-dark btn-sm" onclick="deletedCart(<%=cart.getCartNo()  %>)">삭제</button>
								</td>
							</tr>
<%
	}
%>
						</tbody>
						<tfoot>
								<tr>
									<td class="text-end col-2" colspan="6"><strong>총 주문금액:</strong></td>
									<td class="text-end col-1"><%=totalOrderPrice %></td>
								</tr>
								<tr>
									<td class="text-end col-2" colspan="6"><strong>보유 포인트:</strong></td>
									<td class="text-end col-1" id="user-point"><%=loginedUserInfo.getPoint() %></td>
								</tr>
								<tr>
									<td class="text-end col-2" colspan="6"><strong>사용할 포인트:</strong></td>
									<td class="text-end col-1"><input type="number" id="use-point" name="pointUse" value="0" ></td>
								</tr>
						</tfoot>
					</table>
					<div class="alert alert-danger align-items-center" id="alert-error-point" role="alert" style="display:none;">사용할포인트가 보유포인트를 초과하지 않도록 입력해주세요.</div>
					<div class="text-center">
						<button class="btn btn-primary" type="submit">주문하기</button>
					</div>		
				</form>
			</div>
		</div>
	</div>
</div>		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
function plus(cartNo) {
	var count = Number(document.getElementById("Qty-" + cartNo).value);
	if(count < 20) {
		count ++;
	} else {
		count;
	}
	document.getElementById("Qty-" + cartNo).value = count;
}

function minus(cartNo) {
	var count = Number(document.getElementById("Qty-" + cartNo).value);
	if(count > 1) {
		count--;
	} else {
		count;
	}
	document.getElementById("Qty-" + cartNo).value = count;
}

function changeQty(cartNo) {
	var Qty = document.getElementById("Qty-" + cartNo).value;
	location.href = "changeQuantity.jsp?no=" + cartNo + "&quantity=" + Qty;
}

function deletedCart(cartNo) {
	location.href = "deleteCart.jsp?no=" + cartNo; 
}

<!-- TODO 사용할 포인트가 보유 포인트 보다 많으면 에러메세지를 띄워야한다. -->
// function기능을 쓰기 위해, 각각의 id를 꼭 부여해줘야한다.
function checkForm(event) {
	event.preventDefault();	// submit버튼을 클릭했을 때 폼의 입력값이 서버로 제출되는 동작이 일어나지 않게 한다.	
	var userPoint = parseInt(document.getElementById("user-point").textContent);	// 보유 포인트를 읽어서 숫자로 바꾼다.
	var usePoint = parseInt(document.getElementById("use-point").value);			// 입력필드에 입력된 사용할 포인트를 읽어서 숫자로 바꾼다.
	var alertElement = document.getElementById("alert-error-point");				// 경고를 표시하는 엘리먼트객체를 조회한다.
	var formElement = document.getElementById("form-cart");	// 폼엘리먼트를 조회한다.	
	if (usePoint > userPoint) {
		alertElement.style.display = "";	// 경고를 표시하는 엘리먼트가 화면에 표시되게 한다.
		return;
	}	
	alertElement.style.display = "none";	// 경고를 표시하는 엘리먼트가 화면에 표시되지 않게 한다.
	formElement.submit();					// 폼엘리먼트의 submit()메소드를 실행해서 폼입력값을 서버로 제출한다.	
}
</script>
</body>
</html>