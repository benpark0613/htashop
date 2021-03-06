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
										<option value="??????" <%="??????".equals(option) ? "selected" : "" %>>?????? ??????????????????</option>
										<option value="?????????" <%="?????????".equals(option) ? "selected" : "" %>>?????????</option>
										<option value="???????????????" <%="???????????????".equals(option) ? "selected" : "" %>>???????????????</option>
										<option value="?????????" <%="?????????".equals(option) ? "selected" : "" %>>?????????</option>
										<option value="????????????" <%="????????????".equals(option) ? "selected" : "" %>>????????????</option>
										<option value="??????" <%="??????".equals(option) ? "selected" : "" %>>??????</option>
										<option value="??????" <%="??????".equals(option) ? "selected" : "" %>>??????</option>
										<option value="??????" <%="??????".equals(option) ? "selected" : "" %>>??????</option>
									</select>
								</div>
								<div class="col-4">
									<div class="btn-group btn-group-sm" role="group" aria-label="Basic radio toggle button group">
												<input type="radio" class="btn-check" value="??????"  id="??????" name="term" <%="??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="??????" >??????</label>
												
												<input type="radio" class="btn-check" value="??????"  id="??????" name="term" <%="??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="??????" >??????</label>
												 
												<input type="radio" class="btn-check" value="1??????" id="1??????" name="term" <%="1??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="1??????">1??????</label>
												
												<input type="radio" class="btn-check" value="1??????" id="1??????" name="term" <%="1??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="1??????">1??????</label>
												
												<input type="radio" class="btn-check" value="3??????" id="3??????" name="term" <%="3??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="3??????">3??????</label>
												
												<input type="radio" class="btn-check" value="6??????" id="6??????" name="term" <%="6??????".equals(term) ? "checked" : "" %>> 
												<label class="btn btn-outline-secondary" for="6??????">6??????</label>
											</div>
								</div>
								<div class="col-1">
									<button type="button" class="btn btn-secondary" onclick="searchBoards(1)">??????</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="container">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">????????????</th>
								<th scope="col">????????????</th>
								<th scope="col">????????????</th>
								<th scope="col">??????</th>
								<th scope="col">??????????????????</th>
								<th scope="col">??????????????????</th>
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
							System.out.println(totalRecords);
							for(int no = pagination.getBeginPage(); no <= pagination.getEndPage(); no++){
						%>
						<li class="page-item <%=no == pagination.getPageNo() ? "active" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=no%>)"><%=no %></a>
						</li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getNextPage()%>)" aria-label="Next"> 
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