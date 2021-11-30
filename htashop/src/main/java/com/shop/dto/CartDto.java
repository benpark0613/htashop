package com.shop.dto;


public class CartDto {
		
		private int userNo;
		private String productImage;
		private String productName;
		private int quantity;
		private int price;
		private int expectedPoint;
		private int totalPrice;
				
		public CartDto() {}
		
		public int getuserNo() {
			return userNo;
		}
		public void setuserNo(int userNo) {
			this.userNo = userNo;
		}
		public String getProductImage() {
			return productImage;
		}
		public void setProductImage(String productImage) {
			this.productImage = productImage;
		}
		public String getProductName() {
			return productName;
		}
		public void setProductName(String productName) {
			this.productName = productName;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
		public int getProductPrice() {
			return price;
		}
		public void setProductPrice(int productPrice) {
			this.price = productPrice;
		}
	
		public int getTotalPrice() {
			return price*quantity;
		}
		
		public int getExpectedPoint() {
			return (int)(getTotalPrice()*0.01);}
		}
		

		