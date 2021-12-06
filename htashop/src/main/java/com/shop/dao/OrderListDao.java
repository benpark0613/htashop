package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.OrderDto;
import com.shop.vo.CriteriaOrderList;

public class OrderListDao {
	
	/**
	 * MYSHOP 주문검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<OrderDto> getOrderList(CriteriaOrderList criteria, int userNo)throws SQLException{
		
		String sql = "select RN, O.ORDER_NO, O.PRODUCT_NAME, O.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
		          + "O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
		          + "from (select row_number() over (order by O.ORDER_NO) RN, "
		          + "             O.ORDER_NO, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
		          + "		      O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
		          + "      from SHOP_ORDER O, SHOP_ORDERLIST OL, SHOP_PRODUCTS P "
		          + "      where O.ORDER_NO = OL.ORDER_NO "
		          + "      AND OL.PRODUCT_NO = P.PRODUCT_NO "
		          + "      AND O.USER_NO = ? ";
		
		if("전체".equals(criteria.getTerm())) {
			
		}
		else if("오늘".equals(criteria.getTerm())) {
			sql +="and O.order_date BETWEEN TRUNC(SYSDATE) " 
					+ "		            AND SYSDATE ";
		}
		else if("1주일".equals(criteria.getTerm())) {
			sql +="and O.order_date BETWEEN TRUNC(SYSDATE-7) " 
					+ "		            AND SYSDATE ";
		}
		else if("1개월".equals(criteria.getTerm())) {
			sql +="and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -1)) "
					+ "		                   AND SYSDATE ";
		}
		else if("3개월".equals(criteria.getTerm())) {
			sql +="and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -3)) "
					+ "		                   AND SYSDATE ";
		}
		else if("6개월".equals(criteria.getTerm())) {
			sql +="and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -6)) " 
					+ "		                   AND SYSDATE ";
		}
		if("전체".equals(criteria.getOption())) {
			
		}
		else if("입금전".equals(criteria.getOption())) {
			sql += "and O.order_state = '입금전' "; 
		}
		else if("배송준비중".equals(criteria.getOption())) {
			sql += "and O.order_state = '배송준비중' "; 
		}
		else if("배송중".equals(criteria.getOption())) {
			sql += "and O.order_state = '배송중' "; 
		}
		else if("배송완료".equals(criteria.getOption())) {
			sql += "and O.order_state = '배송완료' "; 
		}
		else if("취소".equals(criteria.getOption())) {
			sql += "and O.order_state = '취소' "; 
		}
		else if("교환".equals(criteria.getOption())) {
			sql += "and O.order_state = '교환' "; 
		}
		else if("반품".equals(criteria.getOption())) {
			sql += "and O.order_state = '반품' "; 
		}
		
		sql += " ) O "
				+ "WHERE RN>=? AND RN<= ? ";
		
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		pstmt.setInt(2, criteria.getBeginIndex());
		pstmt.setInt(3, criteria.getEndIndex());
		
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
	 * MYSHOP 주문검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows(CriteriaOrderList criteria, int userNo)throws SQLException{

		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER "
				+ "where USER_NO = ? ";
		
		if("전체".equals(criteria.getTerm())) {
			
		}
		else if("오늘".equals(criteria.getTerm())) {
			sql += "and order_date BETWEEN TRUNC(SYSDATE) " 
					+ "		          AND SYSDATE ";
		}
		else if("1주일".equals(criteria.getTerm())) {
			sql += "and order_date BETWEEN TRUNC(SYSDATE-7) " 
					+ "		          AND SYSDATE ";
		}
		else if("1개월".equals(criteria.getTerm())) {
			sql += "and order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -1)) "
					+ "		          AND SYSDATE ";
		}
		else if("3개월".equals(criteria.getTerm())) {
			sql += "and order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -3)) "
					+ "		          AND SYSDATE ";
		}
		else if("6개월".equals(criteria.getTerm())) {
			sql += "and order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -6)) " 
					+ "		          AND SYSDATE ";
		}
		if("전체".equals(criteria.getOption())) {
			
		}
		else if("입금전".equals(criteria.getOption())) {
			sql += "and order_state = '입금전' "; 
		}
		else if("배송준비중".equals(criteria.getOption())) {
			sql += "and order_state = '배송준비중' "; 
		}
		else if("배송중".equals(criteria.getOption())) {
			sql += "and order_state = '배송중' "; 
		}
		else if("배송완료".equals(criteria.getOption())) {
			sql += "and order_state = '배송완료' "; 
		}
		else if("취소".equals(criteria.getOption())) {
			sql += "and order_state = '취소' "; 
		}
		else if("교환".equals(criteria.getOption())) {
			sql += "and order_state = '교환' "; 
		}
		else if("반품".equals(criteria.getOption())) {
			sql += "and order_state = '반품' "; 
		}

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

}