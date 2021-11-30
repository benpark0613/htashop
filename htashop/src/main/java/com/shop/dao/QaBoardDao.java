package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.QABoard;

public class QaBoardDao {

	
	public List<QABoard> getAllQAByUserNo(int userNo)throws SQLException{
		
		String sql = "select QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "
				+ "from SHOP_QABOARD "
				+ "where USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		List<QABoard> QAList = new ArrayList<>();
		
		while(rs.next()) {
			QABoard QAboard = new QABoard();
			QAboard.setQANo(rs.getInt("QA_NO"));
			QAboard.setTitle(rs.getString("QA_TITLE"));
			QAboard.setRegDate(rs.getDate("QA_REGDATE"));
			QAboard.setViewCount(rs.getInt("QA_VIEWCOUNT"));
			
			QAList.add(QAboard);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		
		return QAList;
	}
}
