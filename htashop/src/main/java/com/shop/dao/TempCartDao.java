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
	
	/**
	 * 사용자 번호로 사용자가 담은 카트를 조회한다.
	 * @param userNo 사용자 번호
	 * @return 사용자가 담은 카트 리스트
	 * @throws SQLException
	 */
	public List<Cart> getAllCartListByUserNo(int userNo) throws SQLException {
		String sql = "select * "
				   + "from shop_cart "
				   + "where user_no = ? ";
		
		List<Cart> carts = new ArrayList<Cart>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
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
	
	public Cart getCartByProductNo(int productNo) throws SQLException {
		String sql = "select * "
				   + "from shop_cart "
				   + "where product_no = ? ";
		
		Cart cart = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			cart = new Cart();
			cart.setCartNo(rs.getInt("cart_no"));
			cart.setUserNo(rs.getInt("user_no"));
			cart.setProductNo(rs.getInt("product_no"));
			cart.setQuantity(rs.getInt("cart_quantity"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return cart;
	}
	
//	/**
//	 * 모든 사용자가 담은 카트를 조회한다.
//	 * @return 모든 사용자가 담은 카트 리스트
//	 * @throws SQLException
//	 */
//	public List<Cart> getAllCartList() throws SQLException {
//		String sql = "select * "
//				+ "from shop_cart ";
//		
//		List<Cart> carts = new ArrayList<Cart>();
//		
//		Connection connection = getConnection();
//		PreparedStatement pstmt = connection.prepareStatement(sql);
//		ResultSet rs = pstmt.executeQuery();
//		
//		while (rs.next()) {
//			Cart cart = new Cart();
//			cart.setUserNo(rs.getInt("user_no"));
//			cart.setCartNo(rs.getInt("cart_no"));
//			cart.setProductNo(rs.getInt("product_no"));
//			cart.setQuantity(rs.getInt("cart_quantity"));
//			
//			carts.add(cart);
//		}
//		
//		rs.close();
//		pstmt.close();
//		connection.close();
//		
//		return carts;
//	}
	
	public void insertCart(Cart cart) throws SQLException {
		String sql = "insert into shop_cart (cart_no, user_no, product_no, cart_quantity) "
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
	
	public void updateCart(Cart cart) throws SQLException {
		String sql = "update shop_cart "
				   + "set "
				   + "	cart_quantity = ? "
				   + "where cart_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getQuantity());
		pstmt.setInt(2, cart.getCartNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
}





















