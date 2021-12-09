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
import com.shop.vo.Order;
import com.shop.vo.OrderList;

public class OrderListDao {
	
	// 주문정보를 테이블에 저장
	public void insertOrderList(OrderList orderlist) throws SQLException{
		String sql = "insert into shop_OrderList (order_no, product_no, order_count) "
				   + "values (?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, orderlist.getOrderNo());
		pstmt.setInt(2, orderlist.getProductNo());
		pstmt.setInt(3, orderlist.getOrderCount());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
	/**
	 * MYSHOP 주문검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<OrderDto> getOrderList(CriteriaOrderList criteria, int userNo)throws SQLException{
		
		String sql = "select RN, O.ORDER_NO, O.PRODUCT_NAME, O.PRODUCT_NO, O.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
		          + "O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
		          + "from (select row_number() over (order by O.ORDER_NO) RN, "
		          + "             O.ORDER_NO, P.PRODUCT_NAME, P.PRODUCT_NO, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
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
				//+ "ORDER BY O.ORDER_DATE DESC";
		
		
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
			orderDto.setProductNo(rs.getInt("PRODUCT_NO"));
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
	
	/**
	 * 관리자페이지 주문관리 
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getTotalRows(CriteriaOrderList criteria)throws SQLException{

		String sql = "select count(*) cnt "
				+ "from SHOP_ORDER O, SHOP_PRODUCTS P, SHOP_USER U, SHOP_ORDERLIST OL "
				+ "WHERE O.ORDER_NO = OL.ORDER_NO "
				+ "AND OL.PRODUCT_NO = P.PRODUCT_NO "
				+ "AND O.USER_NO = U.USER_NO ";
		
		if("주문자아이디".equals(criteria.getOrderOption())){
			sql += "AND U.USER_ID LIKE '%' || ? || '%' ";
		}
		else if("주문번호".equals(criteria.getOrderOption())) {
			sql += "AND O.ORDER_NO = ? ";
		}
		else if("주문자명".equals(criteria.getOrderOption())) {
			sql += "AND U.USER_NAME LIKE '%' || ? || '%' ";
		}
		else if("주문자연락처".equals(criteria.getOrderOption())) {
			sql += "AND U.USER_TEL = ? "; 
		}
		
		
		if("오늘".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE) " 
					+ "		          AND SYSDATE ";
		}
		else if("어제".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-1) " 
					+ "		          AND SYSDATE ";
		}
		else if("3일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-3) " 
					+ "		          AND SYSDATE ";
		}
		else if("7일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-7) " 
					+ "		          AND SYSDATE ";
		}
		else if("15일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-15) " 
					+ "		          AND SYSDATE ";
		}
		else if("1개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -1)) "
					+ "		          AND SYSDATE ";
		}
		else if("3개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -3)) "
					+ "		          AND SYSDATE ";
		}
		else if("6개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -6)) "
					+ "		          AND SYSDATE ";
		}else if("전체".equals(criteria.getTerm())) {
			
		}
		
		if("상품명".equals(criteria.getProductOption())) {
			sql += "AND P.PRODUCT_NAME LIKE '%' || ? || '%' ";
		}
		else if("상품번호".equals(criteria.getProductOption())) {
			sql += "AND P.PRODUCT_NO LIKE '%' || ? || '%' ";
		}
		
		if("전체".equals(criteria.getState())) {
			
		}
		else if("상품준비중".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '상품준비중' ";
		}
		else if("배송대기".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송대기' ";
		}
		else if("배송중".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송중' ";
		}
		else if("배송완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송완료' ";
		}
		
		else if("입금완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '입금완료' ";
		}
		
		else if("입금전".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '입금전' ";
		}
		else if("결제완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '결제완료' ";
		}
		

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		if(criteria.getUserkeyword() != null && criteria.getProductkeyword() != null) {
			pstmt.setString(1, criteria.getUserkeyword());
			pstmt.setString(2, criteria.getProductkeyword());
		}else if(criteria.getUserkeyword() == null && criteria.getProductkeyword() != null){
			pstmt.setString(1, criteria.getProductkeyword());
		}else if(criteria.getUserkeyword() != null && criteria.getProductkeyword() == null){
			pstmt.setString(1, criteria.getUserkeyword());
		}
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}

	public List<OrderDto> getOrderList(CriteriaOrderList criteria)throws SQLException{

		String sql = "select RN, O.ORDER_NO, O.USER_NAME, O.USER_TEL, O.PRODUCT_NAME, O.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
				+ "O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
				+ "from (select row_number() over (order by O.ORDER_NO) RN, "
				+ "             O.ORDER_NO, U.USER_NAME, U.USER_TEL, P.PRODUCT_NAME, OL.ORDER_COUNT, O.ORDER_TOTAL_PRICE, O.ORDER_STATE, "
				+ "		      O.POINT_USED, O.EXPECTED_POINT, O.ORDER_DATE "
				+ "      from SHOP_ORDER O, SHOP_ORDERLIST OL, SHOP_PRODUCTS P, SHOP_USER U"
				+ "      where O.ORDER_NO = OL.ORDER_NO "
				+ "      AND OL.PRODUCT_NO = P.PRODUCT_NO "
				+ "      AND O.USER_NO = U.USER_NO ";

		
		if("주문자아이디".equals(criteria.getOrderOption())){
			sql += "AND U.USER_ID LIKE '%' || ? || '%' ";
		}
		else if("주문번호".equals(criteria.getOrderOption())) {
			sql += "AND O.ORDER_NO = ?";
		}
		else if("주문자명".equals(criteria.getOrderOption())) {
			sql += "AND U.USER_NAME LIKE '%' || ? || '%' ";
		}
		else if("주문자연락처".equals(criteria.getOrderOption())) {
			sql += "AND U.USER_TEL = ? "; 
		}
		
		
		if("오늘".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE) " 
					+ "		          AND SYSDATE ";
		}
		else if("어제".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-1) " 
					+ "		          AND SYSDATE ";
		}
		else if("3일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-3) " 
					+ "		          AND SYSDATE ";
		}
		else if("7일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-7) " 
					+ "		          AND SYSDATE ";
		}
		else if("15일".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(SYSDATE-15) " 
					+ "		          AND SYSDATE ";
		}
		else if("1개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -1)) "
					+ "		          AND SYSDATE ";
		}
		else if("3개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -3)) "
					+ "		          AND SYSDATE ";
		}
		else if("6개월".equals(criteria.getTerm())) {
			sql += "and O.order_date BETWEEN TRUNC(ADD_MONTHS(SYSDATE, -6)) "
					+ "		          AND SYSDATE ";
		}
		
			
		if("상품명".equals(criteria.getProductOption())) {
			sql += "AND P.PRODUCT_NAME LIKE '%' || ? || '%' ";
		}
		else if("상품번호".equals(criteria.getProductOption())) {
			sql += "AND P.PRODUCT_NO LIKE '%' || ? || '%' ";
		}
		
		if("전체".equals(criteria.getState())) {
			
		}
		else if("상품준비중".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '상품준비중' ";
		}
		else if("배송대기".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송대기' ";
		}
		else if("배송중".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송중' ";
		}
		else if("배송완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '배송완료' ";
		}
		else if("입금완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '입금완료' ";
		}
			
		else if("입금전".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '입금전' ";
		}
		else if("결제완료".equals(criteria.getState())) {
			sql += "AND O.ORDER_STATE = '결제완료' ";
		}

		sql += " ) O "
				+ "WHERE RN>=? AND RN<= ? ";


		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
			
		if(criteria.getUserkeyword() != null && criteria.getProductkeyword() != null) {
			pstmt.setString(1, criteria.getUserkeyword());
			pstmt.setString(2, criteria.getProductkeyword());
			pstmt.setInt(3, criteria.getBeginIndex());
			pstmt.setInt(4, criteria.getEndIndex());
		}else if(criteria.getUserkeyword() == null && criteria.getProductkeyword() != null){
			pstmt.setString(1, criteria.getProductkeyword());
			pstmt.setInt(2, criteria.getBeginIndex());
			pstmt.setInt(3, criteria.getEndIndex());
		}else if(criteria.getUserkeyword() != null && criteria.getProductkeyword() == null){
			pstmt.setString(1, criteria.getUserkeyword());
			pstmt.setInt(2, criteria.getBeginIndex());
			pstmt.setInt(3, criteria.getEndIndex());
		}else {
			pstmt.setInt(1, criteria.getBeginIndex());
			pstmt.setInt(2, criteria.getEndIndex());
		}

		ResultSet rs = pstmt.executeQuery();
		List<OrderDto> orderList = new ArrayList<>();
		while(rs.next()) {
			OrderDto orderDto = new OrderDto();

			orderDto.setOrderNo(rs.getInt("ORDER_NO"));
			orderDto.setUserName(rs.getString("USER_NAME"));
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
	
	
	public List<Order> getOrderListByTerm(String term)throws SQLException{
		
		String sql = "select ORDER_NO, ORDER_TOTAL_PRICE "
				+ "FROM SHOP_ORDER "
				+ "WHERE ORDER_DATE BETWEEN TRUNC(SYSDATE - ? ) "
				+ "					AND SYSDATE ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		if("today".equals(term)) {
			pstmt.setInt(1, 0);
		}
		else if("week".equals(term)) {
			pstmt.setInt(1, 7);
		}
		ResultSet rs = pstmt.executeQuery();
		
		List<Order> orderList = new ArrayList<>();
		
		while(rs.next()) {
			Order order = new Order();
			order.setOrderNo(rs.getInt("ORDER_NO"));
			order.setTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
			
			orderList.add(order);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return orderList;
	}
	
	public int getOrderCountByTerm(String term)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "FROM SHOP_ORDER "
				+ "WHERE ORDER_DATE BETWEEN TRUNC(SYSDATE - ? ) "
				+ "					AND SYSDATE ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if("today".equals(term)) {
			pstmt.setInt(1, 0);
		}
		else if("week".equals(term)) {
			pstmt.setInt(1, 7);
		}
		
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		int cnt = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return cnt;
		
		
	}
	public int countOrderStatus(String state)throws SQLException{
		
		String sql = "select count(*) cnt "
				+ "   from SHOP_ORDER "
				+ "WHERE ORDER_STATE = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if("입금전".equals(state)) {
			pstmt.setString(1, "입금전");
		}
		else if("배송준비중".equals(state)) {
			pstmt.setString(1, "배송준비중");
		}
		else if("입금완료".equals(state)) {
			pstmt.setString(1, "입금완료");
		}
		else if("배송중".equals(state)) {
			pstmt.setString(1, "배송중");
		}
		else if("배송완료".equals(state)) {
			pstmt.setString(1, "배송완료");
		}
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		int cnt = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return cnt;
	}

	public void addOrderList(OrderList orderList)throws SQLException{

		String sql = "insert into SHOP_ORDERLIST "
				+ "(ORDER_NO, PRODUCT_NO, ORDER_COUNT) "
				+ "VALUES(?, ?, ? ) ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);

		pstmt.setInt(1, orderList.getOrderNo());
		pstmt.setInt(2, orderList.getProductNo());
		pstmt.setInt(3, orderList.getOrderCount());

		pstmt.executeUpdate();
		pstmt.close();
		connection.close();

	}
	
	public void updateState(int orderNo, String state) throws SQLException{

		String sql = "update SHOP_ORDER "
				+ "   set ORDER_STATE = ? "
				+ "   where ORDER_NO = ? ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if("배송완료처리".equals(state)) {
			pstmt.setString(1, "배송완료");
			pstmt.setInt(2, orderNo);
		}
		else if("배송중처리".equals(state)) {
			pstmt.setString(1, "배송중");
			pstmt.setInt(2, orderNo);
		}
		else if("입금확인처리".equals(state)) {
			pstmt.setString(1, "입금확인");
			pstmt.setInt(2, orderNo);
		}
		else if("배송대기처리".equals(state)) {
			pstmt.setString(1, "배송대기");
			pstmt.setInt(2, orderNo);
		}
		else if("배송준비중처리".equals(state)) {
			pstmt.setString(1, "배송준비중");
			pstmt.setInt(2, orderNo);
		}
		else if("입금완료처리".equals(state)) {
			pstmt.setString(1, "입금완료");
			pstmt.setInt(2, orderNo);
		}

		pstmt.executeUpdate();
		connection.close();
	}


}