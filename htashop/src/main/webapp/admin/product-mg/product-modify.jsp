<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 상품정보 수정기능
	// [번호], 카테고리, 상품명, 상품가격, 재고량, [상품이미지], 판매상태
	// 상품명은 6글자 이하로

	// 폼에서 입력받은 값 꺼내기
	// no는 시퀀스라서 못바꾸고 이미지는 아직 보류
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String productCategory = request.getParameter("productCategory");
	String productName = request.getParameter("productName");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int productStock = Integer.parseInt(request.getParameter("productStock"));
	boolean productIsSoldout =  Boolean.parseBoolean(request.getParameter("productIsSoldout"));
	
	// 입력받은 값을 Product객체 생성해서 저장하기
	Product modifiedProductInfo = new Product();
	modifiedProductInfo.setNo(productNo);
	modifiedProductInfo.setCategory(productCategory);
	modifiedProductInfo.setName(productName);
	modifiedProductInfo.setPrice(productPrice);
	modifiedProductInfo.setStock(productStock);
	modifiedProductInfo.setSoldOut(productIsSoldout);
	
	ProductDao productDao = ProductDao.getInstance();
	productDao.updateProductInfo(modifiedProductInfo);
	
	response.sendRedirect("product-main.jsp");

%>