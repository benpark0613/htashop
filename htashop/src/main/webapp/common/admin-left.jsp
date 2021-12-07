<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String leftMenu = (String)pageContext.getAttribute("leftMenu");
%>
<ul class="list-group mt-3">
<%
	if ("home".equals(leftMenu)) {
%>
		<li class="list-group-item"><a href="admin-index.jsp" class="link-dark nav-link align-middle <%="home".equals(leftMenu) ? "active" : "" %>">쇼핑몰 현황</a></li>
<%
	} else if ("customer-status".equals(leftMenu) || "customer-search".equals(leftMenu)) {
%>
		<li class="list-group-item <%="customer-status".equals(leftMenu) ? "fw-bold" : "" %>"><a href="customer-status.jsp" class="link-dark nav-link align-middle">회원현황</a></li>
		<li class="list-group-item <%="customer-search".equals(leftMenu) ? "fw-bold" : "" %>"><a href="customer-search.jsp" class="link-dark nav-link align-middle">회원정보조회</a></li>
<%
	// 상품관리파트 레프트메뉴
	} else if ("product-main".equals(leftMenu) || "product-modifyform".equals(leftMenu)) {
%>
		<li class="list-group-item <%="product-main".equals(leftMenu) ? "fw-bold" : "" %>"><a href="product-main.jsp" class="link-dark nav-link align-middle">상품현황</a></li>
		<li class="list-group-item <%="product-modifyform".equals(leftMenu) ? "fw-bold" : "" %>"><a href="product-modifyform.jsp" class="link-dark nav-link align-middle">상품수정</a></li>
<%
	}else if ("orderMain".equals(leftMenu)){
%>
		<li class="list-group-item"><a href="../order-mg/orderList.jsp" class="nav-link align-middle <%="home".equals(leftMenu) ? "active" : "" %>">전체주문조회</a></li>
<%
	}else if ("orderList".equals(leftMenu)){
%>
		<li class="list-group-item"><a href="../order-mg/main.jsp" class="nav-link align-middle <%="orderList".equals(leftMenu) ? "active" : "" %>">영업관리</a></li>
<%
	}
%>		

</ul>