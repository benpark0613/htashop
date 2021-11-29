package com.shop.vo;

import java.util.Date;

public class Review {
	
	private int ProductNo;
	private int customerNo;
	private int reviewNo;
	private String answer;
	private String review;
	private String adminId;
	private String Title;
	private Date answerCreateDate;
	private Date reviewCreateDate;
	
	public Review() {

	}

	public int getProductNo() {
		return ProductNo;
	}

	public void setProductNo(int productNo) {
		ProductNo = productNo;
	}

	public int getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(int customerNo) {
		this.customerNo = customerNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getTitle() {
		return Title;
	}
	
	public void setTitle(String title) {
		Title = title;
	}

	public Date getAnswerCreateDate() {
		return answerCreateDate;
	}

	public void setAnswerCreateDate(Date answerCreateDate) {
		this.answerCreateDate = answerCreateDate;
	}

	public Date getReviewCreateDate() {
		return reviewCreateDate;
	}

	public void setReviewCreateDate(Date reviewCreateDate) {
		this.reviewCreateDate = reviewCreateDate;
	}
	
	
	

}
