package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.BoardDto;
import com.shop.dto.ReviewDto;
import com.shop.vo.Criteria;
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
	
	/**
	 *  QABoard와 ReviewBoard 모두 조회 MYSHOP에 사용됨
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<BoardDto> getAllBoardsByUserNo(int userNo)throws SQLException{
		
		String sql = "select Q.QA_NO, Q.PRODUCT_NO, Q.USER_NO, Q.QA_TITLE, Q.QA_CONTENT, Q.QA_REGDATE, Q.QA_VIEWCOUNT, "
				    + "      R.REVIEW_NO, R.PRODUCT_NO, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.REVIEW_CREATED_DATE, R.REVIEW_VIEW_COUNT "
					+ "from SHOP_QABOARD Q, SHOP_REVIEW R "
					+ "where Q.USER_NO = R.USER_NO "
					+ "AND Q.USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		
		List<BoardDto> allBoardList = new ArrayList<>();
		while(rs.next()) {
			BoardDto boards = new BoardDto();
			
			boards.setQaNo(rs.getInt("QA_NO"));
			boards.setQaProductNo(rs.getInt("PRODUCT_NO"));
			boards.setUserNo(rs.getInt("USER_NO"));
			boards.setQaTitle(rs.getString("QA_TITLE"));
			boards.setQaContent(rs.getString("QA_CONTENT"));
			boards.setQaRegDate(rs.getDate("QA_REGDATE"));
			boards.setQaViewCount(rs.getInt("QA_VIEWCOUNT"));
			
			boards.setReviewNo(rs.getInt("REVIEW_NO"));
			boards.setReviewProductNo(rs.getInt("PRODUCT_NO"));
			boards.setReviewTitle(rs.getString("REVIEW_TITLE"));
			boards.setReviewContent(rs.getString("REVIEW_CONTENT"));
			boards.setReviewCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			boards.setReviewViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
			
			allBoardList.add(boards);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return allBoardList;
	}
	
	/**
	 * 검색 조건에 해당하는 총 게시글의 갯수를 반환한다.
	 * @param criteria 검색조건
	 * @return 총 게시글 갯수
	 * @throws SQLException
	 */
	public int getAllBoardsCount(Criteria criteria) throws SQLException {
		int totalRows = 0;
		String sql = "select count(*) cnt "
				+ "   from ( select Q.QA_NO, Q.PRODUCT_NO, Q.USER_NO, Q.QA_TITLE, Q.QA_CONTENT, Q.QA_REGDATE, Q.QA_VIEWCOUNT, "
				+ "				    R.REVIEW_NO, R.PRODUCT_NO, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.REVIEW_CREATED_DATE, R.REVIEW_VIEW_COUNT "
				+ "			 from SHOP_QABOARD Q, SHOP_REVIEW R "
				+ "			 where Q.USER_NO = R.USER_NO ) ";
		
		if ("title".equals(criteria.getOption())) {
			sql += "  and board_title like '%' || ? || '%' ";
		} else if ("writer".equals(criteria.getOption())) {
			sql += "  and board_writer = ? ";
		} else if ("content".equals(criteria.getOption())) {
			sql += "  and board_content like '%' || ? || '%' ";
		}
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
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
	 * 검색조건에 해당하는 게시글 목록을 반환한다.
	 * @param criteria 검색조건
	 * @return 게시글 목록
	 * @throws SQLException
	 */
	public List<BoardDto>  getAllBoardList(Criteria criteria) throws SQLException {
		
		String sql = "select Q.QA_NO, Q.PRODUCT_NO, Q.USER_NO, Q.QA_TITLE, Q.QA_CONTENT, Q.QA_REGDATE, Q.QA_VIEWCOUNT, "
			    + "      R.REVIEW_NO, R.PRODUCT_NO, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.REVIEW_CREATED_DATE, R.REVIEW_VIEW_COUNT "
				+ "from (select row_number() over (order by Q.QA_RRGDATE, R.REVIEW_CREATED_DATE DESC) rn, "
				+ "             Q.QA_NO, Q.PRODUCT_NO, Q.USER_NO, Q.QA_TITLE, Q.QA_CONTENT, Q.QA_REGDATE, Q.QA_VIEWCOUNT, "
				+ "			    R.REVIEW_NO, R.PRODUCT_NO, R.REVIEW_TITLE, R.REVIEW_CONTENT, R.REVIEW_CREATED_DATE, R.REVIEW_VIEW_COUNT "
				+ "      where Q.USER_NO = R.USER_NO ) ";
		
		if ("title".equals(criteria.getOption())) {
			sql += "        and board_title like '%' || ? || '%' ";
		} else if ("writer".equals(criteria.getOption())) {
			sql += "        and board_writer = ? ";
		} else if ("content".equals(criteria.getOption())) {
			sql += "        and board_content like '%' || ? || '%' ";
		}
		sql += "            ) "
			+  "where rn >= ? and rn <= ? ";
	
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (criteria.getOption() != null) {
			pstmt.setString(1, criteria.getKeyword());
			pstmt.setInt(2, criteria.getBeginIndex());
			pstmt.setInt(3, criteria.getEndIndex());
		} else {
			pstmt.setInt(1, criteria.getBeginIndex());
			pstmt.setInt(2, criteria.getEndIndex());
		}
		ResultSet rs = pstmt.executeQuery();
		List<BoardDto> allBoardList = new ArrayList<>();

		while (rs.next()) {
			BoardDto boards = new BoardDto();
			boards.setQaNo(rs.getInt("QA_NO"));
			boards.setQaProductNo(rs.getInt("PRODUCT_NO"));
			boards.setUserNo(rs.getInt("USER_NO"));
			boards.setQaTitle(rs.getString("QA_TITLE"));
			boards.setQaContent(rs.getString("QA_CONTENT"));
			boards.setQaRegDate(rs.getDate("QA_REGDATE"));
			boards.setQaViewCount(rs.getInt("QA_VIEWCOUNT"));
			
			boards.setReviewNo(rs.getInt("REVIEW_NO"));
			boards.setReviewProductNo(rs.getInt("PRODUCT_NO"));
			boards.setReviewTitle(rs.getString("REVIEW_TITLE"));
			boards.setReviewContent(rs.getString("REVIEW_CONTENT"));
			boards.setReviewCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
			boards.setReviewViewCount(rs.getInt("REVIEW_VIEW_COUNT"));
			
			allBoardList.add(boards);
		}
		rs.close();
		pstmt.close();
		connection.close();

		return allBoardList;
	}


}
