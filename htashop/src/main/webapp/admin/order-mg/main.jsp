<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title></title>
<%@ include file="../../common/admin-navbar.jsp"%>
</head>
<%
pageContext.setAttribute("leftMenu", "orderMain");
%>
<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-2 min-vh-100 bg-light" id="sidebar">
				<%@ include file="../../common/admin-left.jsp"%>
			</div>
			<div class="col-10">
<%
	OrderListDao orderList = new OrderListDao();
	List<Order> orderListWeek = orderList.getOrderListByTerm("week");
	int totalOrderNumbersWeek = orderList.getOrderCountByTerm("week");
	List<Order> orderListToday = orderList.getOrderListByTerm("today");
	int totalOrderNumbersToday = orderList.getOrderCountByTerm("today");
	
	int totalOrderPriceToday = 0;
	int totalOrderPriceWeek = 0;
	
	for (Order orders : orderListWeek) {
		totalOrderPriceWeek += orders.getTotalPrice();
	}
	
	for (Order orders : orderListToday) {
		totalOrderPriceToday += orders.getTotalPrice();
	}
%>
				<div class="container">
					<p>실시간 매출현황</p>
					<hr class="featurette-divider">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">오늘</th>
								<th scope="col">일주일 간</th>
								<th scope="col">바로가기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>총 주문금액 (건수)</th>
								<td>
									<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&term=오늘&productOption=상품명&productkeyword=&state=전체상태"><%=totalOrderPriceToday%>원</a></strong></h4>
									<h5>(<%=totalOrderNumbersToday%>건)</h5>
								</td>
								<td>
									<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&term=7일&productOption=상품명&productkeyword=&state=전체상태"><%=totalOrderPriceWeek%>원</a></strong></h4>
									<h5>(<%=totalOrderNumbersWeek%>건)</h5>
								</td>
								<td>
									<a href="orderList.jsp"><button type="button" class="btn btn-dark">주문조회</button></a>
								</td>
							</tr>
						</tbody>
					</table>

					<hr class="featurette-divider">
					<div class="row">
						<div class="col">
							<h3>오늘의 할 일</h3>
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">입금전</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=입금전"><%=orderList.countOrderStatus("입금전")%>건</a></strong></h4>
										</td>
									</tr>
									<tr>
										<th scope="row">배송준비중</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=배송준비중"><%=orderList.countOrderStatus("배송준비중")%>건</a></strong></h4>
										</td>
									</tr>
									<tr>
										<th scope="row">배송중</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=배송중"><%=orderList.countOrderStatus("배송중")%>건</a></strong></h4>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col">
							<h3>오늘처리한 일</h3>
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">입금확인</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=입금완료"><%=orderList.countOrderStatus("입금완료")%>건</a></strong></h4>
										</td>
									</tr>
									<tr>
										<th scope="row">배송중처리</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=배송중"><%=orderList.countOrderStatus("배송중")%>건</a></strong></h4>
										</td>
									</tr>
									<tr>
										<th scope="row">배송완료</th>
										<td>
											<h4><strong><a href="orderList.jsp?page=1&orderOption=주문번호&userkeyword=&productOption=상품명&productkeyword=&state=배송완료"><%=orderList.countOrderStatus("배송완료")%>건</a></strong></h4>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>