<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// TODO 로그인(관리자) 정보 추가하기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	NoticeBoard noticeBoard = new NoticeBoard();
	noticeBoard.setTitle(title);
	noticeBoard.setContent(content);
	
	NoticeBoardDao noticeBoardDao = new NoticeBoardDao();
	response.sendRedirect("list.jsp");
%>