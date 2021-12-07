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
	} else if ("product-main".equals(leftMenu) || "product-modify".equals(leftMenu)) {
%>
		<li class="list-group-item"><a href="product-main.jsp" class="nav-link align-middle <%="product-main".equals(leftMenu) ? "active" : "" %>">상품현황</a></li>
		<li class="list-group-item"><a href="product-modify.jsp" class="nav-link align-middle <%="product-main".equals(leftMenu) ? "active" : "" %>">상품수정</a></li>
<%
	}
%>

</ul>