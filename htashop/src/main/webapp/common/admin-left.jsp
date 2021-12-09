<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String leftMenu = (String)pageContext.getAttribute("leftMenu");
%>
<ul class="list-group mt-3">
<%
	// 고객관리
	if ("customerMain".equals(leftMenu) || "customer-search".equals(leftMenu)) {
%>
		<li class="list-group-item <%="customerMain".equals(leftMenu) ? "fw-bold" : "" %>"><a href="customer-status.jsp" class="link-dark nav-link align-middle">회원현황</a></li>
		<li class="list-group-item <%="customer-search".equals(leftMenu) ? "fw-bold" : "" %>"><a href="customer-search.jsp" class="link-dark nav-link align-middle">회원정보조회</a></li>
<%
	// 상품관리
	} else if ("productMain".equals(leftMenu)) {
%>
		<li class="list-group-item <%="productMain".equals(leftMenu) ? "fw-bold" : "" %>"><a href="product-main.jsp" class="link-dark nav-link align-middle">상품현황</a></li>
<%
	// 주문관리
	} else if ("orderMain".equals(leftMenu)) {
%>
		<li class="list-group-item <%="orderMain".equals(leftMenu) ? "fw-bold" : "" %>"><a href="main.jsp" class="link-dark nav-link align-middle">영업관리</a></li>
		<li class="list-group-item <%="orderList".equals(leftMenu) ? "fw-bold" : "" %>"><a href="orderList.jsp" class="link-dark nav-link align-middle">전체주문조회</a></li>
<%
	} else if ("orderList".equals(leftMenu)) {
%>
		<li class="list-group-item <%="orderMain".equals(leftMenu) ? "fw-bold" : "" %>"><a href="main.jsp" class="link-dark nav-link align-middle">영업관리</a></li>
		<li class="list-group-item <%="orderList".equals(leftMenu) ? "fw-bold" : "" %>"><a href="orderList.jsp" class="link-dark nav-link align-middle">전체주문조회</a></li>
<%
	// 게시판관리
	} else if ("boardMain".equals(leftMenu)) {
%>
		<li class="list-group-item"><a href="../board-mg/board-mg.jsp" class="fw-bold link-dark nav-link align-middle <%="orderList".equals(leftMenu) ? "active" : "" %>" >게시글 현황</a></li>
<%
	} else if("board-all".equals(leftMenu) || "board-ListAll".equals(leftMenu)) {
%>
		<li class="list-group-item <%="board-all".equals(leftMenu) ? "fw-bold" : "" %>"><a href="board-mg.jsp" class="link-dark nav-link align-middle">게시판 현황</a></li>
<% 		
	}
%>		

</ul>