<%@page import="com.shop.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.dto.OrderDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../navigation/nav.jsp" %>    
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<%
	OrderDao orderDao = new OrderDao();
	Order order = orderDao.getOrdersByNo(customer.getNo());
%>
<body>
	<div class="container">  
	
		<p>적립금 : 고객님의 사용가능 적립금 금액입니다.</p>
	  	<div class="row">
	  		총 적립금 : [<%=order.getExpectedPoint() %>]원
	  	</div>
	  	<div class="row">
	  		사용된 적립금 : [<%=order.getPointUsed() %>]원
	  	</div>
	  	<div class="row">
	  		사용가능 적립금 : []원
	  	</div>
	  	<div class="row">
	  		미가용 적립금 : [<%=order.getExpectedPoint() - order.getPointUsed() %>]원
	  	</div>
	  	
        <hr class="featurette-divider">
	  	
	  	
	  	
  <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    적립내역보기
  </a>
  <a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample1" role="button" aria-expanded="false" aria-controls="collapseExample">
    미가용적립내역보기
  </a>
  
<div class="collapse" id="collapseExample">
  <div class="card card-body">
	    <table class="table">
	  <thead>
	    <tr>
	      <th scope="col">주문날짜</th>
	      <th scope="col">적립금</th>
	      <th scope="col">관련주문</th>
	      <th scope="col">내용</th>
	    </tr>
	  </thead>
	  <tbody>
<%
	List<OrderDto> orderList = orderDao.getOrderDetail(customer.getNo());

	for(OrderDto orders : orderList){
%>	    
	    <tr>
	      <th scope="row"><%=orders.getOrderDate() %></th>
	      <td><%=orders.getExpectedpoint() %></td>
	      <td><%=orders.getProductName() %></td>
	      <td><%=orders.getProductName() %>*<%=orders.getOrderCount() %>개</td>
	    </tr>
<%
	}
%>	    
	  </tbody>
	</table>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>