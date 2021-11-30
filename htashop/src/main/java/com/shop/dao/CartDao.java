package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utils.ConnectionUtil;
import com.shop.vo.User;
import com.shop.vo.Cart;

public class CartDao {

	
	private static CartDao self = new CartDao();
	private CartDao() {}
	public static CartDao getInstance() {
		return self;
	}
	
	//장바구니리스트 모든 정보 반환
	//public List<Cart> selectAllCarts() throws SQLException{
		//List<Cart> cart = new ArrayList<>();}
	
	
	

	//고객번호(userNo)로 장바구니 정보 반환
	public List<Cart> selectCartByUserNo(int userNo) throws SQLException {
		List<Cart> cart = new ArrayList<>();
		
		String sql = "select C.CART_NO, C.PRODUCT_NO, C.CART_QUANTITY, U.USER_NO "
				   + "from SHOP_CART C, SHOP_USER U "
				   + "where C.USER_NO = U.USERNO "
				   + "and C.USER_NO = ? "
				   + "order by C.PRODUCT_NO desc ";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			cart.add(rowToCart(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return cart;
	}
	
	
	
	private Cart rowToCart(ResultSet rs) throws SQLException {
	Cart cart = new Cart();
	cart.setCartNo(rs.getInt("CART_NO"));
	cart.setUserNo(rs.getInt("USER_NO"));
	cart.setProductNo(rs.getInt("PRODUCT_NO"));
	cart.setQuantity(rs.getInt("CART_QUANTITY"));
	
	return cart;
	}
	
	
	
	
	//
}
