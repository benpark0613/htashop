package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Criteria;
import com.shop.vo.QaBoard;
import com.shop.vo.User;

public class QaBoardDao {
	
	private static QaBoardDao self = new QaBoardDao();
	private QaBoardDao() {}
	public static QaBoardDao getInstance() {
		return self;
	}

	public List<QaBoard> getAllQuestions(int begin, int end) throws SQLException {

		String sql =  " select rn, qa_no, product_no, qa_title, " 
					+ " user_no, qa_regdate, user_name, qa_viewcount " 
					+ " from (select row_number() over (order by q.qa_regdate desc) rn, "
					+ " q.qa_no, q.product_no, q.qa_title, q.user_no, q.qa_regdate, u.user_name, q.qa_viewcount "
					+ " from shop_qaboard q, shop_user u"
					+ " where q.user_no = u.user_no) "
					+ " where rn >= ? and rn <= ? "
					+ " order by qa_regdate desc ";

		
		List<QaBoard> qaboardList = new ArrayList<>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			QaBoard qaboard = new QaBoard();

			qaboard.setNo(rs.getInt("qa_no"));
			qaboard.setProductNo(rs.getInt("product_no"));
			qaboard.setTitle(rs.getString("qa_title"));
			qaboard.setUserNo(rs.getInt("user_no"));
			qaboard.setRegdate(rs.getDate("qa_regdate"));
			qaboard.setUserName(rs.getString("user_name"));
			qaboard.setViewCount(rs.getInt("qa_viewcount"));

			qaboardList.add(qaboard);
		}

		rs.close();
		pstmt.close();
		connection.close();

