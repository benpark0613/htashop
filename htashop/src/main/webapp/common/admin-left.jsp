<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String leftMenu = (String)pageContext.getAttribute("leftMenu");
%>
<!-- 상단 네비 메뉴 마다 레프트 메뉴가 달라진다. 레프트 메뉴 기본형식을 유지하며 조건에 따라 레프트 메뉴를 표시해야 한다. 
<ul class="list-group mt-3">
	<li class="list-group-item"><a href="#" class="nav-link align-middle">Home</a></li>
	<li class="list-group-item"><a href="#" class="nav-link align-middle"><span class="ms-1 d-none d-sm-inline">Home</span></a></li>
	<li class="list-group-item"><a href="#" class="nav-link align-middle"><span class="ms-1 d-none d-sm-inline">Home</span></a></li>
</ul>
 -->
 
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
	}
%>
</ul>