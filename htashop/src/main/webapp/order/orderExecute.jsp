<%@page import="com.shop.vo.Order"%>
<%@page import="com.shop.vo.OrderList"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	//orderForm.jsp에서 productNo, quantity 조회
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	
	User loginedUser = (User) session.getAttribute("logined_user_info");

	//loginedUser가 null인 경우 로그인창 페이지로 이동
	if (loginedUser == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}

	OrderDao orderDao = OrderDao.getInstance();
	
	OrderListDao orderListDao = new OrderListDao();
	ProductDao productDao = ProductDao.getInstance();
	
	
	//getParameter로 가져온 productNo로 상품 조회
	Product product = productDao.getProductDetailById(productNo);
	
	// 새 주문번호를 생성한다
	int orderNo = orderDao.getOrderNo();
	
	//orderList 객체를 생성해 해당 상품번호의  주문번호, 주문 수량을 저장한다.
	OrderList orderList = new OrderList();
	orderList.setOrderNo(orderNo);
	orderList.setOrderCount(quantity);
	
	//총 추문금액 계산
	int totalPrice = 0;
	totalPrice = product.getPrice() * orderList.getOrderCount();
	
	//Order객체를 생성해, 주문번호, 고객번호, 총주문금액 저장
	Order order = new Order();
	order.setOrderNo(orderNo);
	order.setUserNo(loginedUser.getUserNo());
	order.setTotalPrice(totalPrice);
	
	//선택 상품번호로 상품재고량 조회
	int stock = product.getStock();  
	
	//주문한 수량만큼 재고량-하기
	product.setStock(product.getStock()- orderList.getOrderCount());
	
	// 변경한 객체를 insert, update하기
	orderDao.insertOrder(order);
	orderListDao.insertOrderList(orderList);
	productDao.updateStock(product);
	
	// 주문완료시 주문완료 알람창 후 메인페이지로 이동
	response.sendRedirect("order-completed.jsp");



%>