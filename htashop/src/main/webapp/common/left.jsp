<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String leftMenu = (String) pageContext.getAttribute("leftMenu");
%>
	<div id="page-wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li><a href="/htashop/products/best20Index.jsp">BEST 20</a></li>
				<li><a href="/htashop/products/topIndex.jsp">TOP</a></li>
				<li><a href="/htashop/products/bottomIndex.jsp">BOTTOM</a></li>
				<li><a href="/htashop/notice-board/list.jsp">NOTICE</a></li>
				<li><a href="/htashop/qa-board/list.jsp">Q&A</a></li>
				<li><a href="#">REVIEW</a></li>
			</ul>
		</div>
	</div>
