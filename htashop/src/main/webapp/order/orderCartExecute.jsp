<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.dao.PointChangeDao"%>
<%@page import="com.shop.vo.PointChange"%>
<%@page import="com.shop.vo.Cart"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@page import="com.shop.vo.Order"%>
<%@page import="com.shop.vo.OrderList"%>
<%@page import="com.shop.dao.OrderListDao"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@page import="com.shop.dao.CartDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
User loginedUserInfo = (User) session.getAttribute("logined_user_info");
	if (loginedUserInfo == null) {
		
		return;
	}
	
	int pointUse = Integer.parseInt(request.getParameter("pointUse"));
	
	List<Cart> cartList = CartDao.getInstance().selectAllCartListByUserNo(loginedUserInfo.getUserNo());
	
	int totalOrderPrice = 0;
	int expectedPoint = 0;
	Product product = new Product();
	
	Order order = new Order();
	OrderDao orderDao = OrderDao.getInstance();
	
	OrderList orderList = new OrderList();
	OrderListDao orderListDao = new OrderListDao();
	
	
	PointChange pointChange = new PointChange();
	PointChangeDao pointChangeDao = new PointChangeDao();
	
	User user = new User();
	UserDao userDao = new UserDao();
	
	


	for (Cart carts : cartList) {

		// 포인트 사용시 가격
		totalOrderPrice = product.getPrice() * carts.getQuantity();
		expectedPoint = (int) (Math.round(totalOrderPrice * 0.01));

		order.setExpectedPoint(expectedPoint);
		order.setUserNo(loginedUserInfo.getUserNo());
		
		
		order.setTotalPrice(totalOrderPrice);
		order.setPointUsed(pointUse);
		orderDao.addOrders(order);

		
		orderList.setOrderNo(order.getOrderNo());
		orderList.setProductNo(carts.getProductNo());
		orderList.setOrderCount(carts.getQuantity());
		orderListDao.addOrderList(orderList);

		pointChange.setOrderNo(order.getOrderNo());
		pointChange.setUserNo(loginedUserInfo.getUserNo());

		// 2. pointChange 
		pointChange.setPointChange(expectedPoint - pointUse);
		pointChange.setPointChangeReason("0.01");

		pointChangeDao.addPointChange(pointChange);

		user.setPoint(point);
		userDao.updateOrder(loginedUserInfo.getUserNo(), point);

	}
%>
