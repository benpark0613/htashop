<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String leftMenu = (String) pageContext.getAttribute("leftMenu");
%>
	<div id="page-wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li><a href="/htashop/products/exindex.jsp">BEST 20</a></li>
				<li><a href="/htashop/products/exindex.jsp">TOP</a></li>
				<li><a href="/htashop/products/exindex.jsp">BOTTOM</a></li>
				<li><a href="/htashop/notice-board/list.jsp">NOTICE</a></li>
				<li><a href="/htashop/qa-board/list.jsp">Q&A</a></li>
			</ul>
		</div>
	</div>
