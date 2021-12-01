package com.shop.dto;

import java.util.Date;

public class PointDto {

	private int pointNo;
	private int userNo;
	private int orderNo;
	private int pointUsed;
	private int expectedPoint;
	private Date orderDate;
	private int orderTotalPrice;
	private int pointChange;
	private Date pointChangeDate;
	private String pointChangeReason;
	
	public PointDto(){}

	public int getPointNo() {
		return pointNo;
	}

	public void setPointNo(int pointNo) {
		this.pointNo = pointNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
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

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getOrderTotalPrice() {
		return orderTotalPrice;
	}

	public void setOrderTotalPrice(int orderTotalPrice) {
		this.orderTotalPrice = orderTotalPrice;
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
