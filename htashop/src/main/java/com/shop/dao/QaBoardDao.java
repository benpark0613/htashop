package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.QaBoard;
import com.shop.vo.User;

public class QaBoardDao {
	
	private static QaBoardDao self = new QaBoardDao();
	private QaBoardDao() {}
	public static QaBoardDao getInstance() {
		return self;
	}

	public List<QaBoard> getAllQuestions() throws SQLException {

		String sql = " select qa_no, product_no, qa_title, " + " user_no, qa_regdate " + " from shop_qaboard ";

		List<QaBoard> qaboardList = new ArrayList<>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			QaBoard qaboard = new QaBoard();

			qaboard.setNo(rs.getInt("qa_no"));
			qaboard.setProductNo(rs.getInt("product_no"));
			qaboard.setTitle(rs.getString("qa_title"));
			qaboard.setUserNo(rs.getInt("user_no"));
			qaboard.setRegdate(rs.getDate("qa_regdate"));

			qaboardList.add(qaboard);
		}

		rs.close();
		pstmt.close();
		connection.close();

		return qaboardList;
	}

	// User에서 user정보를 거ㅏ져와서 박아야함
	public void insertQaBoard(QaBoard qaboard) throws SQLException {
		String sql = "insert into shop_qaboard (qa_no, product_no, qa_title, qa_content, user_no, qa_regdate ) "
				+ "values (SHOP_QA_SEQ.nextval, ?, ?, ?, ?, sysdate )";

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, qaboard.getProductNo());
		pstmt.setString(2, qaboard.getTitle());
		pstmt.setString(3, qaboard.getContent());
		pstmt.setInt(4, qaboard.getUserNo());

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
		String sql = "select q.qa_title, u.user_name, q.qa_regdate, q.qa_content, q.qa_no, u.user_id, q.qa_reply "
				+ "from shop_qaboard q, shop_user U " + "where q.user_no = U.user_no " + "and qa_no=?";

		QaBoard qaBoard = null;

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			qaBoard = new QaBoard();

			qaBoard.setNo(rs.getInt("qa_no"));
			qaBoard.setTitle(rs.getString("qa_title"));
			qaBoard.setContent(rs.getString("qa_content"));
			qaBoard.setRegdate(rs.getDate("qa_regdate"));
			qaBoard.setUserName(rs.getString("user_name"));
			qaBoard.setUserId(rs.getString("user_id"));
			qaBoard.setReply(rs.getString("qa_reply"));

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

}
