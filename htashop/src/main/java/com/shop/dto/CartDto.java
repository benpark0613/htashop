package com.shop.dto;


public class CartDto {
		//파일 이미지는??//
		private int customerNo;
		private String productImage;
		private String productName;
		private int quantity;
		private int productPrice;
		private int expectedPoint;
		private int totalPrice;
		private String [] deleteCart;
		
		public CartDto() {}
		
		
		public int getCustomerNo() {
			return customerNo;
		}
		public void setCustomerNo(int customerNo) {
			this.customerNo = customerNo;
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
			return productPrice;
		}
		public void setProductPrice(int productPrice) {
			this.productPrice = productPrice;
		}
		public int getExpectedPoint() {
			return expectedPoint;
		}
		public void setExpectedPoint(int expectedPoint) {
			this.expectedPoint = expectedPoint;
		}
		public int getTotalPrice() {
			return totalPrice;
		}
		public void setTotalPrice(int totalPrice) {
			this.totalPrice = totalPrice;
		}
		public String[] getDeleteCart() {
			return deleteCart;
		}
		public void setDeleteCart(String[] deleteCart) {
			this.deleteCart = deleteCart;
		}
		
		
}
		