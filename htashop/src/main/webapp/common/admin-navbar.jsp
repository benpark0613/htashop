<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String menu = (String) pageContext.getAttribute("menu");
%>
<nav class="navbar navbar-expand navbar-dark bg-dark">
	<div class="collapse navbar-collapse">
	<div class="container">
		<ul class="navbar-nav me-auto">
			<li class="nav-item"><a class="nav-link <%="home".equals(menu) ? "active" : "" %>" href="/htashop/admin/admin-index.jsp">마이몰현황</a></li>
			<li class="nav-item"><a class="nav-link" href="/htashop/admin/store-mg/store-mg.jsp">상점관리</a></li>
			<li class="nav-item"><a class="nav-link" href="/htashop/admin/product-mg/product-mg.jsp">상품관리</a></li>
			<li class="nav-item"><a class="nav-link" href="/htashop/admin/order-mg/order-mg.jsp">주문관리</a></li>
<%
	if ("customer-status".equals(menu) || "customer-search".equals(menu)) {
%>
			<li class="nav-item"><a class="nav-link active" href="/htashop/admin/customer-mg/customer-status.jsp">고객관리</a></li>
<%
	} else {
%>
			<li class="nav-item"><a class="nav-link" href="/htashop/admin/customer-mg/customer-status.jsp">고객관리</a></li>
<%
	}
%>
			<li class="nav-item"><a class="nav-link" href="/htashop/admin/board-mg/board-mg.jsp">게시판관리</a></li>
		</ul>
	</div>
	</div>
</nav>