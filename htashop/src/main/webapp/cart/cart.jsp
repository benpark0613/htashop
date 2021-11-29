<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Cart</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/common.css">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico">
<style type="text/css">
/* CSS 작성 */
.titleArea h1 {
	margin: 0 0 30px;
	text-align: center;
}

.basketinfo .menu {
	text-align: center;
	border-bottom: 0.3px solid rgb(207, 207, 207);
	max-width: 180px;
	margin: 0 auto;
}

.basketinfo .menu p {
	font-size: 18px;
	margin: 20px 20px 12px;
	padding: 13px 10px 0px;
}

.removeBtn {
	text-align: center;
}

.removeBtn .textAndBtn {
	margin-right: 631px;
}

.removeBtn #removeAllBtn {
	background-color: rgb(207, 207, 207);
	cursor: pointer;
	color: rgb(13, 13, 13);
	width: 125px;
	height: 35px;
	padding: 6px 12px;
}

.removeBtn #removeAllBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}

.basket_btn {
	margin: 0 auto;
	width: 400px;
	height: 50px;
	font-size: 1.2em;
	cursor: pointer;
	padding: 12px 0;
	text-align: center;
	margin-top: 10px;
}

.basket_btn .submitAllBtn {
	font-weight: bold;
	color: rgb(13, 13, 13);
	background-color: rgb(171, 195, 159);
	padding: 11px 27px 11px;
	border: none;
}

.basket_btn .submitAllBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}

table {
	margin: 5px auto;
	border: 0.5px solid rgb(207, 207, 207);
	border-collapse: collapse;
	width: 900px;
}

th {
	height: 40px;
	border: 0.5px solid rgb(207, 207, 207);
	text-align: center;
}

td {
	height: 40px;
	border: 0.5px solid rgb(207, 207, 207);
	text-align: center;
}

.price .count {
	display: inline-block;
	position: relative;
	vertical-align: top;
}

.count #down .downBtn {
	position: static
}

.cartTable table {
	font-size: 13px;
}

.cartTable table input {
	text-align: center;
}

.name {
	cursor: pointer;
}

.name:hover {
	border-bottom: 1px solid rgb(207, 207, 207)
}

.cartTable .quantity button {
	padding: 4px 8px;
	margin: 8px 5px 8px;
	border : none;
}

.name, .price, .total {
	border: none;
	font-size: 15px;
}

.name, .price, .total:focus {
	outline: none;
}

.removeBtn #removeSelectBtn {
	background-color: rgb(207, 207, 207);
	cursor: pointer;
	color: rgb(13, 13, 13);
	padding: 6px 12px;
}
.removeBtn #removeSelectBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}

.quantity .upBtn {
	border: none;
}

.empty { 
	text-align: center;
}

/* cart만 고정 */
body {
	width: 100;
	margin: 0 auto;   
	height: 800px;  
}
#width {
	width: 1000px;
    margin: 0 auto; 
    text-align: center;
}
#selectedTotal{
	font-size: 15px;
	border:none;
	padding-left: 4px;
	line-height: 20px;
	cursor: text;
}
</style>
</head>
<body>
<div id="width">
	<div class="titleArea">
		<h1>Shopping Cart</h1>
	</div>
	<div class="basketinfo">
		<div class="menu">
			<p>국내배송상품</p>
		</div>
	</div>
	<br>
	<%-- 있으면 목록 출력 없으면 비어있음 표시--%>
		<div class="empty">
		<p>Your cart is empty</p>
		</div>

	<form id = "cartForm" class="cartTable" method="post" action = "/index.jsp?workgroup=minjeong&work=cart_submit">
		<div class="cartlist">
			
				<table>
					<tr>
						<th><input type="checkbox" id="allCheck" name="allcheck"></th>
						<th>Item</th>
						<th>Qty</th>
						<th>Price</th>
						<th>Delivery</th>
						<th>Total</th>
					</tr>

					<tr>
						<td>
							<input type="checkbox" name="checkP" value="" class="check">
							<input type="hidden" name="productIdx" value="">
						</td>
						<td>
							<input type="button" id="name" class="name" name="name" value="" >
						</td>
						<td id="quantity" class="quantity">
							<span class="count count-box"> 
							<div class="amount">
								<button class="minus">-</button>
								<input type="text" name="pop_out" value="1" id="pop_out">
							<button class="plus">+</button>
							</div>

						</td>
		
						<td>
							<input id="price" class="price" name="price" value="" readonly="readonly">
						</td>
						<td>기본배송</td>
						<td>
							<input id="total" class="total"
							value="" name="total" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td colspan="5">결제예정금액</td>
						<td><input id="selectedTotal" readonly="readonly" value="0"></td>
					</tr>
				</table>
		
			
			<br>
			<div class="removeBtn">
				<button type="button" id="removeSelectBtn" class="textAndBtn">선택상품 삭제하기</button>
				<button type="button" id="removeAllBtn">장바구니비우기</button>
			</div>
		</div>
		<br>
		<div class="basket_btn">
			<input type="submit" id="submitAllBtn" class = "submitAllBtn" value="주문하기">
		</div>
		</form>
</div>	
