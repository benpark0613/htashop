
<%@page import="com.shop.vo.Product" %>
<%@page import="com.shop.dao.ProductDao" %>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>장바구니에 등록</title>
</head>
<body>
<div class="container">    
<%
	String id = request.getParameter("id");
	if (id == null || id.trim().equals("")) {
		response.sendRedirect("index.jsp");
		return;
	}
	
	Product dao = productDao.getInstance();
	
	Product product = dao.getProductDetailById(int no);
	if(product == null) {
		response.sendRedirect("exceptionNoProductNo.jsp");
	} //예외처리 만들어야함
	
	ArrayList<Product> productList = dao.getAllProducts();
	Product goods = new Product();
	for(int i = 0; i < productList.size(); i++)
		products = productsList.get(i);
		if(products.getProductNo().equals(no))
	

%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>