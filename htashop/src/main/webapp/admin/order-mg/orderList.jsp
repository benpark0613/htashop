<%@page import="com.shop.dto.OrderDto"%>
<%@page import="java.util.List"%>
<%@page import="utils.Pagination"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.shop.vo.CriteriaOrderList"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
<style type="text/css"> 
	a { 
		text-decoration:none;
		color : black;
	 } 
</style> 
</head>
<body>
<%@ include file="../../common/admin-navbar.jsp" %>		
<%
	pageContext.setAttribute("menu", "orderList");
	pageContext.setAttribute("leftMenu", "orderList");

	OrderListDao orderListDao = new OrderListDao();
	CriteriaOrderList criteria = new CriteriaOrderList();
	
	String pageNo = StringUtils.defaultString(request.getParameter("page"), "1");
	
    String orderOption = StringUtils.defaultString(request.getParameter("orderOption"), "");
    String userKeyword = StringUtils.defaultString(request.getParameter("userkeyword"), "");
    String term = StringUtils.defaultString(request.getParameter("term"), "");
    String state = StringUtils.defaultString(request.getParameter("state"), "");
    String productOption = StringUtils.defaultString(request.getParameter("productOption"), "");
    String productKeyword = StringUtils.defaultString(request.getParameter("productkeyword"), "");
    String orderDateBox = StringUtils.defaultString(request.getParameter("orderDateBox"), "");
    String orderDateBox2 = StringUtils.defaultString(request.getParameter("orderDateBox2"), "");
    
   	if (!StringUtils.isEmpty(orderOption) && !StringUtils.isEmpty(userKeyword)){
		criteria.setOrderOption(orderOption);
		criteria.setUserkeyword(userKeyword);
   	}
   	if(!StringUtils.isEmpty(state)){
		criteria.setState(state);
   	}
   	if(!StringUtils.isEmpty(term)){
		criteria.setTerm(term);
		
   	}
  
   	if(!StringUtils.isEmpty(productOption) && !StringUtils.isEmpty(productKeyword)){
		criteria.setProductOption(productOption);
		criteria.setProductkeyword(productKeyword);
   	}
   
	int totalRows = orderListDao.getTotalRows(criteria);

	Pagination pagination = new Pagination(pageNo, totalRows);

	criteria.setBeginIndex(pagination.getBegin());
	criteria.setEndIndex(pagination.getEnd());

	List<OrderDto> orderList = orderListDao.getOrderList(criteria);
