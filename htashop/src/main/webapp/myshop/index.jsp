
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp"%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<title></title>
</head>
<body>
	<div class="container">

		<!-- 컨테이너 안에 큰 틀 -->
		<div class="row">
			<!-- 사이드바 위치 -->
			<div class="col-2">
				<%@ include file="../common/left.jsp"%>
			</div>

			<!-- content 위치 -->
			<div class="col-10">

				<!-- 1번 컨텐츠 -->
				<div class="row border">
					<span> 저희 쇼핑몰을 이용해 주셔서 감사합니다. <strong><%=loginedUserInfo.getName()%>님</strong>은
						[<strong><%=loginedUserInfo.getGrade()%></strong>]
						회원이십니다.
					</span>
				</div>

				<!-- 2번 -->
				<div class="row-mb-3 border">
					<h2 class="featurette-heading">
						총 적립금 :[<%=loginedUserInfo.getPoint()%>]원
					</h2>
					<button type="button" class="btn btn-secondary">조회</button>
					<h2 class="featurette-heading">사용적립금 :[]원</h2>
					<h2 class="featurette-heading">총주문 :[]원</h2>
				</div>
				<%
				/*
					OrderDao orderDao = new OrderDao();
					Order order = orderDao.getOrdersByNo(customer.getNo());

					if("입금전".equals(order.getState())){
						int cnt1 = 0;
						cnt1 ++;
					}
					if("배송준비중".equals(order.getState())){
						int cnt2 = 0;
						cnt2 ++;
					}
					if("배송중".equals(order.getState())){
						int cnt3 = 0;
						cnt3 ++;
					}
					if("배송완료".equals(order.getState())){
						int cnt4 = 0;
						cnt4 ++;
					}
					if("취소".equals(order.getState())){
						int cnt5 = 0;
						cnt5 ++;
					}
					if("교환".equals(order.getState())){
						int cnt6 = 0;
						cnt6 ++;
					}
					if("반품".equals(order.getState())){
						int cnt7 = 0;
						cnt7 ++;
					}
				*/
				OrderDao orderDao = new OrderDao();
				int beforeDeposit = orderDao.countbeforeDeposit(loginedUserInfo.getUserNo());
				int cancel = orderDao.countCancel(loginedUserInfo.getUserNo());
				int exchange = orderDao.countExchange(loginedUserInfo.getUserNo());
				int preparingDelevery = orderDao.countPreparingDelevery(loginedUserInfo.getUserNo());
				int rtn = orderDao.countRtn(loginedUserInfo.getUserNo());
				int shippedComplete = orderDao.countShippedComplete(loginedUserInfo.getUserNo());
				int shipping = orderDao.countShipping(loginedUserInfo.getUserNo());
				%>
				<!-- 환영합니다~ ~님 ~회원 -->
				<div class="row border">
					<div class="col">나의 주문처리 현황 (최근 3개월 기준)</div>
					<div class="col">
						입금전 :
						<%=beforeDeposit%></div>
					<div class="col">
						배송준비중 :
						<%=preparingDelevery%></div>
					<div class="col">
						배송중 :
						<%=shipping%></div>
					<div class="col">
						배송완료 :
						<%=shippedComplete%></div>
					<div class="col">
						취소 :
						<%=cancel%></div>
					<div class="col">
						교환 :
						<%=exchange%></div>
					<div class="col">
						반품 :
						<%=rtn%></div>
				</div>

				<!-- 환영합니다~ ~님 ~회원 -->
				<div class="row border">
					<div class="col">
						<div class="card" style="width: 18rem;">
							<i class="bi bi-person-square"></i>
							<div class="card-body">

								<h5 class="card-title">주문내역조회</h5>
								<p class="card-text">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</p>
								<a href="orderList.jsp" class="btn btn-primary">이동</a>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card bg-light border-0 h-100">
							<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
								<div
									class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
									<i class="far fa-address-card"></i>
								</div>
								<a href="customerInfo.jsp"><h2 class="fs-4 fw-bold">회원정보</h2></a>
								<p class="mb-0">회원이신 고객님의 개인정보를 관리하는 공간입니다.</p>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card bg-light border-0 h-100">
							<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
								<div
									class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
									<i class="bi bi-card-heading"></i>
								</div>
								<a href="point.jsp"><h2 class="fs-4 fw-bold">적립금</h2></a>
								<p class="mb-0">적립금은 상품 구매시 사용하실 수 있습니다.</p>
							</div>
						</div>
					</div>
					<div class="col">
						<div class="card bg-light border-0 h-100">
							<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
								<div
									class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
									<i class="bi bi-bootstrap"></i>
								</div>
								<a href="boardManagement.jsp"><h2 class="fs-4 fw-bold">게시물
										관리</h2></a>
								<p class="mb-0">고객님께서 작성하신 게시물을 관리하는 공간입니다.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<i class="far fa-address-card"></i>
		<i class="far fa-address-card"></i>
		<i class="far fa-address-card"></i>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
			