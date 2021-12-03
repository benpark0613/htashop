<%@page import="utils.Pagination"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dto.OrderDto"%>
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
		<div class="row">

			<div class="col-1">
				<%@ include file="../common/left.jsp"%>

			</div>

			<div class="col-11">
				<div class="container">

					<div class="card">

						<div class="card-header">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active" aria-current="true" href="#1">주문내역조회</a></li>
								<li class="nav-item"><a class="nav-link" href="#content1">Link</a></li>
							</ul>
						</div>

						<form action="orderListSearch.jsp" method="GET" id="form-search">
							<div class="card-body" id="1">
								<div class="border">


									<input type="hidden" id="page-field" name="page" value="1">
									<select name="option">

										<option value="title">제목</option>
										<option value="writer">작성자</option>
										<option value="content">내용</option>
									</select>
									<input type="text" name="keyword">
									<button type="button" onclick="searchBoards(1)">검색</button>


									<div class="btn-group">
										<button class="btn btn-secondary btn-sm dropdown-toggle" name="status" type="button" data-bs-toggle="dropdown" aria-expanded="false">전체 주문처리상태</button>
										<ul class="dropdown-menu">
											<li><a class="dropdown-item" href="#">전체 주문처리상태</a></li>
											<li><a class="dropdown-item" href="#">입금전</a></li>
											<li><a class="dropdown-item" href="#">배송준비중</a></li>
											<li><a class="dropdown-item" href="#">배송중</a></li>
											<li><a class="dropdown-item" href="#">배송완료</a></li>
											<li><a class="dropdown-item" href="#">취소</a></li>
											<li><a class="dropdown-item" href="#">교환</a></li>
											<li><a class="dropdown-item" href="#">반품</a></li>
										</ul>
									</div>



									<div class="btn-group btn-group-sm" role="group" aria-label="Basic outlined example">

										<button type="button" class="btn btn-outline-primary">오늘</button>
										<button type="button" class="btn btn-outline-primary">1주일</button>
										<button type="button" class="btn btn-outline-primary">1개월</button>
										<button type="button" class="btn btn-outline-primary">3개월</button>
										<button type="button" class="btn btn-outline-primary">6개월</button>
									</div>


									<div class="btn-group btn-group-sm" role="group" aria-label="Basic radio toggle button group">
										<input type="radio" class="btn-check" name="term" id="btnradio1" autocomplete="off" checked> <label class="btn btn-outline-primary" for="btnradio1">오늘</label> <input type="radio" class="btn-check" name="term" id="btnradio2" autocomplete="off"> <label class="btn btn-outline-primary" for="btnradio2">1주일</label> <input type="radio" class="btn-check" name="term" id="btnradio3" autocomplete="off"> <label class="btn btn-outline-primary" for="btnradio3">1개월</label> <input type="radio" class="btn-check" name="term" id="btnradio1" autocomplete="off"> <label class="btn btn-outline-primary" for="btnradio1">3개월</label> <input type="radio" class="btn-check" name="term" id="btnradio2" autocomplete="off"> <label class="btn btn-outline-primary" for="btnradio2">6개월</label>
									</div>



									<div class="btn">
										<button type="button" class="btn btn-secondary" type="submit">조회</button>
									</div>

								</div>
							</div>
						</form>
					</div>
				</div>

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
						<%
						OrderDao orderDao = OrderDao.getInstance();
						//List<OrderDto> orderList = orderDao.getOrderDetailList(loginedUserInfo.getUserNo());
						
						int totalRecords = orderDao.countAllOrders(loginedUserInfo.getUserNo());
						String pageNo = request.getParameter("pageNo");
						Pagination pagination = new Pagination(pageNo, totalRecords);
												
						List<OrderDto> orders = orderDao.getOrdersByNoRN(loginedUserInfo.getUserNo(), pagination.getBegin(), pagination.getEnd());
						
						for (OrderDto order : orders) {
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
			<%
			
			
			%>
			<div class="col text-center">
				<div class="container">
					<ul class="pagination justify-content-center">
						<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %> ">
							<a class="page-link" href="orderList.jsp?pageNo=<%=pagination.getPrevPage() %>" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<%
							for(int no=pagination.getBeginPage(); no<=pagination.getEndPage(); no++){
							
						%>
						<li class="page-item <%=pagination.getPageNo() == no ? "active" : "" %>"><a class="page-link" href="orderList.jsp?pageNo=<%=no%>"><%=no %></a></li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="orderList.jsp?pageNo=<%=pagination.getNextPage() %>" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>