		return qaboardList;
	}

	// User에서 user정보를 거ㅏ져와서 박아야함
	public void insertQaBoard(QaBoard qaboard) throws SQLException {
		String sql = "insert into shop_qaboard (qa_no, qa_title, user_no, product_no, qa_content, qa_regdate ) "
				+ "values (SHOP_QA_SEQ.nextval, ?, ?, ?, ?, sysdate )";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, qaboard.getTitle());
		pstmt.setInt(2, qaboard.getUserNo());
		pstmt.setInt(3, qaboard.getProductNo());
		pstmt.setString(4, qaboard.getContent());

		pstmt.executeUpdate();

		pstmt.close();
		connection.close();

	}

	public List<QaBoard> getAllQAByUserNo(int userNo) throws SQLException {

		String sql = "select QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT " + "from SHOP_QABOARD " + "where USER_NO = ? ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);

		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		List<QaBoard> QAList = new ArrayList<>();

		while (rs.next()) {
			QaBoard QAboard = new QaBoard();
			QAboard.setNo(rs.getInt("QA_NO"));
			QAboard.setTitle(rs.getString("QA_TITLE"));
			QAboard.setRegdate(rs.getDate("QA_REGDATE"));
			QAboard.setViewCount(rs.getInt("QA_VIEWCOUNT"));

			QAList.add(QAboard);
		}
		rs.close();
		pstmt.close();
		connection.close();

		return QAList;
	}

	public QaBoard getQuestionByNo(int no) throws SQLException {
		String sql = "select q.qa_title, u.user_name, q.qa_viewcount, q.qa_regdate, q.qa_content, q.qa_no, u.user_id, q.qa_reply, q.product_no "
				+ "from shop_qaboard q, shop_user U "
				+ "where q.user_no = U.user_no and qa_no=? ";

		QaBoard qaBoard = null;

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			qaBoard = new QaBoard();

			qaBoard.setNo(rs.getInt("qa_no"));
			qaBoard.setViewCount(rs.getInt("qa_viewcount"));
			qaBoard.setTitle(rs.getString("qa_title"));
			qaBoard.setContent(rs.getString("qa_content"));
			qaBoard.setRegdate(rs.getDate("qa_regdate"));
			qaBoard.setUserName(rs.getString("user_name"));
			qaBoard.setUserId(rs.getString("user_id"));
			qaBoard.setReply(rs.getString("qa_reply"));
			qaBoard.setProductNo(rs.getInt("product_no"));
			

		}
		rs.close();
		pstmt.close();
		connection.close();

		return qaBoard;
	}

	public List<QaBoard> getAllQAByUserNoRN(int userNo, int begin, int end) throws SQLException {

		String sql = "select QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "

				+ "from (select row_number() over (order by QA_NO) RN, "
				+ "             QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "
				+ "      from SHOP_QABOARD "
				+ "      where USER_NO = ? ) "
				+ "where RN>=? AND RN<=? ";


		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);

		pstmt.setInt(1, userNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		List<QaBoard> QAList = new ArrayList<>();

		while (rs.next()) {
			QaBoard QAboard = new QaBoard();
			QAboard.setNo(rs.getInt("QA_NO"));
			QAboard.setTitle(rs.getString("QA_TITLE"));
			QAboard.setRegdate(rs.getDate("QA_REGDATE"));
			QAboard.setViewCount(rs.getInt("QA_VIEWCOUNT"));

			QAList.add(QAboard);
		}
		rs.close();
		pstmt.close();
		connection.close();

		return QAList;
	}

	public int countAllQaBoards(int userNo) throws SQLException {

		String sql = "select count(*) cnt " + "from SHOP_QABOARD " + "where USER_NO = ? ";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int cnt = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		return cnt;
	}

	public void updateReply(QaBoard qaBoard) throws SQLException {
		String sql = "update shop_qaboard " + "set " + "qa_reply = ? " + "where qa_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, qaBoard.getReply());
		pstmt.setInt(2, qaBoard.getNo());

		pstmt.executeUpdate();

		pstmt.close();
		connection.close();

	}
	
	public void updateViewCount(QaBoard qaBoard) throws SQLException {
		String sql = "update shop_qaboard " + "set " + "qa_viewcount = ? " + "where qa_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, qaBoard.getViewCount());
		pstmt.setInt(2, qaBoard.getNo());

		pstmt.executeUpdate();

		pstmt.close();
		connection.close();

	}
	
	public void updateQuestion(QaBoard qaBoard) throws SQLException {
		String sql = "update shop_qaboard " 
					 + "set " 
					 + "qa_title = ?, qa_content = ? "
					 + "where qa_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, qaBoard.getTitle());
		pstmt.setString(2, qaBoard.getContent());
		pstmt.setInt(3, qaBoard.getNo());

		pstmt.executeUpdate();

		pstmt.close();
		connection.close();

	}
	
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from shop_qaboard";
		
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
	
	public void deleteQuestion(int no) throws SQLException {
		String sql = "delete from shop_qaboard "
				   + "where qa_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	/**
	 * MYSHOP Board검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public int getCountQaBoardsByUserNo(Criteria criteria, int userNo)throws SQLException{
		int totalRows = 0;
		String sql = "select count(*) cnt "
				+ "   from SHOP_QABOARD "
				+ "   where USER_NO = ? ";
		if("title".equals(criteria.getOption())) {
			sql += "and QA_TITLE like '%' || ? || '%' ";
		}else if("content".equals(criteria.getOption())) {
			sql += "and QA_CONTENT like '%' || ? || '%' ";
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
	 * MYSHOP Board검색
	 * @param criteria
	 * @param userNo
	 * @return
	 * @throws SQLException
	 */
	public List<QaBoard> getAllQAByUserNoRN(Criteria criteria, int userNo)throws SQLException{


		String sql = "select QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "

				+ "from (select row_number() over (order by QA_NO) RN, "
				+ "             QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "
				+ "      from SHOP_QABOARD "
				+ "      where USER_NO = ? ";
		if("title".equals(criteria.getOption())) {
			sql += "and QA_TITLE like '%' || ? || '%' ";
		}else if("content".equals(criteria.getOption())) {
			sql += "and QA_CONTENT like '%' || ? || '%' ";
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
		List<QaBoard> QAList = new ArrayList<>();

		while (rs.next()) {
			QaBoard QAboard = new QaBoard();
			QAboard.setNo(rs.getInt("QA_NO"));
			QAboard.setTitle(rs.getString("QA_TITLE"));
			QAboard.setRegdate(rs.getDate("QA_REGDATE"));
			QAboard.setViewCount(rs.getInt("QA_VIEWCOUNT"));

			QAList.add(QAboard);
		}
		rs.close();
		pstmt.close();
		connection.close();

		return QAList;
	}

	public int getTodayTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from shop_qaboard "
				   + "where qa_regdate >= to_date(trunc(sysdate)) "
				   + "and qa_regdate < to_date(trunc(sysdate+1)) ";
		
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
