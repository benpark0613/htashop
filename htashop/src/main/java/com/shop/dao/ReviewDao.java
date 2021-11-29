package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Customer;
import com.shop.vo.Review;
import com.shop.vo.Review;
public class ReviewDao {
	
	private static ReviewDao self = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return self;
	}
	/**
	 * 지정된 범위에 속하는 게시글 정보를 반환한다.
	 * @param begin 시작 순번번호
	 * @param end 끝 순번번호
	 * @return 게시글 목록
	 * @throws SQLException
	 */
//	public List<Review> getReviewList(int begin, int end) throws SQLException {
//		String sql = "select board_no, board_title, user_no, user_id, user_name, board_content, "
//				   + "       board_view_count, board_like_count, board_deleted, "
//				   + "		 board_deleted_date, board_updated_date, board_created_date "
//				   + "from (select row_number() over (order by B.board_no desc) rn, "
//				   + "             B.board_no, B.board_title, U.user_no, U.user_id, U.user_name, B.board_content,  "
//				   + "             B.board_view_count, B.board_like_count, B.board_deleted, "
//				   + "			   B.board_deleted_date, B.board_updated_date, B.board_created_date "
//				   + "      from tb_comm_boards B, tb_comm_users U "
//				   + "      where B.board_writer_no = U.user_no) "
//				   + "where rn >= ? and rn <= ? ";
//		
//		List<Review> reiewList = new ArrayList<>();
//		
//		Connection connection = getConnection();
//		PreparedStatement pstmt = connection.prepareStatement(sql);
//		pstmt.setInt(1, begin);
//		pstmt.setInt(2, end);
//		ResultSet rs = pstmt.executeQuery();
//		while (rs.next()) {
//			Review review = new Review();
//			Customer customer = new Customer();
//			
//			review.setNo(rs.getInt("board_no"));
//			review.setTitle(rs.getString("board_title"));
//			review.setContent(rs.getString("board_content"));
//			review.setLikeCount(rs.getInt("board_like_count"));
//			review.setViewCount(rs.getInt("board_view_count"));
//			review.setDeleted(rs.getString("board_deleted"));
//			review.setDeletedDate(rs.getDate("board_deleted_date"));
//			review.setUpdatedDate(rs.getDate("board_updated_date"));
//			review.setCreatedDate(rs.getDate("board_created_date"));
//			
//			customer.setNo(rs.getInt("user_no"));
//			customer.setId(rs.getString("user_id"));
//			customer.setName(rs.getString("user_name"));
//			
//			customer.setWriter(customer);
//			
//			reiewList.add(review);
//		}
//		rs.close();
//		pstmt.close();
//		connection.close();
//		
//		return reiewList;
//	}
	
	/**
	 * 지정된 게시글 정보를 테이블에 저장한다.
	 * @param board 게시글 정보
	 * @throws SQLException
	 */
	public void insertReview(Review review) throws SQLException {
		String sql = "insert into tb_comm_boards (board_no, board_title, board_writer_no, board_content) "
				   + "values (comm_board_seq.nextval, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, review.getTitle());
		pstmt.setString(2, review.getReview());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 테이블에 저장된 게시글정보의 갯수를 반환한다.
	 * @return 게시글 정보 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from tb_comm_boards";
		
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
