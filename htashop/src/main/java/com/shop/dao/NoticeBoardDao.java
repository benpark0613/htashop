package com.shop.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shop.dto.NoticeBoardListDto;
import com.shop.vo.NoticeBoard;

public class NoticeBoardDao {

	private static NoticeBoardDao self = new NoticeBoardDao();
	private NoticeBoardDao() {}
	public static NoticeBoardDao getInstance() {
		return self;
	}
	
	/**
	 * 모든 공지사항 게시글 정보를 반환한다.
	 * 
	 * @return 공지게시글 목록
	 * @throws SQLException
	 */
	public List<NoticeBoardListDto> getNoticeBoardList(int begin, int end, String searchField, String searchText) throws SQLException {
		String sql = "select notice_no, notice_title, notice_content, notice_regdate, notice_viewcount, user_no, user_id "
				   + "from (select row_number() over (order by N.notice_no desc) rn, "
				   + "			   N.notice_no, N.notice_title, N.notice_content, N.notice_regdate, N.notice_viewcount, "
				   + "             U.user_no, U.user_id "
				   + "      from shop_noticeboard N, shop_user U "
				   + "		where N.user_no = U.user_no ";
		if ("notice_title".equals(searchField)) {
			   sql +=  " 	and notice_title like '%' || ? || '%') ";
		}
		if ("notice_content".equals(searchField)) {
			   sql +=  "	and notice_content like '%' || ? || '%') ";
		}
		if ("user_id".equals(searchField)) {
			   sql +=  "	and user_id like '%' || ? || '%') ";
		}
			   sql +="where rn >=? and rn <= ? ";

		List<NoticeBoardListDto> noticeBoards = new ArrayList<NoticeBoardListDto>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, searchText);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			NoticeBoardListDto noticeBoardListDto = new NoticeBoardListDto();
			noticeBoardListDto.setNoticeNo(rs.getInt("notice_no"));
			noticeBoardListDto.setNoticeTitle(rs.getString("notice_title"));
			noticeBoardListDto.setNoticeWriter(rs.getString("user_id"));
			noticeBoardListDto.setNoticeRegDate(rs.getDate("notice_regdate"));
			noticeBoardListDto.setNoticeViewCount(rs.getInt("notice_viewcount"));
			
			noticeBoards.add(noticeBoardListDto);
		}

		rs.close();
		pstmt.close();
		connection.close();

		return noticeBoards;
	}
	
	/**
	 * 모든 공지사항 게시글 정보를 반환한다.
	 * 
	 * @return 공지게시글 목록
	 * @throws SQLException
	 */
	public List<NoticeBoardListDto> getNoticeBoardList(int begin, int end) throws SQLException {
		String sql = "select notice_no, notice_title, notice_content, notice_regdate, notice_viewcount, user_no, user_id "
				   + "from (select row_number() over (order by N.notice_no desc) rn, "
				   + "			   N.notice_no, N.notice_title, notice_content, N.notice_regdate, N.notice_viewcount, "
				   + "             U.user_no, U.user_id "
				   + "      from shop_noticeboard N, shop_user U "
				   + "		where N.user_no = U.user_no) "
				   + "where rn >=? and rn <= ? ";

		List<NoticeBoardListDto> noticeBoards = new ArrayList<NoticeBoardListDto>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			NoticeBoardListDto noticeBoardListDto = new NoticeBoardListDto();
			noticeBoardListDto.setNoticeNo(rs.getInt("notice_no"));
			noticeBoardListDto.setNoticeTitle(rs.getString("notice_title"));
			noticeBoardListDto.setNoticeWriter(rs.getString("user_id"));
			noticeBoardListDto.setNoticeRegDate(rs.getDate("notice_regdate"));
			noticeBoardListDto.setNoticeViewCount(rs.getInt("notice_viewcount"));
			
			noticeBoards.add(noticeBoardListDto);
		}

		rs.close();
		pstmt.close();
		connection.close();

		return noticeBoards;
	}
	
	/**
	 * 지정된 공지게시글 번호의 글을 반환한다.
	 * @param no 공지게시글 번호
	 * @return 공지게시글
	 * @throws SQLException
	 */
	public NoticeBoardListDto getNoticeBoardByNo(int no) throws SQLException {
		String sql = "select N.notice_no, N.notice_title, N.notice_content, N.notice_regdate, N.notice_viewcount, "
				   + "U.user_no, U.user_id "
				   + "from shop_noticeboard N, shop_user U "
				   + "where N.user_no = U.user_no "
				   + "and N.notice_no = ? ";
		
		NoticeBoardListDto noticeBoardDto = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			noticeBoardDto = new NoticeBoardListDto();
			noticeBoardDto.setNoticeNo(rs.getInt("notice_no"));
			noticeBoardDto.setNoticeTitle(rs.getString("notice_title"));
			noticeBoardDto.setNoticeContent(rs.getString("notice_content"));
			noticeBoardDto.setNoticeRegDate(rs.getDate("notice_regdate"));
			noticeBoardDto.setNoticeViewCount(rs.getInt("notice_viewcount"));
			noticeBoardDto.setNoticeWriter(rs.getString("user_id"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return noticeBoardDto;
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
	 * 수정된 게시글 정보를 테이블에 입력한다.
	 * @param noticeBoardDetailDto 수정할 게시글 상세정보 
	 * @throws SQLException
	 */
	public void updateNoticeBoard(NoticeBoardListDto noticeBoardDto) throws SQLException {
		String sql = "update shop_noticeboard "
				   + "set "
				   + "	notice_title = ?, "
				   + "	notice_content = ?, "
				   + "	notice_viewcount = ? "
				   + "where notice_no = ? ";
		
		Connection connection = getConnection();     
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, noticeBoardDto.getNoticeTitle());
		pstmt.setString(2, noticeBoardDto.getNoticeContent());
		pstmt.setInt(3, noticeBoardDto.getNoticeViewCount());
		pstmt.setInt(4, noticeBoardDto.getNoticeNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}

	/**
	 * 지정된 번호의 게시글을 삭제한다.
	 * @param no 지정된 게시글의 번호
	 * @throws SQLException
	 */
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
	 * 공지게시글의 갯수를 반환한다. (페이지네이션기능)
	 * @return 공지게시글 갯수
	 * @throws SQLException
	 */
	public int getTotalRecords(String searchField, String searchText) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from shop_noticeboard N, shop_user U "
				   + "where N.user_no = U.user_no ";
		if ("notice_title".equals(searchField)) {
			   sql +="and notice_title like '%' || ? || '%' ";
		}
		if ("notice_content".equals(searchField)) {
			   sql +="and notice_content like '%' || ? || '%' ";
		}
		if ("user_id".equals(searchField)) {
			   sql +="and user_id like '%' || ? || '%' ";
		}
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, searchText);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalRecords = rs.getInt("cnt");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	/**
	 * 공지게시글의 갯수를 반환한다. (페이지네이션기능)
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
	
	public int getTodayTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from shop_noticeboard "
				   + "where notice_regdate >= to_date(trunc(sysdate)) "
				   + "and notice_regdate < to_date(trunc(sysdate+1)) ";
		
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

















