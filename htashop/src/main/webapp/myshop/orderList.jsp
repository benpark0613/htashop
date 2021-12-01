<%@page import="java.util.List"%>
<%@page import="com.shop.dto.OrderDto"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp" %>
    
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
	<div class="container">
		<div class="row">

			<div class="col-1">
				<%@ include file="../common/left.jsp"%>

			</div>

			<div class="col-11">

				<table class="table">
					<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">상품정보</th>
							<th scope="col">수량</th>
							<th scope="col">상품구매금액</th>
							<th scope="col">주문처리상태</th>
						</tr>
					</thead>
					<%
						OrderDao orderDao = new OrderDao();
						List<OrderDto> orderList = orderDao.getOrderDetailList(loginedUserInfo.getUserNo());
						
						for (OrderDto order : orderList) {
					%>
					<tbody>
						<tr>
							<th scope="row"><%=order.getOrderNo()%></th>
							<td><%=order.getProductName()%></td>
							<td><%=order.getOrderCount()%></td>
							<td><%=order.getOrderTotalPrice()%></td>
							<td><%=order.getOrderState()%></td>
						</tr>
					</tbody>
					<%
						}
					%>
				</table>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>