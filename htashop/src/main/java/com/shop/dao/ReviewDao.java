package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.ReviewDto;
import com.shop.vo.Criteria;
import com.shop.vo.Review;
public class ReviewDao {
	
	
	
	public void updateReviewDetail(ReviewDto reviewDto) throws SQLException {
		String sql = "update shop_review "
				   + "set "
				   + "	review_title = ?, "
				   + "	review_content = ?, "
				   + "  review_view_count =? "
				   + "where review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, reviewDto.getTitle());
		pstmt.setString(2, reviewDto.getReviewContent());
		pstmt.setInt(3, reviewDto.getViewCount());
		pstmt.setInt(4, reviewDto.getReviewNo());
		
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
	
	
	public int getTotalRecordsByReview(int productNo) throws SQLException {
		String sql = "select count(review_no) cnt "
					+ "from shop_review "
					+ "where product_no = ? " ;
		
		int totalProductsRecord = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalProductsRecord = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalProductsRecord;
	}
	
	
	
	public List<ReviewDto> getReviewListByNo(int begin, int end, int productNo) throws SQLException{
		String sql = "select review_no, user_no, product_no, review_title, user_name, review_content, answer_content, answer_created_date, "      
				   + "		 review_view_count, REVIEW_CREATED_DATE "
				   + "from (select row_number() over (order by R.review_no desc) rn, "
				   + "             R.review_no, R.review_title,U.user_no, P.product_no, R.answer_content, U.user_name, R.review_content, "
				   + "			   R.review_view_count, R.REVIEW_CREATED_DATE, R.answer_created_date "
				   + "      from SHOP_REVIEW R, SHOP_USER U, SHOP_PRODUCTS P "
				   + "      where U.user_no = R.USER_NO "
				   + "      and P.PRODUCT_NO = R.PRODUCT_NO "
				   + "		and R.product_no = ? ) "
				   + "where rn >= ? and rn <= ? ";
	
		List<ReviewDto> reviewList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);		
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
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
	
	public List<Review> getAllReviewByUserNoRN(int userNo, int begin, int end) throws SQLException{
		String sql = "select REVIEW_NO, REVIEW_TITLE, REVIEW_VIEW_COUNT, REVIEW_CREATED_DATE "
				+ "from (select row_number() over (order by REVIEW_NO) RN, "
				+ "             REVIEW_NO, REVIEW_TITLE, REVIEW_VIEW_COUNT, REVIEW_CREATED_DATE "
				+ "      from SHOP_REVIEW "
				+ "      where USER_NO = ? ) "
				+ "where RN>=? AND RN<=? ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);

		pstmt.setInt(1, userNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
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
	
	/**
	 * MYSHOP review 검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getCountReviewByUserNo(Criteria criteria, int userNo)throws SQLException{
		int totalRows = 0;
		String sql = "select count(*) cnt "
				+ "   from SHOP_REVIEW "
				+ "   where USER_NO = ? ";
		if("title".equals(criteria.getOption())) {
			sql += "and REVIEW_TITLE like '%' || ? || '%' ";
		}else if("content".equals(criteria.getOption())) {
			sql += "and REVIEW_CONTENT like '%' || ? || '%' ";
		}
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		if(criteria.getOption() != null) {
			pstmt.setString(2, criteria.getKeyword());
		}
		
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRows = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		return totalRows;
	}
	
	/**
	 * MYSHOP review 검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<Review> getAllReviewByUserNo(Criteria criteria, int userNo)throws SQLException{
		
		String sql = "select REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, REVIEW_CREATED_DATE, REVIEW_VIEW_COUNT "
				+ "from (select row_number() over (order by REVIEW_NO) RN, "
				+ "             REVIEW_NO, REVIEW_TITLE, REVIEW_CONTENT, REVIEW_CREATED_DATE, REVIEW_VIEW_COUNT "
				+ "      from SHOP_REVIEW "
				+ "      where USER_NO = ? ";
		if("title".equals(criteria.getOption())) {
			sql += "and REVIEW_TITLE like '%' || ? || '%' ";
		}else if("content".equals(criteria.getOption())) {
			sql += "and REVIEW_CONTENT like '%' || ? || '%' ";
		}
			sql	+= "                      )"
					+ "where RN>=? AND RN<=? ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);

		pstmt.setInt(1, userNo);
		if(criteria.getOption() != null) {
			pstmt.setString(2, criteria.getKeyword());
			pstmt.setInt(3, criteria.getBeginIndex());
			pstmt.setInt(4, criteria.getEndIndex());
			
		}else {
			pstmt.setInt(2, criteria.getBeginIndex());
			pstmt.setInt(3, criteria.getEndIndex());
			
		}
		
		ResultSet rs = pstmt.executeQuery();
		List<Review> reviewList = new ArrayList<>();

		while(rs.next()) {
			Review review = new Review();
			review.setReviewNo(rs.getInt("REVIEW_NO"));
			review.setTitle(rs.getString("REVIEW_TITLE"));
			review.setContent(rs.getString("REVIEW_CONTENT"));
			review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			review.setViewCount(rs.getInt("REVIEW_VIEW_COUNT"));

			reviewList.add(review);
		}
		rs.close();
		pstmt.close();
		connection.close();


		return reviewList;
	}


	/**
	 * 리뷰 답글 달기 관련 sql 
	 * 답변 내용과 답변등록일의 기본값이 null이기 때문에 insert가 아닌 update로 변경해준다.
	 * @param reviewNo
	 */
	public void insertReply(ReviewDto reviewDto) throws SQLException {


		
		String sql ="UPDATE shop_review "
					+ "SET "
					+ " ANSWER_CONTENT = ?, "
					+ " ANSWER_CREATED_DATE = sysdate "
					+ "where review_no =? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, reviewDto.getAnswerContent());
		pstmt.setInt(2, reviewDto.getReviewNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}
	
	/**
	 * 리뷰 답글 삭제 관련 sql
	 * 답변 내용과 답변등록일의 기본값이 null이기 때문에 insert가 아닌 update로 변경해준다.
	 * @param reviewNo
	 */
	public void deleteReply(int reviewNo) throws SQLException {
		
		String sql ="UPDATE shop_review "
					+ "SET "
					+ " ANSWER_CONTENT = default, "
					+ " ANSWER_CREATED_DATE = default "
					+ "where review_no =? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reviewNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
		
	}	
	
	public void insertReview(ReviewDto reviewDto) throws SQLException {
		
		String sql ="insert into shop_review(review_no, product_no, user_no, review_title, review_content) "
				+ 	"values (shop_review_seq.nextval , ?, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reviewDto.getProductNo());
		pstmt.setInt(2, reviewDto.getUserNo());
		pstmt.setString(3, reviewDto.getTitle());
		pstmt.setString(4, reviewDto.getReviewContent());	
		pstmt.executeUpdate();	
		pstmt.close();
		connection.close();

	}
	
	public int getTodayTotalRecords() throws SQLException {
		String sql ="select count(*) cnt "
					+"from shop_review "
					+ "where REVIEW_CREATED_DATE >= to_date(trunc(sysdate)) "
					+ "and REVIEW_CREATED_DATE < to_date(trunc(sysdate+1)) ";				
		
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

}
