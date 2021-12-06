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
</head>
<%@ include file="../../common/admin-navbar.jsp" %>		
<body>
<%
	OrderListDao orderListDao = new OrderListDao();
	CriteriaOrderList criteria = new CriteriaOrderList();
	
	String pageNo = StringUtils.defaultString(request.getParameter("page"), "1");
    String orderOption = StringUtils.defaultString(request.getParameter("orderOption"), "");
    String state = StringUtils.defaultString(request.getParameter("state"), "");
    String pay = StringUtils.defaultString(request.getParameter("pay"), "");
    String orderTerm = StringUtils.defaultString(request.getParameter("term"), "");
    
    if (!StringUtils.isEmpty(orderOption) && !StringUtils.isEmpty(state) && !StringUtils.isEmpty(pay) && !StringUtils.isEmpty(orderTerm)) {
      	criteria.setOrderOption(orderOption);
      	criteria.setOrderTerm(orderTerm);
      	criteria.setState(state);
      	criteria.setPay(pay);
    }
	
    
	
	
%>
<div class="container">   
	<div class="row">
		<div class="col-1">
<%@ include file="../../common/admin-left.jsp" %>	
		</div>
		
		<div class="col-11">
		<h1>전체주문 조회</h1>
		<hr class="featurette-divider">

				<div class="container">
					<div class="row">
						<form id="form-search" method="get" action="orderList.jsp">
							<input type="hidden" id="page-field" name="page" value="">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">검색어</th>
										<td>
											<select name="orderOption">
												<option value="주문번호">주문번호</option>
												<option value="주문자아이디">주문자 아이디</option>
												<option value="주문자명">주문자명</option>
												<option value="주문자연락처">주문자연락처</option>
											</select>
											<input type="text" id="user-keyword" name="userkeyword">
										</td>
									</tr>
									<tr>
										<th scope="row">기간</th>
										<td>
											<select>
											<option>주문일</option>
											<option>배송시작일</option>
											<option>배송완료일</option>
											</select>
											<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
												<input type="radio" class="btn-check" value="오늘" id="order-term" name="term" autocomplete="off" checked> 
												<label class="btn btn-outline-primary" for="btnradio1">오늘</label> 
												<input type="radio" class="btn-check" value="어제" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio2">어제</label> 
												<input type="radio" class="btn-check" value="3일" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">3일</label>
												<input type="radio" class="btn-check" value="7일" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">7일</label>
												<input type="radio" class="btn-check" value="15일" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">15일</label>
												<input type="radio" class="btn-check" value="1개월" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">1개월</label>
												<input type="radio" class="btn-check" value="3개월" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">3개월</label>
												<input type="radio" class="btn-check" value="6개월" id="term" name="term" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">6개월</label>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">상품</th>
										<td>
											<select>
											<option>상품명</option>
											<option>상품번호</option>
											</select>
											<input type="text" id="product-keyword" name="productkeyword">
										</td>
									</tr>
									<tr>
										<th scope="row">주문상태</th>
										<td>
											<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
												<input type="checkbox" class="btn-check" value="전체" id="product-state" name="state" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btncheck1">전체</label> 
												<input type="checkbox" class="btn-check" value="상품준비중" id="product-state" name="state" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btncheck2">상품준비중</label>
												<input type="checkbox" class="btn-check" value="배송대기" id="product-state" name="state" autocomplete="off">
												<label class="btn btn-outline-primary" for="btncheck3">배송대기</label>
												<input type="checkbox" class="btn-check" value="배송중" id="product-state" name="state" autocomplete="off">
												<label class="btn btn-outline-primary" for="btncheck3">배송중</label>
												<input type="checkbox" class="btn-check" value="배송완료" id="product-state" name="state" autocomplete="off">
												<label class="btn btn-outline-primary" for="btncheck3">배송완료</label>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">입금 / 결제상태</th>
										<td>
											<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
												<input type="radio" class="btn-check" value="전체" id="product-state" name="pay" autocomplete="off" checked> 
												<label class="btn btn-outline-primary" for="btnradio1">전체</label> 
												<input type="radio" class="btn-check" value="입금전" id="product-state" name="pay" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio2">입금전</label> 
												<input type="radio" class="btn-check" value="결제완료" id="product-state" name="pay" autocomplete="off"> 
												<label class="btn btn-outline-primary" for="btnradio3">결제완료</label>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="row text-center">
								<div class="col">
								<button class="btn btn-primary" onclick="searchBoards(1)">검색</button>
								<button class="btn btn-primary" type="submit">초기화</button>
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
							<tr>
								<th scope="row"></th>
								<td></td>
								<td></td>
								<td></td>
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