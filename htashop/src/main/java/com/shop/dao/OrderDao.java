package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.OrderCartDto;
import com.shop.dto.OrderDto;
import com.shop.vo.Order;

public class OrderDao {
	
	private static OrderDao self = new OrderDao();
	private OrderDao() {}
	public static OrderDao getInstance() {
		return self;
	}

	/**
	 * 새 주문번호를 반환한다.
	 * @return
	 * @throws SQLException
	 */
	public int getOrderNo() throws SQLException {
		String sql = "select order_no_seq.nextval seq from dual";
		
		int orderNo = 0;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		
		orderNo = rs.getInt("seq");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return orderNo;
	}
	
	
	//신규 주문 정보를 저장
	
	public void insertOrder(Order order) throws SQLException {
		
		String sql = "insert into shop_order"
				   + "(order_no, user_no, order_total_price) "
				   + "values (?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, order.getOrderNo());
		pstmt.setInt(2, order.getUserNo());
		pstmt.setInt(3, order.getTotalPrice());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
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
	

	public int countAllOrders(int userNo)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
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

	/**
	 * MYSHOP
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<OrderDto> getOrderDetailList(int userNo)throws SQLException{
		
		String sql = "select O.ORDER_NO, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
				          + "O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
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
			orderDto.setOrderDate(rs.getDate("ORDER_DATE"));
			
			orderList.add(orderDto);
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return orderList;
	}
	
	/**
	 * MYSHOP
	 * @param userNo
	 * @param begin
	 * @param end
	 * @return
	 * @throws SQLException
	 */
	public List<OrderDto> getOrdersByNoRN(int userNo, int begin, int end)throws SQLException{
		
		String sql = "select RN, O.ORDER_NO, O.PRODUCT_NAME, O.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
		          + "O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
		          + "from (select row_number() over (order by O.ORDER_NO) RN, "
		          + "             O.ORDER_NO, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
		          + "		      O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
		          + "      from SHOP_ORDER O, SHOP_ORDERLIST OL, SHOP_PRODUCTS P "
		          + "      where O.ORDER_NO = OL.ORDER_NO "
		          + "      AND OL.PRODUCT_NO = P.PRODUCT_NO "
		          + "      AND O.USER_NO = ? ) O "
		          + "WHERE RN>=? AND RN<= ? ";
		
		
		Connection connection = getConnection();
		
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		
		
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
			orderDto.setOrderDate(rs.getDate("ORDER_DATE"));
			
			orderList.add(orderDto);
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return orderList;
	}
	
	public void addOrders(Order order)throws SQLException{
		
		String sql = "insert into SHOP_ORDER "
			 	   + "(ORDER_NO, USER_NO, ORDER_TOTAL_PRICE, POINT_USED, EXPECTED_POINT) "
			 	   + "VALUES(SHOP_ORDER_SEQ.nextval, ?, ?, ?, ? ) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, order.getUserNo());
		pstmt.setInt(2, order.getTotalPrice());
		pstmt.setInt(3, order.getPointUsed());
		pstmt.setInt(4, order.getExpectedPoint());
		
		pstmt.executeUpdate();
		pstmt.close();
		connection.close();
		
	}
	
	public void orderTransaction(OrderCartDto orderCartDto) throws SQLException {
		Connection connection = getConnection();

		String sql = "insert into shop_order (order_no, user_no, order_total_price, point_used, expected_point) "
				   + "values (shop_order_seq.nextval, ?, ?, ?, ?) ";

		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, orderCartDto.getUserNo());
		pstmt.setInt(2, orderCartDto.getOrderPrice());
		pstmt.setInt(3, orderCartDto.getPointUsed());
		pstmt.setInt(4, orderCartDto.getExpectedPoint());
		pstmt.executeQuery();

		String sql2 = "insert into shop_point_change (point_no, point_change, point_change_reason, user_no, order_no) "
				    + "values (shop_point_seq.nextval, ?, ?, ?, shop_order_seq.currval) ";

		pstmt = connection.prepareStatement(sql2);
		pstmt.setInt(1, orderCartDto.getPointChange());
		pstmt.setString(2, orderCartDto.getPointChangeReason());
		pstmt.setInt(3, orderCartDto.getUserNo());
		pstmt.executeQuery();
		
		String sql3 = "insert into shop_orderlist (order_no, product_no, order_count) "
				    + "values (shop_order_seq.currval, ?, ?) ";
		
		pstmt = connection.prepareStatement(sql3);
		pstmt.setInt(1, orderCartDto.getProductNo());
		pstmt.setInt(2, orderCartDto.getCartQuantity());
		pstmt.executeQuery();
		
		String sql4 = "update shop_user "
				    + "set "
				    + "	 user_point = ? "
				    + "where user_no = ? ";
		
		pstmt = connection.prepareStatement(sql4);
		pstmt.setInt(1, orderCartDto.getCustomerPoint());
		pstmt.setInt(2, orderCartDto.getUserNo());
		pstmt.executeQuery();
		
		pstmt.close();
		connection.close();
	}
	
}





























