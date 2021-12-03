<%@page import="utils.Pagination"%>
<%@page import="com.shop.dto.PointDto"%>
<%@page import="com.shop.vo.PointChange"%>
<%@page import="com.shop.dao.PointChangeDao"%>
<%@page import="com.shop.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.dto.OrderDto"%>
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
<%
PointChangeDao pointChangeDao = new PointChangeDao();
PointDto pointDto = pointChangeDao.getPointChangeByUserNo(loginedUserInfo.getUserNo());

String pageNo = request.getParameter("pageNo");

OrderDao orderDao = OrderDao.getInstance();

int totalRecords = orderDao.countAllOrders(loginedUserInfo.getUserNo());

Pagination pagination = new Pagination(pageNo, totalRecords);

List<OrderDto> orderList = orderDao.getOrdersByNoRN(loginedUserInfo.getUserNo(), pagination.getBegin(),
		pagination.getEnd());
%>
<body>
	<div class="container">
		<div class=row>

			<div class="col-1">
				<%@ include file="../common/left.jsp"%>

			</div>
			<%
			// expectedpoint를 다 더하기

			int totalPoint = 0;
			int usedPoint = 0;

			for (OrderDto orderDto : orderList) {

				totalPoint += orderDto.getExpectedpoint();
				usedPoint += orderDto.getUsedPoint();
			}
			%>
			<div class="col-10">
				<p>적립금 : 고객님의 사용가능 적립금 금액입니다.</p>

				<div class="row">
					<div class="row">
						총 적립금 : [<%=totalPoint%>]원
					</div>
					<div class="row">
						사용된 적립금 : [<%=usedPoint%>]원
					</div>
					<div class="row">
						사용가능 적립금 : [<%=totalPoint - usedPoint%>]원
					</div>
					<div class="row">미가용 적립금 : []원</div>

					<hr class="featurette-divider">



					<a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample"> 적립내역보기 </a> <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample1" role="button" aria-expanded="false" aria-controls="collapseExample"> 미가용적립내역보기 </a>

					<div class="collapse" id="collapseExample">
						<div class="card card-body">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">주문날짜</th>
										<th scope="col">총 적립금</th>
										<th scope="col">적립된 적립금(+)</th>
										<th scope="col">사용한 적립금(-)</th>
										<th scope="col">관련주문</th>
										<th scope="col">내용</th>
									</tr>
								</thead>
								<tbody>
									<%
									int currentPoint = 0;
									for (OrderDto orders : orderList) {
										currentPoint += orders.getExpectedpoint();
									%>
									<tr>
										<th scope="row"><%=orders.getOrderDate()%></th>
										<td><%=currentPoint - orders.getUsedPoint()%></td>
										<td><%=orders.getExpectedpoint()%></td>
										<td><%=orders.getUsedPoint()%></td>
										<td><%=orders.getProductName()%></td>
										<td><%=orders.getProductName()%>*<%=orders.getOrderCount()%>개
										</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
						<%

						%>
						<div class="col text-center">
				<div class="container">
					<ul class="pagination justify-content-center">
						<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %> ">
							<a class="page-link" href="point.jsp?pageNo=<%=pagination.getPrevPage() %>" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<%
							for(int no=pagination.getBeginPage(); no<=pagination.getEndPage(); no++){
							
						%>
						<li class="page-item <%=pagination.getPageNo() == no ? "active" : "" %>"><a class="page-link" href="point.jsp?pageNo=<%=no%>"><%=no %></a></li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="point.jsp?pageNo=<%=pagination.getNextPage() %>" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
					</div>

					<div class="collapse" id="collapseExample1">
						<div class="card card-body">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">주문날짜</th>
										<th scope="col">적립금</th>
										<th scope="col">관련주문</th>
										<th scope="col">사용가능예정일</th>
										<th scope="col">내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row"></th>
										<td></td>
										<td></td>
										<td></td>
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