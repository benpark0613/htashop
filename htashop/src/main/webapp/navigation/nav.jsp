<%@page import="com.shop.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	Customer customer = (Customer)session.getAttribute("LOGINED_CUSTOMER");
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container-fluid">
		<a class="navbar-brand" href="/htashop/index.jsp">HTASHOP</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">

			<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
<%
	if(customer == null){
%>			
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="/htashop/login/loginForm.jsp">LOGIN</a></li>
				<li class="nav-item"><a class="nav-link" href="#!">JOIN</a></li>
<%
	}
%>				
				<li class="nav-item"><a class="nav-link" href="#!">CART -
						0(CART_NO)</a></li>
				<li class="nav-item"><a class="nav-link" href="#!">ORDER</a></li>
<%
	if(customer != null){
%>				
				<li class="nav-item"><a class="nav-link" href="/htashop/myshop/index.jsp">MYSHOP</a></li>
<%
	}
%>				
			</ul>

			<form class="d-flex">
				<a class="" href=""> <i class="bi bi-search lg"></i>
				</a>
			</form>
		</div>
	</div>
</nav>