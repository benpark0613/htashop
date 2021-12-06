package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shop.dto.PointDto;
import static utils.ConnectionUtil.getConnection;

public class PointChangeDao {
	
	/**
	 * MYSHOP 포인트검색
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public PointDto getPointChangeByUserNo(int userNo)throws SQLException{
		
		String sql = "select O.ORDER_NO, O.USER_NO, O.ORDER_DATE, O.ORDER_TOTAL_PRICE, O.POINT_USED, O.EXPECTED_POINT, "
						  + "P.POINT_NO, P.POINT_CHANGE, P.POINT_CHANGE_DATE, P.POINT_CHANGE_REASON "
				   + "from SHOP_POINT_CHANGE P, SHOP_ORDER O "
				   + "where O.USER_NO = P.USER_NO "
				   + "AND O.USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		PointDto pointDto = null;
		
		if(rs.next()) {
			pointDto = new PointDto();
			
			pointDto.setOrderNo(rs.getInt("ORDER_NO"));
			pointDto.setUserNo(rs.getInt("USER_NO"));
			pointDto.setOrderDate(rs.getDate("ORDER_DATE"));
			pointDto.setOrderTotalPrice(rs.getInt("ORDER_TOTAL_PRICE"));
			pointDto.setPointUsed(rs.getInt("POINT_USED"));
			pointDto.setExpectedPoint(rs.getInt("EXPECTED_POINT"));
			pointDto.setPointNo(rs.getInt("POINT_NO"));
			pointDto.setPointChange(rs.getInt("POINT_CHANGE"));
			pointDto.setPointChangeDate(rs.getDate("POINT_CHANGE_DATE"));
			pointDto.setPointChangeReason(rs.getString("POINT_CHANGE_REASON"));
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return pointDto;
	}

}
