<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	String section = request.getParameter("section");

	String pageNo = request.getParameter("pageNo");

	response.sendRedirect("boardManagement.jsp?section="+section);

%>    