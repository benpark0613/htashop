<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String pageNo = request.getParameter("pageNo");
	int no = Integer.parseInt(request.getParameter("no"));
	
	if(title == null || title.isBlank()){
		response.sendRedirect("form.jsp?fail=title");
		return;
	}
	
	if(content == null|| content.isBlank()){
		response.sendRedirect("form.jsp?fail=content");
		return;
	}
	
	User loginedUserInfo  = (User)session.getAttribute("logined_user_info");
	
	if(loginedUserInfo == null){
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	
	
	QaBoardDao qaBoardDao = QaBoardDao.getInstance();
	QaBoard qaBoard = qaBoardDao.getQuestionByNo(no);

	qaBoard.setTitle(title);
	qaBoard.setContent(content);
	qaBoard.setUserNo(loginedUserInfo.getUserNo());
	
	qaBoardDao.updateQuestion(qaBoard);
	
	response.sendRedirect("detail.jsp?no="+no+"&pageNo="+pageNo);
%>