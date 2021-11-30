package com.shop.vo;

public class Grade {
	
	private String userGrade;
	private int minTotalPrice;
	private int maxTotalPrice;
	
	public Grade() {}

	public String getUserGrade() {
		return userGrade;
	}

	public void setUserGrade(String userGrade) {
		this.userGrade = userGrade;
	}

	public int getMinTotalPrice() {
		return minTotalPrice;
	}

	public void setMinTotalPrice(int minTotalPrice) {
		this.minTotalPrice = minTotalPrice;
	}

	public int getMaxTotalPrice() {
		return maxTotalPrice;
	}

	public void setMaxTotalPrice(int maxTotalPrice) {
		this.maxTotalPrice = maxTotalPrice;
	}
	
}
