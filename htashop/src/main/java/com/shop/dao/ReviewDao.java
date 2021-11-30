package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.ReviewDto;
import com.shop.vo.Product;
import com.shop.vo.Review;
import com.shop.vo.User;
public class ReviewDao {
	
	/**
	 * 지정된 게시글 정보를 테이블에 저장한다.
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
//	public void insertBoard(Review review) throws SQLException {
//		String sql = "insert into SHOP_REVIEW (board_no, board_title, board_writer_no, board_content) "
//				   + "values (comm_board_seq.nextval, ?, ?, ?)";
//		
//		Connection connection = getConnection();
//		PreparedStatement pstmt = connection.prepareStatement(sql);
//		pstmt.setString(1, board.getTitle());
//		pstmt.setInt(2, board.getWriter().getNo());
//		pstmt.setString(3, board.getContent());
//		
//		pstmt.executeUpdate();
//		
//		pstmt.close();
//		connection.close();
//	}
	
	
	
	
	
	public List<ReviewDto> getReviewList(int begin, int end) throws SQLException{
		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, "
				   + "       board_view_count, board_like_count, board_deleted, "
				   + "		 board_deleted_date, board_updated_date, board_created_date "
				   + "from (select row_number() over (order by B.board_no desc) rn, "
				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
				   + "             B.board_view_count, B.board_like_count, B.board_deleted, "
				   + "			   B.board_deleted_date, B.board_updated_date, B.board_created_date "
				   + "      from tb_comm_boards B, tb_comm_users U "
				   + "      where B.board_writer_no = U.user_no) "
				   + "where rn >= ? and rn <= ? ";
		
		//TODO 게시물 조회 및 페이지네이션 작업
		/**
		 *  select review_no, review_title, user_no, review_content, 
				          board_view_count, review_created_date, answer_created_date 
				   from (select row_number() over (order by B.board_no desc) rn, 
				                B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  
				                B.board_view_count, B.board_like_count, B.board_deleted, 
				   			   B.board_deleted_date, B.board_updated_date, B.board_created_date 
				         from tb_comm_boards B, tb_comm_users U 
				         where B.board_writer_no = U.user_no) 
				    "where rn >= ? and rn <= ? ";
				    
		 * 
		 */
		List<ReviewDto> reviewList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setProductNo(rs.getInt("product_no"));
			reviewDto.setTitle(rs.getString("review_title"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setAnswerContent(rs.getString("answer_content"));
			reviewDto.setViewCount(rs.getInt("review_view_count"));
			reviewDto.setReviewCreatedDate(rs.getDate("review_created_date"));
			reviewDto.setAnswerCreatedDate(rs.getDate("answer_created_date"));
		
			reviewList.add(reviewDto);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewList;
	}
	
	
	
	public int getTotalRecords() throws SQLException {
		String sql ="select count(*) cnt "
					+"from shop_review ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalRecords = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}

	public ReviewDto getReviewDetail(int no) {
		
		ReviewDto reviewDto = new ReviewDto();
	}
	
	
	
	
	public List<ReviewDto> getReviewList(int productNo)throws SQLException{
			
		String sql = "select U.user_name, P.PRODUCT_NAME, R.REVIEW_CONTENT "
				+ "from SHOP_REVIEW R, SHOP_USER U, SHOP_PRODUCTS P "
				+ "where U.user_no = R.USER_NO "
				+ "and P.PRODUCT_NO = R.PRODUCT_NO "
				+ "and r.product_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		List<ReviewDto> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			
			ReviewDto reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("REVIEW_NO"));
			reviewDto.setTitle(rs.getString("REVIEW_TITLE"));
			reviewDto.setReviewCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			reviewDto.setViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
			
			reviewList.add(reviewDto);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		
		return reviewList;
	}
	

}
