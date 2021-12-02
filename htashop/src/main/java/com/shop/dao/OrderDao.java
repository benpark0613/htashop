package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.OrderDto;
import com.shop.vo.Cart;
import com.shop.vo.Order;

import static utils.ConnectionUtil.getConnection;

public class OrderDao {
	
	private static OrderDao self = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return self;
	}

	public Order getOrdersByNo(int userNo)throws SQLException{
			
		String sql = "select ORDER_NO, USER_NO, ORDER_DATE, ORDER_STATE, ORDER_TOTAL_PRICE, "
				+ "POINT_USED, EXPECTED_POINT "
				+ "from SHOP_ORDER "
				+ "where USER_NO = ? ";
		
		Connection connection = getConnection();
		
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		
		ResultSet rs = pstmt.executeQuery();
		
		Order order = null;
		if(rs.next()) {
			order = new Order();
			
			order.setOrderNo(rs.getInt("ORDER_NO"));
			order.setUserNo(rs.getInt("USER_NO"));
			order.setOrderDate(rs.getDate("ORDER_DATE"));
			order.setState(rs.getString("ORDER_STATE"));
			order.setTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
			order.setPointUsed(rs.getInt("POINT_USED"));
			order.setExpectedPoint(rs.getInt("EXPECTED_POINT"));
			
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return order;
	}
	
	public int countShippedComplete(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '배송완료' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countbeforeDeposit(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '입금전' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countPreparingDelevery(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '배송준비중' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countShipping(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '배송중' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countCancel(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '취소' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countExchange(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '교환' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}
	public int countRtn(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where ORDER_STATE = '반품' ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}

	
	public List<OrderDto> getOrderDetailList(int userNo)throws SQLException{
		
		String sql = "select O.ORDER_NO, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
				          + "O.POINT_USED, O.EXPECTED_POINT "
				   + "from SHOP_ORDER O, SHOP_ORDERLIST OL, SHOP_PRODUCTS P "
				   + "where O.ORDER_NO = OL.ORDER_NO "
				   + "AND OL.PRODUCT_NO = P.PRODUCT_NO "
				   + "AND O.USER_NO = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		
		List<OrderDto> orderList = new ArrayList<>();
		while(rs.next()) {
			OrderDto orderDto = new OrderDto();
			
			orderDto.setOrderNo(rs.getInt("ORDER_NO"));
			orderDto.setProductName(rs.getString("PRODUCT_NAME"));
			orderDto.setOrderCount(rs.getInt("ORDER_COUNT"));
			orderDto.setOrderTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
			orderDto.setOrderState(rs.getString("ORDER_STATE"));
			orderDto.setUsedPoint(rs.getInt("POINT_USED"));
			orderDto.setExpectedpoint(rs.getInt("EXPECTED_POINT"));
			
			orderList.add(orderDto);
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		
		return orderList;
	}
	
	
	
	
}
