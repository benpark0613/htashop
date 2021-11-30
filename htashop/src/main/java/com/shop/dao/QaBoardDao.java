package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.QaBoard;

import utils.ConnectionUtil;

//import utils.ConnectionUtil;

public class QaBoardDao {
	
	
	public List<QaBoard> getAllQuestions() throws SQLException{
		
		String sql = " select qa_no, product_no, qa_title, "
					+" user_no, qa_regdate "
					+" from shop_qaboard ";
		
		List<QaBoard> qaboardList = new ArrayList<>();
		
		Connection connection = ConnectionUtil.getConnection();
		//Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			QaBoard qaboard = new QaBoard();
			
			qaboard.setNo(rs.getInt("qa_no"));
			qaboard.setProductNo(rs.getInt("product_no"));
			qaboard.setTitle(rs.getString("qa_title"));
			qaboard.setUserNo(rs.getInt("user-no"));
			qaboard.setRegdate(rs.getDate("qa_regdate"));
			
			qaboardList.add(qaboard);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return qaboardList;
	}
	
	//	User에서 user정보를 거ㅏ져와서 박아야함
	public void insertQaBoard(QaBoard qaboard) throws SQLException{
		String sql = "insert into shop_qaboard (qa_no, product_no, qa_title, user_no, qa_regdate ) "
					+"values (SHOP_QA_SEQ.nextval, ?, ?, ?, ? )";
	
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, qaboard.getProductNo());
		pstmt.setString(2, qaboard.getTitle());
		pstmt.setInt(3, qaboard.getUserNo());
		pstmt.setDate(4, qaboard.getRegdate());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	
	}
	
	
	
	
	
}
