package com.shop.vo;

import java.util.Date;

public class PointChange {

	private int pointNo;
	private int pointChange;
	private Date pointChangeDate;
	private String pointChangeReason;
	private int userNo;
	private int orderNo;
	
	public PointChange() {}

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
	
	
}
