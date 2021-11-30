package com.shop.vo;

public class Cart {

	private int cartNo;
	private int userNo;
	private int productNo;
	private int quantity;
	
	public Cart() {}
	
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public int getUserrNo() {
		return userNo;
	}
	public void setUserNo(int customerNo) {
		this.userNo = customerNo;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
}
