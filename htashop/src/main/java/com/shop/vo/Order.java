package com.shop.vo;

import java.util.Date;

public class Order {

	private int orderNo;
	private int userNo;
	private Date orderDate;
	private String state;
	private int totalPrice;
	private int pointUsed;
	private int expectedPoint;
	
	public Order() {}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
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
	
	
}
