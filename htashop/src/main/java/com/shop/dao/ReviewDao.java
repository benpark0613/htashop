package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.ReviewDto;
import com.shop.vo.Review;
public class ReviewDao {
	
	
	
	public void updateReviewDetail(ReviewDto reviewDto) throws SQLException {
		String sql = "update shop_review "
				   + "set "
				   + "	review_title = ?, "
				   + "	review_content = ?, "
				   + "where review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, reviewDto.getTitle());
		pstmt.setString(2, reviewDto.getReviewContent());
		pstmt.setInt(3, reviewDto.getReviewNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}	
	
	
	
	public void deleteReview(int reviewNo) throws SQLException {
		String sql = "delete from shop_review where review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reviewNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	
	
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
	
	
	
	
	
	public List<ReviewDto> getReviewListByNo(int begin, int end, int productNo) throws SQLException{
		String sql = "select review_no, user_no, product_no, review_title, user_name, review_content, answer_content, answer_created_date, "      
				   + "		 review_view_count, REVIEW_CREATED_DATE "
				   + "from (select row_number() over (order by R.review_no desc) rn, "
				   + "             R.review_no, R.review_title,U.user_no, P.product_no, R.answer_content, U.user_name, R.review_content, "
				   + "			   R.review_view_count, R.REVIEW_CREATED_DATE, R.answer_created_date "
				   + "      from SHOP_REVIEW R, SHOP_USER U, SHOP_PRODUCTS P "
				   + "      where U.user_no = R.USER_NO "
				   + "      and P.PRODUCT_NO = R.PRODUCT_NO) "
				   + "where rn >= ? and rn <= ? "
				   + "and product_no = ? ";
	
		List<ReviewDto> reviewList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		pstmt.setInt(3, productNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ReviewDto reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserName(rs.getString("user_name"));
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


	public ReviewDto getReviewDetailByNo(int no) throws SQLException {
		
		ReviewDto reviewDto = new ReviewDto();
		
		String sql ="select R.review_no, P.product_name, R.product_no, R.user_no, U.user_name, R.review_Title, R.review_content, R.REVIEW_CREATED_DATE, "
					+ "R.REVIEW_VIEW_COUNT, R.answer_content, R.answer_created_date "
					+ "from shop_review R, shop_products P, shop_user U "
					+ "where R.product_no = P.product_no "
					+ "and R.user_no = U.user_no "
					+ "and review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		
		while(rs.next()) {
			reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setProductNo(rs.getInt("product_no"));
			reviewDto.setProductName(rs.getString("product_name"));
			reviewDto.setUserNo(rs.getInt("user_no"));
			reviewDto.setUserName(rs.getString("user_name"));
			reviewDto.setTitle(rs.getString("review_Title"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			reviewDto.setViewCount(rs.getInt("REVIEW_VIEW_COUNT"));		
			reviewDto.setAnswerContent(rs.getString("answer_content"));
			reviewDto.setAnswerCreatedDate(rs.getDate("answer_created_date"));
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewDto;
	}

	
	
	
	
	public List<ReviewDto> getReviewList(int reviewNo)throws SQLException{
			
		String sql = "select R.review_no, P.product_no, U.user_name, R.REVIEW_CONTENT, R.review_created_date, R.review_title "
				+ "from SHOP_REVIEW R, SHOP_USER U, SHOP_PRODUCTS P "
				+ "where U.user_no = R.USER_NO "
				+ "and P.PRODUCT_NO = R.PRODUCT_NO "
				+ "and r.review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, reviewNo);
		ResultSet rs = pstmt.executeQuery();
		List<ReviewDto> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			
			ReviewDto reviewDto = new ReviewDto();
			
			reviewDto.setReviewNo(rs.getInt("REVIEW_NO"));
			reviewDto.setProductNo(rs.getInt("product_no"));
			reviewDto.setUserName(rs.getString("USER_NAME"));
//			reviewDto.setProductName(rs.getString("product_name"));
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
