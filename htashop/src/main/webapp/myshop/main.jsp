<%@page import="com.shop.dto.OrderDto"%>
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
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">	
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
	

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<title></title>

<style type="text/css">
 a:link { color: red; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: blue; text-decoration: underline;}
</style>


</head>
<body>
<%
	pageContext.setAttribute("myshop", "home");
%>



	<div class="container">
<%
	if(loginedUserInfo == null){
		response.sendRedirect("../index.jsp?fail=unlogined");
		return;
	}
%>

		<!-- Header-->
		<div class="container">

			<div class="row">

				<div class="col-1">
					<!-- sidabar부분 -->
					<%@ include file="../common/left.jsp"%>
				</div>

				<!-- 컨텐츠 -->
				<div class="col-11">

					<div class="py-5">
						<div class="container px-lg-5">
							<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
								<div class="m-4">

									<h6>
										<i class="far fa-id-badge fa-5x"></i>저희 쇼핑몰을 이용해 주셔서 감사합니다.
										<strong><%=loginedUserInfo.getName()%>님</strong>은 
										[<strong><%=loginedUserInfo.getGrade()%></strong>]회원이십니다.
									</h6>
								</div>
							</div>
						</div>
					</div>
					<%
			// expectedpoint를 다 더하기
			OrderDao orderDao = new OrderDao();
			List<OrderDto> orderList = orderDao.getOrderDetailList(loginedUserInfo.getUserNo());
			int totalPoint = 0;
			int usedPoint = 0;

			for (OrderDto orderDto : orderList) {

				totalPoint += orderDto.getExpectedpoint();
				usedPoint += orderDto.getUsedPoint();
			}
			%>
					<div class="py-3">
						<div class="container px-lg-5">
							<div class="row p-4 p-lg-5 bg-light rounded-3 text-center border">
								<div class="col-6">
									<p class="fs-4">
										총 적립금 :[<%=totalPoint %>]원<a class="btn btn-primary btn-lg원" href="point.jsp">조회</a>
									</p>
									<p class="fs-4">사용적립금 : [<%=usedPoint %>]원</p>

								</div>
								<div class="col-6">
									<p class="fs-4">가용적립금 : [<%=totalPoint - usedPoint %>]원</p>
								</div>
							</div>

						</div>
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
	int beforeDeposit = orderDao.countbeforeDeposit(loginedUserInfo.getUserNo());
	int cancel = orderDao.countCancel(loginedUserInfo.getUserNo());
	int exchange = orderDao.countExchange(loginedUserInfo.getUserNo());
	int preparingDelevery = orderDao.countPreparingDelevery(loginedUserInfo.getUserNo());
	int rtn = orderDao.countRtn(loginedUserInfo.getUserNo());
	int shippedComplete = orderDao.countShippedComplete(loginedUserInfo.getUserNo());
	int shipping = orderDao.countShipping(loginedUserInfo.getUserNo());
%>
					<div class="py-3">
						<div class="container px-lg-5">
							<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
								<div class="row">
									<span>나의 주문처리 현황</span>
								</div>
								<div class="row">
									<div class="col">
										<h3>입금전 : [<%=beforeDeposit%>]</h3>
									</div>
									<div class="col">
										<h4>배송준비중 : [<%=preparingDelevery%>]</h4>
									</div>
									<div class="col">
										<h3>배송중 : [<%=shipping%>]</h3>
									</div>
									<div class="col">
										<h3>배송완료 : [<%=shippedComplete%>]</h3>
									</div>
									<div class="col">
										<h6>취소 : [<%=cancel%>]</h6>
										<h6>교환 : [<%=exchange%>]</h6>
										<h6>반품 : [<%=rtn%>]</h6>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Page Content-->
					<section class="pt-4">
						<div class="container px-lg-5">
							<!-- Page Features-->
							<div class="row gx-lg-5">
								<div class="col">
									<div class="card bg-light border-0 h-100">
										<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
											<div
												class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
											</div>
											<i class="fas fa-gift fa-5x"></i>
											<h2 class="fs-4 fw-bold">Order</h2>
											<h2 class="fs-4 fw-bold">
												<a href="orderList.jsp">주문내역조회</a>
											</h2>
											<p class="mb-0">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다</p>
										</div>
									</div>
								</div>
								<div class="col">
									<div class="card bg-light border-0 h-100">
										<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
											<div
												class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
											</div>
											<i class="far fa-address-card fa-5x"></i>
											<h2 class="fs-4 fw-bold">Profile</h2>
											<h2 class="fs-4 fw-bold">
												<a href="userInfo.jsp">회원정보</a>
											</h2>
											<p class="mb-0">회원이신 고객님의 개인정보를 관리하는 공간입니다</p>
										</div>
									</div>
								</div>
								<div class="col">
									<div class="card bg-light border-0 h-100">
										<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
											<div
												class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
											</div>
											<i class="fas fa-coins fa-5x"></i>
											<h2 class="fs-4 fw-bold">Point</h2>
											<h2 class="fs-4 fw-bold">
												<a href="point.jsp">적립금</a>
											</h2>
											<p class="mb-0">적립금은 상품 구매시 사용하실 수 있습니다.</p>
										</div>
									</div>
								</div>
								<div class="col">
									<div class="card bg-light border-0 h-100">
										<div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
											<div
												class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4">
											</div>
											<i class="far fa-edit fa-5x"></i>
											<h2 class="fs-4 fw-bold">Board</h2>
											<h2 class="fs-4 fw-bold">
												<a href="boardManagement.jsp">게시물 관리</a> 
											</h2>
											<p class="mb-0">고객님께서 작성하신 게시물을 관리하는 공간입니다.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>

				</div>

				<!-- row -->
			</div>

			<!-- container -->
		</div>

	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

