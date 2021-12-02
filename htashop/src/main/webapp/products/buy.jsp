<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>HTA shop::메인페이지</title>
</head>
<%
	pageContext.setAttribute("menu", "detail");
	pageContext.setAttribute("leftMenu", "notice");
%>
<body>
<%@include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row justify-content-end">
		<div  class="col-sm-2">
			<%@ include file="../common/left.jsp" %>
		</div>
		<div class="col-sm-10 align-self-end">
		
			<div class="row mb-3">
				<div class="col-sm-8 mb-2">
				
<%			
int no = Integer.parseInt(request.getParameter("no"));

// 게시글 정보를 제공하는 BoardDao객체를 획득한다.
ProductDao productDao = ProductDao.getInstance();	

// 게시글 번호에 해당하는 글 정보를 조회한다.
Product product = productDao.getProductDetailById(no);

int quantity = Integer.parseInt(request.getParameter("quantity"));

String name = product.getName();
int price = product.getPrice();
int total = price * quantity;
%>
			<table class="table">
				<thead>
					<tr class="d-flex">
						<th class="col-3 text-center">구매물품</th>
						<th class="col-2 text-center">가격</th>						
						<th class="col-2 text-center">수량</th>
						<th class="col-3 text-center">총금액</th>
					</tr>
				</thead>
				<tbody>							
					<tr class="d-flex">
						<td class="col-3 text-center"><%=name %></td>
						<td class="col-2 text-center"><%=price %> </td>
						<td class="col-2 text-center"><%=quantity %></td>
						<td class="col-3 text-center"><%=total %></td>
					</tr>					
				</tbody>				
			</table>
				</div>
			</div>
		</div>
	</div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




