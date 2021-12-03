<%@page import="com.shop.dto.OrderDto"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title></title>
</head>
<body>

	<div class="container">

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
			<tbody>

				<%
				String status = request.getParameter("status");
				String term = request.getParameter("term");

				System.out.println(status);
				System.out.println(term);

				OrderDao orderDao = OrderDao.getInstance();
				List<OrderDto> orderList = orderDao.getOrderDetailList(loginedUserInfo.getUserNo());
				String date = "";
				
				if("오늘".equals(term)){
					String dsa = null;
					
					
				}
				for (OrderDto order : orderList) {
					if (status.equals(order.getOrderState())) {
				%>

				<tr>
					<th scope="row"><%=order.getOrderNo()%></th>
					<td><%=order.getProductName()%></td>
					<td><%=order.getOrderCount()%></td>
					<td><%=order.getOrderTotalPrice()%></td>
					<td><%=order.getOrderState()%></td>
				</tr>
<%
					}
				}
%>
			</tbody>
		</table>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>