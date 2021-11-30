package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.shop.vo.User;
import com.sample.board.vo.Board;
import com.shop.vo.Review;
public class ReviewDao {
	

	/**
	 * 지정된 게시글 정보를 테이블에 저장한다.
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertBoard(Review review) throws SQLException {
		String sql = "insert into tb_comm_boards (board_no, board_title, board_writer_no, board_content) "
				   + "values (comm_board_seq.nextval, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, board.getTitle());
		pstmt.setInt(2, board.getWriter().getNo());
		pstmt.setString(3, board.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
	public List<Review> getAllReviewByUserNo(int userNo)throws SQLException{

		
		String sql = "select REVIEW_NO, REVIEW_TITLE, REVIEW_VIEW_COUNT, REVIEW_CREATED_DATE "
				+ "from SHOP_REVIEW "
				+ "where USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, userNo);
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
	
	
}
