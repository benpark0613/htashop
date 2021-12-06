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
	
public List<QaBoard> getAllQuestions() throws SQLException{
		
		String sql = " select qa_no, product_no, qa_title, "
					+" user_no, qa_regdate "
					+" from shop_qaboard ";
		
		List<QaBoard> qaboardList = new ArrayList<>();
		
		Connection connection =getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
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
	
	//	User에서 user정보를 거ㅏ져와서 박아야함
	public void insertQaBoard(QaBoard qaboard) throws SQLException{
		String sql = "insert into shop_qaboard (qa_no, product_no, qa_title, qa_content, user_no, qa_regdate ) "
					+"values (SHOP_QA_SEQ.nextval, ?, ?, ?, ?, sysdate )";
	
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

	
	public List<QaBoard> getAllQAByUserNo(int userNo)throws SQLException{
		
		String sql = "select QA_NO, QA_TITLE, QA_REGDATE, QA_VIEWCOUNT "
				+ "from SHOP_QABOARD "
				+ "where USER_NO = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		pstmt.setInt(1, userNo);
		ResultSet rs = pstmt.executeQuery();
		List<QaBoard> QAList = new ArrayList<>();
		
		while(rs.next()) {
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
				   + "from shop_qaboard q, shop_user U "
				   + "where q.user_no = U.user_no ";
				  
		
		QaBoard qaBoard = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			qaBoard = new QaBoard();
			User user = new User();
			
			qaBoard.setNo(rs.getInt("qa_no"));
			qaBoard.setTitle(rs.getString("qa_title"));
			qaBoard.setContent(rs.getString("qa_content"));
			qaBoard.setRegdate(rs.getDate("qa_regdate"));
			qaBoard.setUserName(rs.getString("user_name"));
			qaBoard.setUserId(rs.getString("user_id"));
			
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return qaBoard;
	}
	

	public void updateReply(QaBoard qaBoard) throws SQLException{
		String sql = "update shop_qaboard "
				+	 "set "
				+	 "qa_reply = ? "
				+ 	 "where qa_no = ? ";
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, qaBoard.getReply());
		pstmt.setInt(2, qaBoard.getNo());
		
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

		while(rs.next()) {
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
	
	
	
	

	
	
	
	
}
