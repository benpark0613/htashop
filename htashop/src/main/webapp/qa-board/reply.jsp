<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String reply = request.getParameter("reply");
	int no = Integer.parseInt(request.getParameter("no"));
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	if (loginedUserInfo == null) {
		response.sendRedirect("");
		return;
	}
	
	//loginform가서 fail=login-required 이걸 만들어야함
	
	QaBoard qaBoard = new QaBoard();
	qaBoard.setReply(reply);
	qaBoard.setNo(no);
	
	QaBoardDao qaBoardDao = new QaBoardDao();
	
	qaBoardDao.updateReply(qaBoard);
	
	// 클라이언트에 index.jsp를 재요청하는 URL을 응답으로 보낸다.
	// 클라이언트가 index.jsp를 요청하면 그 클라이언트 전용의 HttpSession객체에 인증된 사용자 정보가 존재하기 때문에 
	// 내비게이션에 인증된 사용자명과 로그아웃 링크가 표시된다.
	response.sendRedirect("list.jsp");
%>
