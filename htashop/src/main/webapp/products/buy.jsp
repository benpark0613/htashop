<%@page import="com.shop.vo.Product"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

int no = Integer.parseInt(request.getParameter("no"));


// 게시글 정보를 제공하는 BoardDao객체를 획득한다.
ProductDao productDao = ProductDao.getInstance();	

// 게시글 번호에 해당하는 글 정보를 조회한다.
Product product = productDao.getProductDetailById(no);

String color = request.getParameter("color");
int size = Integer.parseInt(request.getParameter("size"));
int quantity = Integer.parseInt(request.getParameter("quantity"));

String name = product.getName();
int price = product.getPrice();
int total = price * quantity;
%>

<h1>주문하신 색상은 <%=color %> 입니다.</h1>
<h3>주문하신 사이즈는 <%=size %> 입니다.</h3>
<h3>주문하신 갯수는 <%=quantity %> 입니다.</h3>
<h3>주문하신 총액은 <%=total %> 입니다.</h3>
<h3>주문하신 제품은 <%=name %> 입니다.</h3>
	

</body>
</html>