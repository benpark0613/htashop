package com.shop.vo;

import java.util.Date;

public class Review {
	
	private int reviewNo;
	private int productNo;
	private int userNo;
	private String title;
	private String content;
	private Date createdDate;
	private int viewCount;
	private String answerContent;
	private Date answerCreatedDate;
	
	public Review() {}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
  
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

	public Date getAnswerCreatedDate() {
		return answerCreatedDate;
	}

	public void setAnswerCreatedDate(Date answerCreatedDate) {
		this.answerCreatedDate = answerCreatedDate;
	}

	
}
