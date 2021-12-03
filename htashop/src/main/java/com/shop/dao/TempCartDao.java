package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.ConnectionUtil.getConnection;

import com.shop.vo.Cart;
import com.shop.vo.User;

public class TempCartDao {

	private static TempCartDao self = new TempCartDao();
	private TempCartDao() {}
	public static TempCartDao getInstance() {
		return self;
	}
	
	public void insertCart(Cart cart) throws SQLException {
		String sql = "insert into shop_cart(cart_no, user_no, product_no, cart_quantity) "
				   + "values (shop_cart_seq.nextval, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getUserNo());
		pstmt.setInt(2, cart.getProductNo());
		pstmt.setInt(3, cart.getQuantity());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public List<Cart> getAllCartList() throws SQLException {
		String sql = "select * "
				   + "from shop_cart ";
		
		List<Cart> carts = new ArrayList<Cart>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Cart cart = new Cart();
			cart.setUserNo(rs.getInt("user_no"));
			cart.setCartNo(rs.getInt("cart_no"));
			cart.setProductNo(rs.getInt("product_no"));
			cart.setQuantity(rs.getInt("cart_quantity"));
			
			carts.add(cart);
		}
		
		rs.close();
		pstmt.close();
		connection.close();

		return carts;
	}
}





















