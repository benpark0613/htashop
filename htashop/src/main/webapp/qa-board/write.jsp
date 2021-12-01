<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// loginform.jsp에서 제출한 폼입력값을 조호한다.
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	if (title != null && title.isBlank()) {
		response.sendRedirect("loginform.jsp?error=emptyTitle");
		return;
	}
	
	if (content != null && content.isBlank()) {
		response.sendRedirect("loginform.jsp?error=emptytPassword");
		return;
	}
	//User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	//if (loginUserInfo == null) {
	//	response.sendRedirect("../loginform.jsp?error=login-required");
	//	return;
	//}
	
	QaBoard qaBoard = new QaBoard();
	QaBoardDao qaBoardDao = new QaBoardDao();
	
	
	qaBoard.setTitle(title);
	qaBoard.setContent(content);
	
	qaBoardDao.insertQaBoard(qaBoard);
	
	// 클라이언트에 index.jsp를 재요청하는 URL을 응답으로 보낸다.
	// 클라이언트가 index.jsp를 요청하면 그 클라이언트 전용의 HttpSession객체에 인증된 사용자 정보가 존재하기 때문에 
	// 내비게이션에 인증된 사용자명과 로그아웃 링크가 표시된다.
	response.sendRedirect("list.jsp");
%>