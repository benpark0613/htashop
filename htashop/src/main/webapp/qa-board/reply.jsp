<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	String reply = request.getParameter("reply");
	int no = Integer.parseInt(request.getParameter("replyNo"));
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	if (!"admin".equals(loginedUserInfo.getId())){
		response.sendRedirect("detail.jsp?fail=notAdmin");
		return;
	}
	QaBoard qaBoard = new QaBoard();
	qaBoard.setReply(reply);
	qaBoard.setNo(no);
	
	QaBoardDao qaBoardDao = QaBoardDao.getInstance();
	qaBoardDao.updateReply(qaBoard);
	response.sendRedirect("detail.jsp?no="+no);
%>
