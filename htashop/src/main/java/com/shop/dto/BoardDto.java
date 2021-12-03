package com.shop.dto;

import java.util.Date;

public class BoardDto {
	
	private int qaNo;
	private int qaProductNo;
	private String qaTitle;
	private String qaContent;
	private Date qaRegDate;
	private int qaViewCount;
	
	private int userNo;

	private int reviewNo;
	private int reviewProductNo;
	private String reviewTitle;
	private String reviewContent;
	private Date reviewCreatedDate;
	private int reviewViewCount;
	
	public BoardDto() {}
	
	public Date getQaRegDate() {
		return qaRegDate;
	}
	
	public void setQaRegDate(Date qaRegDate) {
		this.qaRegDate = qaRegDate;
	}

	public int getQaNo() {
		return qaNo;
	}

	public void setQaNo(int qaNo) {
		this.qaNo = qaNo;
	}

	public int getQaProductNo() {
		return qaProductNo;
	}

	public void setQaProductNo(int qaProductNo) {
		this.qaProductNo = qaProductNo;
	}

	public String getQaTitle() {
		return qaTitle;
	}

	public void setQaTitle(String qaTitle) {
		this.qaTitle = qaTitle;
	}

	public String getQaContent() {
		return qaContent;
	}

	public void setQaContent(String qaContent) {
		this.qaContent = qaContent;
	}

	public int getQaViewCount() {
		return qaViewCount;
	}

	public void setQaViewCount(int qaViewCount) {
		this.qaViewCount = qaViewCount;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getReviewProductNo() {
		return reviewProductNo;
	}

	public void setReviewProductNo(int reviewProductNo) {
		this.reviewProductNo = reviewProductNo;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public Date getReviewCreatedDate() {
		return reviewCreatedDate;
	}

	public void setReviewCreatedDate(Date reviewCreatedDate) {
		this.reviewCreatedDate = reviewCreatedDate;
	}

	public int getReviewViewCount() {
		return reviewViewCount;
	}

	public void setReviewViewCount(int reviewViewCount) {
		this.reviewViewCount = reviewViewCount;
	}
	
	
}