%>
<div class="container">   
	<div class="row">
		<div class="col-2 min-vh-100 bg-light" id="sidebar">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		
		<div class="col-10">
		<h1>전체주문 조회</h1>
		<hr class="featurette-divider">

				<div class="container">
					<div class="row">
					
					
						<form id="form-search" method="get" action="orderList.jsp">
							<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">검색어</th>
										<td>
											<select id="orderOption" name="orderOption">
												<option value="주문번호" <%="주문번호".equals(orderOption) ? "selected" : "" %>>주문번호</option>
												<option value="주문자아이디" <%="주문자아이디".equals(orderOption) ? "selected" : "" %>>주문자 아이디</option>
												<option value="주문자명" <%="주문자명".equals(orderOption) ? "selected" : "" %>>주문자명</option>
												<option value="주문자연락처" <%="주문자연락처".equals(orderOption) ? "selected" : "" %>>주문자연락처</option>
											</select>
											<input type="text" id="user-keyword" name="userkeyword" value="<%=StringUtils.isBlank(userKeyword) ? "" : userKeyword %>" placeholder="검색어를 입력하세요">
										</td>
									</tr>
									<tr>
										<th scope="row">기간</th>
										<td>
											<select name="">
											<option>주문일</option>
											</select>
											<!-- 
											<select name="term">
												<option value="오늘" <%="오늘".equals(term) ? "selected" : "" %>>오늘</option>
												<option value="어제" <%="어제".equals(term) ? "selected" : "" %>>어제</option>
												<option value="3일" <%="3일".equals(term) ? "selected" : "" %>>3일</option>
												<option value="7일" <%="7일".equals(term) ? "selected" : "" %>>7일</option>
												<option value="15일" <%="15일".equals(term) ? "selected" : "" %>>15일</option>
												<option value="1개월" <%="1개월".equals(term) ? "selected" : "" %>>1개월</option>
												<option value="3개월" <%="3개월".equals(term) ? "selected" : "" %>>3개월</option>
												<option value="6개월" <%="6개월".equals(term) ? "selected" : "" %>>6개월</option>
											
											</select>
											 -->											
											 
											
											 
											<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
												<input type="radio" class="btn-check" value="전체"  id="전체" name="term" <%="전체".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="전체" >전체</label>
												
												<input type="radio" class="btn-check" value="오늘"  id="오늘" name="term" <%="오늘".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="오늘" >오늘</label>
												 
												<input type="radio" class="btn-check" value="어제" id="어제" name="term" <%="어제".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="어제">어제</label>
												 
												<input type="radio" class="btn-check" value="3일" id="3일" name="term" <%="3일".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="3일">3일</label>
												
												<input type="radio" class="btn-check" value="7일" id="7일" name="term" <%="7일".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="7일">7일</label>
												
												<input type="radio" class="btn-check" value="15일" id="15일" name="term" <%="15일".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="15일">15일</label>
												
												<input type="radio" class="btn-check" value="1개월" id="1개월" name="term" <%="1개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="1개월">1개월</label>
												
												<input type="radio" class="btn-check" value="3개월" id="3개월" name="term" <%="3개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="3개월">3개월</label>
												
												<input type="radio" class="btn-check" value="6개월" id="6개월" name="term" <%="6개월".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-primary" for="6개월">6개월</label>
											</div>
											  
										</td>
									</tr>
									<tr>
										<th scope="row">상품</th>
										<td>
											<select name="productOption">
											<option value="상품명" <%="상품명".equals(productOption) ? "selected" : "" %>>상품명</option>
											<option value="상품번호" <%="상품번호".equals(productOption) ? "selected" : "" %>>상품번호</option>
											</select>
											<input type="text" id="product-keyword" name="productkeyword" value="<%=StringUtils.isBlank(productKeyword) ? "" : productKeyword %>">
										</td>
									</tr>
									<tr>
										<th scope="row">주문상태</th>
										<td>
											<!-- 
											<select name="state">
												<option value="전체" <%="전체".equals(state) ? "selected" : "" %>>전체</option>
												<option value="상품준비중" <%="상품준비중".equals(state) ? "selected" : "" %>>상품준비중</option>
												<option value="배송대기" <%="배송대기".equals(state) ? "selected" : "" %>>배송대기</option>
												<option value="배송중" <%="배송중".equals(state) ? "selected" : "" %>>배송중</option>
												<option value="배송완료" <%="배송완료".equals(state) ? "selected" : "" %>>배송완료</option>
												<option value="입금전" <%="입금전".equals(state) ? "selected" : "" %>>입금전</option>
												<option value="결제완료" <%="결제완료".equals(state) ? "selected" : "" %>>결제완료</option>
											
											</select>
											 -->
											<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
												<input type="radio" class="btn-check" value="전체" id="전체" name="state" autocomplete="off" <%="전체".equals(state) ? "checked" : "" %>> 
													<label class="btn btn-outline-primary" for="전체">전체</label> 
												<input type="radio" class="btn-check" value="상품준비중" id="상품준비중" name="state" autocomplete="off" <%="상품준비중".equals(state) ? "checked" : "" %>> 
													<label class="btn btn-outline-primary" for="상품준비중">상품준비중</label>
												<input type="radio" class="btn-check" value="배송대기" id="배송대기" name="state" autocomplete="off" <%="배송대기".equals(state) ? "checked" : "" %>>
													<label class="btn btn-outline-primary" for="배송대기">배송대기</label>
												<input type="radio" class="btn-check" value="배송중" id="배송중" name="state" autocomplete="off" <%="배송중".equals(state) ? "checked" : "" %>>
													<label class="btn btn-outline-primary" for="배송중">배송중</label>
												<input type="radio" class="btn-check" value="배송완료" id="배송완료" name="state" autocomplete="off" <%="배송완료".equals(state) ? "checked" : "" %>>
													<label class="btn btn-outline-primary" for="배송완료">배송완료</label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="row text-center">
								<div class="col">
								<button class="btn btn-primary" onclick="searchBoards(1)">검색</button>
								<button class="btn btn-primary" type="reset" value="초기화">초기화</button>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="row">
					<h2>검색결과</h2>
					<div class="container">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">주문번호</th>
								<th scope="col">주문일자</th>
								<th scope="col">주문자</th>
								<th scope="col">상품정보</th>
								<th scope="col">수량</th>
								<th scope="col">상품구매금액</th>
								<th scope="col">주문처리상태</th>
							</tr>
						</thead>
						<tbody>
<%
	if (orderList.isEmpty()) {
%>
								<tr>
									<td colspan="5" class="text-center">주문내역이 없습니다.</td>
								</tr>
<%
	}else{
		for(OrderDto order : orderList){
%>								<tr>
									<th scope="row"><%=order.getOrderNo()%></th>
									<td><%=order.getOrderDate()%></td>
									<td><%=order.getUserName()%></td>
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
				
				</div>
				<div class="col text-center">
				<div class="container">
					<ul class="pagination justify-content-center">
					
						<li class="page-item <%=pagination.isExistPrev() ? "" : "disabled" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getPrevPage() %>)" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<%
							for(int no=pagination.getBeginPage(); no<=pagination.getEndPage(); no++){
							
						%>
						<li class="page-item <%=no == pagination.getPageNo() ? "active" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=no %>)"><%=no %></a>
						</li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getNextPage() %>)" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			</div>
		</div>
	
	</div> 

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
			function moveToPage(event, page){
				event.preventDefault();
				searchBoards(page);
			}
			
			function searchBoards(page){
					document.getElementById("page-field").value = page;
					var form = document.getElementById("form-search");
					form.submit();
			}		
		</script>
</body>
</html>