package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.vo.NoticeBoard;

public class NoticeBoardDao {
	
	/**
	 * 모든 공지사항 게시글 정보를 반환한다.
	 * 
	 * @return 공지게시글 목록
	 * @throws SQLException
	 */
	public List<NoticeBoard> getNoticeBoardList() throws SQLException {
		String sql = "select N.notice_no, U.user_no, N.notice_title, N.notice_content, N.notice_regdate, N.notice_viewcount"
				   + "U.user_id "
				   + "from shop_noticeboard N, shop_user U "
				   + "where N.user_no = U.user_no ";

		List<NoticeBoard> noticeBoardList = new ArrayList<NoticeBoard>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			NoticeBoard noticeBoard = new NoticeBoard();
			
			noticeBoard.setNo(rs.getInt("notice_no"));
			noticeBoard.setUserNo(rs.getInt("user_no"));
			noticeBoard.setTitle(rs.getString("notice_title"));
			noticeBoard.setContent(rs.getString("notice_content"));
			noticeBoard.setRegDate(rs.getDate("notice_regdate"));
			noticeBoard.setViewCount(rs.getInt("notice_viewcount"));

			noticeBoardList.add(noticeBoard);
		}

		rs.close();
		pstmt.close();
		connection.close();

		return noticeBoardList;
	}
	
	/**
	 * 지정된 번호의 공지게시글을 반환한다.
	 * @param no 공지게시글 번호
	 * @return 게시글 정보
	 * @throws SQLException
	 */
	public NoticeBoard getNoticeBoardDetailByNo(int no) throws SQLException {
		String sql = "select N.notice_no, U.user_no, N.notice_title, N.notice_content, N.notice_regdate, N.notice_viewcount "
				   + "from shop_noticeboard N, shop_user U "
				   + "where N.user_no = U.user_no "
				   + "where N.notice_no = ? ";

		NoticeBoard noticeBoard = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			noticeBoard = new NoticeBoard();
			
			noticeBoard.setNo(rs.getInt("notice_no"));
			noticeBoard.setUserNo(rs.getInt("user_no"));
			noticeBoard.setTitle(rs.getString("notice_title"));
			noticeBoard.setContent(rs.getString("notice_content"));
			noticeBoard.setRegDate(rs.getDate("notice_regdate"));
			noticeBoard.setViewCount(rs.getInt("notice_viewcount"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return noticeBoard;
	}

	/**
	 * 지정된 공지게시글 정보를 테이블에 저장한다.
	 * @param noticeBoard 공지게시글 정보
	 * @throws SQLException
	 */
	public void insertNoticeBoard(NoticeBoard noticeBoard) throws SQLException {
		String sql = "insert into shop_noticeboard (notice_no, user_no, notice_title, notice_content) "
				   + "values (shop_notice_seq.nextval, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, noticeBoard.getUserNo());
		pstmt.setString(2, noticeBoard.getTitle());
		pstmt.setString(3, noticeBoard.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 수정된 정보가 포함된 공지게시글 정보를 테이블에 반영한다.
	 * @param noticeBoard
	 * @throws SQLException
	 */
	public void updateNoticeBoard(NoticeBoard noticeBoard) throws SQLException {
		String sql = "update shop_noticeboard "
				   + "set "
				   + "	notice_title = ?, "
				   + "	notice_content = ?, "
				   + "	notice_viewcount = ? "
				   + "where notice_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, noticeBoard.getTitle());
		pstmt.setString(2, noticeBoard.getContent());
		pstmt.setInt(3, noticeBoard.getViewCount());
		pstmt.setInt(4, noticeBoard.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void deleteNoticeBoard(int no) throws SQLException {
		String sql = "delete from shop_noticeboard "
				   + "where notice_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	/**
	 * 공지게시글의 갯수를 반환한다.
	 * @return 공지게시글 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from shop_noticeboard ";
		
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

















