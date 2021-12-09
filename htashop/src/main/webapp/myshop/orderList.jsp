<%@page import="com.shop.vo.CriteriaOrderList"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@page import="com.shop.vo.Criteria"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
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
<link href="../resources/css/newstyle.css" rel="stylesheet">
<title></title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "order");

	OrderListDao orderListDao = new OrderListDao();
	CriteriaOrderList criteria = new CriteriaOrderList();
	
	String pageNo = StringUtils.defaultString(request.getParameter("page"), "1");
    String option = StringUtils.defaultString(request.getParameter("option"), "");
    String term = StringUtils.defaultString(request.getParameter("term"), "");
    
    if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(term)) {
      	criteria.setOption(option);
      	criteria.setTerm(term);
    }
	int totalRecords = orderListDao.getTotalRows(criteria, loginedUserInfo.getUserNo());
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
    criteria.setBeginIndex(pagination.getBegin());
    criteria.setEndIndex(pagination.getEnd());
    
    List<OrderDto> orderList = orderListDao.getOrderList(criteria, loginedUserInfo.getUserNo());
	
%>
	<div class="container">
		<div class="row">
			<div class="col-1">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-11">
				<div class="container py-4">
					<div class="bg-light rounded-3 text-center border">
					
						<form action="orderList.jsp" method="GET" id="form-search">
							<div class="card-body row ">
								<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
								<div class="col-2">
									<select class="form-select form-select-sm" id="search-option" aria-label=".form-select-sm example" name="option">
										<option value="전체" <%="전체".equals(option) ? "selected" : "" %>>전체 주문처리상태</option>
										<option value="입금전" <%="입금전".equals(option) ? "selected" : "" %>>입금전</option>
										<option value="배송준비중" <%="배송준비중".equals(option) ? "selected" : "" %>>배송준비중</option>
										<option value="배송중" <%="배송중".equals(option) ? "selected" : "" %>>배송중</option>
										<option value="배송완료" <%="배송완료".equals(option) ? "selected" : "" %>>배송완료</option>
										<option value="취소" <%="취소".equals(option) ? "selected" : "" %>>취소</option>
										<option value="교환" <%="교환".equals(option) ? "selected" : "" %>>교환</option>
										<option value="반품" <%="반품".equals(option) ? "selected" : "" %>>반품</option>
									</select>
								</div>
								<div class="col-4">
									<div class="btn-group btn-group-sm" role="group" aria-label="Basic radio toggle button group">
												<input type="radio" class="btn-check" value="전체"  id="전체" name="term" <%="전체".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="전체" >전체</label>
												
												<input type="radio" class="btn-check" value="오늘"  id="오늘" name="term" <%="오늘".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="오늘" >오늘</label>
												 
												<input type="radio" class="btn-check" value="1주일" id="1주일" name="term" <%="1주일".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="1주일">1주일</label>
												
												<input type="radio" class="btn-check" value="1개월" id="1개월" name="term" <%="1개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="1개월">1개월</label>
												
												<input type="radio" class="btn-check" value="3개월" id="3개월" name="term" <%="3개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="3개월">3개월</label>
												
												<input type="radio" class="btn-check" value="6개월" id="6개월" name="term" <%="6개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="6개월">6개월</label>
											</div>
								</div>
								<div class="col-1">
									<button type="button" class="btn btn-secondary" onclick="searchBoards(1)">조회</button>
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
								<th scope="col">주문일자</th>
								<th scope="col">상품정보</th>
								<th scope="col">수량</th>
								<th scope="col">상품구매금액</th>
								<th scope="col">주문처리상태</th>
							</tr>
						</thead>
						<tbody>
<%
	for (OrderDto order : orderList) {
%>						
							<tr>
								<th scope="row"><%=order.getOrderNo()%></th>
								<td><%=order.getOrderDate()%></td>
								<td><a id="new-link" href="../products/detail.jsp?productNo=<%=order.getProductNo() %>"><%=order.getProductName()%></a></td>
								<td><%=order.getOrderCount()%></td>
								<td><%=order.getOrderTotalPrice()%></td>
								<td><%=order.getOrderState()%></td>
							</tr>
<%
	}
%>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col text-center">
				<div class="container">
					<ul class="pagination justify-content-center">
						<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %> ">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getPrevPage()%>)" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<%
							for(int no = pagination.getBeginPage(); no <= pagination.getEndPage(); no++){
						%>
						<li class="page-item <%=no == pagination.getPageNo() ? "active" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=no%>)"><%=no %></a>
						</li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="" onclick="" aria-label="Next"> 
							<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	
		function moveToPage(event, page) {
			event.preventDefault();	
			searchBoards(page);
		}
		
		function searchBoards(page) {
			document.getElementById("page-field").value = page;
			var form = document.getElementById("form-search");
			form.submit();
		}  
	</script>
</body>
</html>