package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

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
	
	// 지정한 상품번호를 장바구니에 저장
	public void insertCart(Cart cart) throws SQLException {
		String sql = "insert into SHOP_CART (CART_NO, USER_NO, PRODUCT_NO, CART_QUANTITY) "
				   + "values (SHOP_CART_seq.nextval, ?, ?, ?) ";
				  
		Connection connection = getConnection();	
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getUserNo());
		pstmt.setInt(2, cart.getProductNo());
		pstmt.setInt(3, cart.getQuantity());

		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	//장바구니리스트 조회
	public List<Cart> getAllCartList() throws SQLException {
		String sql = "select * "
				   + "from shop_cart ";
		
		List<Cart> carts = new ArrayList<Cart>();
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
	
		ResultSet rs = pstmt.executeQuery();
	
		rs.close();
		pstmt.close();
		connection.close();
		
		return carts;
	}
	
	//고객번호(userNo)로 장바구니 정보 조회// 재수정 예정
	public List<Cart> selectCartByUserNo(int userNo) throws SQLException {
		List<Cart> cart = new ArrayList<>();
		
		String sql = "select P.PRODUCT_IMAGE, P.PRODUCT_NAME, P.PRODUCT_PRICE, C.CART_QUANTITY, U.USER_NO "
				   + "from SHOP_PRODUCTS P, SHOP_CART C, SHOP_USER U,  "
				   + "where P.PRODUCT_NO = C.PRODUCT_NO || C.USER_NO = U.USER_NO "
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
		
	// 장바구니 담은 수량 변경 
	public void updateCartQuantity(Cart cart) throws SQLException {
		String sql = "update SHOP_CART "
				   + "set "
				   + "	cart_no = ?, "
				   + "	product_no = ?, "
				   + "	cart_quntity = ?, "
				   + "where user_no = ? ";
				 
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getCartNo());
		pstmt.setInt(2, cart.getProductNo());
		pstmt.setInt(3, cart.getQuantity());
		pstmt.setInt(4, cart.getUserNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	//  지정된 상품번호로 카트의 상품을 삭제한다.
	public void deleteCart(Cart cart) throws SQLException {
		String sql = "delete SHOP_CART "
				   + "where user_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, cart.getUserNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}

	private Cart rowToCart(ResultSet rs) throws SQLException {
	Cart cart = new Cart();
	User user = new User();
	cart.setCartNo(rs.getInt("CART_NO"));
	cart.setProductNo(rs.getInt("PRODUCT_NO"));
	cart.setQuantity(rs.getInt("CART_QUANTITY"));
	
	user.setUserNo(rs.getInt("USER_NO"));
	
	return cart;
    }
}
