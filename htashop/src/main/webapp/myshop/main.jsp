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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
<link href="../resources/css/newstyle.css" rel="stylesheet">

<title>MYSHOP 메인페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "myshop");
	if (loginedUserInfo == null) {
		response.sendRedirect("../index.jsp?fail=unlogined");
		return;
	}
%>
		<div class="container">
			<div class="row">
				<div class="col-1">
					<%@ include file="../common/left.jsp"%>
				</div>
				<!-- 컨텐츠 -->
				<div class="col-11">
					<div class="row-3">
						<div class="py-4">
							<div class="container px-lg-5">
								<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
									<div class="m-4">
										<h6>
											<i class="far fa-id-badge fa-5x"></i>
											저희 쇼핑몰을 이용해 주셔서 감사합니다. <strong><%=loginedUserInfo.getName()%>님</strong>은 [<strong><%=loginedUserInfo.getGrade()%></strong>]회원이십니다.
										</h6>
									</div>
								</div>
							</div>
						</div>
					</div>
<%
	// expectedpoint를 다 더하기
	OrderDao orderDao = OrderDao.getInstance();
	List<OrderDto> orderList = orderDao.getOrderDetailList(loginedUserInfo.getUserNo());
	int totalPoint = 0;
	int usedPoint = 0;
	
	for (OrderDto orderDto : orderList) {
		totalPoint += orderDto.getExpectedpoint();
		usedPoint += orderDto.getUsedPoint();
	}
%>
					<div class="row-3">
						<div class="py-2">
							<div class="container px-lg-5">
								<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
									<div class="row">
										<div class="col-6">
											<h5>
												총 적립금 :<%=totalPoint%>원 <a class="btn btn-secondary btn-sm" href="point.jsp">조회</a>
											</h5>
											<h5>
												사용적립금 : <%=usedPoint%>원
											</h5>
										</div>
										<div class="col-6">
											<h5>
												가용적립금 : <%=totalPoint - usedPoint%>원
											</h5>
										</div>
									</div>
								</div>
							</div>
						</div>
<%
	int beforeDeposit = orderDao.countbeforeDeposit(loginedUserInfo.getUserNo());
	int cancel = orderDao.countCancel(loginedUserInfo.getUserNo());
	int exchange = orderDao.countExchange(loginedUserInfo.getUserNo());
	int preparingDelevery = orderDao.countPreparingDelevery(loginedUserInfo.getUserNo());
	int rtn = orderDao.countRtn(loginedUserInfo.getUserNo());
	int shippedComplete = orderDao.countShippedComplete(loginedUserInfo.getUserNo());
	int shipping = orderDao.countShipping(loginedUserInfo.getUserNo());
%>
						<div class="row-3">
							<div class="py-3">
								<div class="container px-lg-5">
									<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
										<div class="row text-left">
											<h5>나의 주문처리 현황</h5>
										</div>
										<hr class="featurette-divider">

										<div class="row">
											<div class="col">
												<h5>입금전</h5>
												<h4>
													<strong><a id="new-link" href="orderList.jsp?page=1&option=입금전&term=전체"><%=beforeDeposit%></a></strong>
												</h4>
											</div>
											<div class="col">
												<h5>배송준비중</h5>
												<h4>
													<strong><a id="new-link" href="orderList.jsp?page=1&option=배송준비중&term=전체"><%=preparingDelevery%></a></strong>
												</h4>
											</div>
											<div class="col">
												<h5>배송중</h5>
												<h4>
													<strong><a id="new-link" href="orderList.jsp?page=1&option=배송중&term=전체"><%=shipping%></a></strong>
												</h4>
											</div>
											<div class="col">
												<h5>배송완료</h5>
												<h4>
													<strong><a id="new-link" href="orderList.jsp?page=1&option=배송완료&term=전체"><%=shippedComplete%></a></strong>
												</h4>
											</div>
											<div class="col">
												<h6>
													취소 : <a id="new-link" href="orderList.jsp?page=1&option=취소&term=전체">[<%=cancel%>]
													</a>
												</h6>
												<h6>
													교환 : <a id="new-link" href="orderList.jsp?page=1&option=교환&term=전체">[<%=exchange%>]
													</a>
												</h6>
												<h6>
													반품 : <a id="new-link" href="orderList.jsp?page=1&option=반품&term=전체">[<%=rtn%>]
													</a>
												</h6>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row-3">
							<div class="col pt-4">
								<div class="container px-lg-5">
									<div class="row gx-lg-2">
										<div class="col-sm">
											<div class="card bg-light">
												<div class="card-body text-center">
													<i class="fas fa-gift fa-5x"></i>
													<h6 class="fs-4 fw-bold">Order</h6>
													<h5 class="fs-4 fw-bold">
														<a id="new-link" href="orderList.jsp">주문내역조회</a>
													</h5>
													<p class="mb-0">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다</p>
												</div>
											</div>
										</div>
										<div class="col-sm">
											<div class="card bg-light">
												<div class="card-body text-center">
													<i class="far fa-address-card fa-5x"></i>
													<h5 class="fs-4 fw-bold">Profile</h5>
													<h5 class="fs-4 fw-bold">
														<a id="new-link" href="userInfo.jsp">회원정보</a>
													</h5>
													<p class="mb-0">회원이신 고객님의 개인정보를 관리하는 공간입니다</p>
												</div>
											</div>
										</div>
										<div class="col-sm">
											<div class="card bg-light">
												<div class="card-body text-center">
													<i class="fas fa-coins fa-5x"></i>
													<h5 class="fs-4 fw-bold">Point</h5>
													<h5 class="fs-4 fw-bold">
														<a id="new-link" href="point.jsp">적립금</a>
													</h5>
													<p class="mb-0">적립금은 상품 구매시 사용하실 수 있습니다.</p>
												</div>
											</div>
										</div>
										<div class="col-sm">
											<div class="card bg-light">
												<div class="card-body text-center">
													<i class="far fa-edit fa-5x"></i>
													<h5 class="fs-4 fw-bold">Board</h5>
													<h5 class="fs-4 fw-bold">
														<a id="new-link" href="reviewManagement.jsp">게시물 관리</a>
													</h5>
													<p class="mb-0">고객님께서 작성하신 게시물을 관리하는 공간입니다.</p>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

