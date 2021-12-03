<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
	String section = request.getParameter("section");

	response.sendRedirect("boardManagement.jsp?section="+section);

%>    