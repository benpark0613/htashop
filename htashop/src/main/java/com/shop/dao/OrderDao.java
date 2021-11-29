package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.OrderDto;
import com.shop.vo.Order;

import static utils.ConnectionUtil.getConnection;

public class OrderDao {

	public Order getOrdersByNo(int customerNo)throws SQLException{
		
		
		String sql = "select ORDER_NO, CUSTOMER_NO, ORDER_DATE, ORDER_STATE, ORDER_TOTAL_PRICE, "
				+ "POINT_USED, EXPECTED_POINT "
				+ "from SHOP_ORDER "
				+ "where customer_no = ? ";
		
		Connection connection = getConnection();
		
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, customerNo);
		
		ResultSet rs = pstmt.executeQuery();
		
		Order order = null;
		if(rs.next()) {
			order = new Order();
			
			order.setOrderNo(rs.getInt("ORDER_NO"));
			order.setCustomerNo(rs.getInt("CUSTOMER_NO"));
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
	
	public int countShippedComplete(int customerNo)throws SQLException{
		
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
	public int countbeforeDeposit(int customerNo)throws SQLException{
		
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
	public int countPreparingDelevery(int customerNo)throws SQLException{
		
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
	public int countShipping(int customerNo)throws SQLException{
		
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
	public int countCancel(int customerNo)throws SQLException{
		
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
	public int countExchange(int customerNo)throws SQLException{
		
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
	public int countRtn(int customerNo)throws SQLException{
		
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

	
	public List<OrderDto> getOrderDetail(int customerNo)throws SQLException{
		
		String sql = "select O.ORDER_NO, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, O.POINT_USED, O.EXPECTED_POINT "
				   + "from SHOP_ORDER O, SHOP_ORDERLIST OL, SHOP_PRODUCTS P "
				   + "where O.ORDER_NO = OL.ORDER_NO "
				   + "AND OL.PRODUCT_NO = P.PRODUCT_NO "
				   + "AND O.CUSTOMER_NO = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, customerNo);
		ResultSet rs = pstmt.executeQuery();
		List<OrderDto> orderList = new ArrayList<>();
		if(rs.next()) {
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
