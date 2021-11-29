package com.shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Review;

import static utils.ConnectionUtil.getConnection;
public class ReviewDao {

	
	public List<Review> getAllReviewByCustomerNo(int customerNo)throws SQLException{
		
		String sql = "select REVIEW_NO, REVIEW_TITLE, REVIEW_VIEW_COUNT, REVIEW_CREATED_DATE "
				+ "from SHOP_REVIEW "
				+ "where CUSTOMER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, customerNo);
		ResultSet rs = pstmt.executeQuery();
		List<Review> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			Review review = new Review();
			review.setReviewNo(rs.getInt("REVIEW_NO"));
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			review.setViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
			
			reviewList.add(review);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		
		return reviewList;
	}
	
	
//	public List<BoardDto> getAllBoardsByCustomerNo(int customerNo)throws SQLException{
//		
//		String sql = "select Q.QA_NO, Q.CUSTOMER_NO, Q.QA_VIEWCOUNT, Q.QA_TITLE, Q.QA_REGDATE, "
//				   + "                R.REVIEW_NO, R.REVIEW_TITLE, R.REVIEW_VIEW_COUNT, R.REVIEW_CREATED_DATE "
//				   + "from SHOP_QABOARD Q, SHOP_REVIEW R"
//				   + "where Q.CUSTOMER_NO = R.CUSTOMER_NO "
//				   + "AND Q.CUSTOMER_NO = ? ";
//		
//		Connection connection = getConnection();
//		PreparedStatement pstmt = connection.prepareStatement(sql);
//		
//		pstmt.setInt(1, customerNo);
//		ResultSet rs = pstmt.executeQuery();
//		List<BoardDto> boardList = new ArrayList<>();
//		
//		while(rs.next()) {
//			BoardDto board = new BoardDto();
//			board.setQAno(rs.getInt("QA_NO"));
//			board.setReviewNo(rs.getInt("REVIEW_NO"));
//			board.setQATitle(rs.getString("QA_TITLE"));
//			board.setReviewTitle(rs.getString("REVIEW_TITLE"));
//			board.setQARegDate(rs.getDate("QA_REGDATE"));
//			board.setReviewRegDate(rs.getDate("REVIEW_CREATED_DATE"));
//			board.setQAViewCount(rs.getInt("QA_VIEWCOUNT"));
//			board.setReviewViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
//			
//			boardList.add(board);
//		}
//		rs.close();
//		pstmt.close();
//		connection.close();
//		
//		
//		return boardList;
//		
//	}
	
}
