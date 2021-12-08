package com.shop.dto;

import java.util.Date;

public class OrderCartDto {

	// 카트
	int cartNo;
	int UserNo;
	int productNo;
	int cartQuantity;
	
	// 주문
	int orderNo;
	Date orderDate;
	String orderStatus;
	int orderPrice;
	int pointUsed;
	int expectedPoint;
	
	// 적립금
	int pointNo;
	int pointChange;
	Date pointChangeDate;
	String pointChangeReason;
	
	// 회원
	int customerPoint;
	
	public int getCustomerPoint() {
		return customerPoint;
	}
	public void setCustomerPoint(int customerPoint) {
		this.customerPoint = customerPoint;
	}
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getUserNo() {
		return UserNo;
	}
	public void setUserNo(int userNo) {
		UserNo = userNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getCartQuantity() {
		return cartQuantity;
	}
	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public int getPointUsed() {
		return pointUsed;
	}
	public void setPointUsed(int pointUsed) {
		this.pointUsed = pointUsed;
	}
	public int getExpectedPoint() {
		return expectedPoint;
	}
	public void setExpectedPoint(int expectedPoint) {
		this.expectedPoint = expectedPoint;
	}
	public int getPointNo() {
		return pointNo;
	}
	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}
	public int getPointChange() {
		return pointChange;
	}
	public void setPointChange(int pointChange) {
		this.pointChange = pointChange;
	}
	public Date getPointChangeDate() {
		return pointChangeDate;
	}
	public void setPointChangeDate(Date pointChangeDate) {
		this.pointChangeDate = pointChangeDate;
	}
	public String getPointChangeReason() {
		return pointChangeReason;
	}
	public void setPointChangeReason(String pointChangeReason) {
		this.pointChangeReason = pointChangeReason;
	}
	
	
	
	
}
