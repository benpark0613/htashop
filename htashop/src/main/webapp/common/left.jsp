<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String leftMenu = (String)pageContext.getAttribute("leftMenu");
%>    
<ul class="list-group mt-4">
   <li class="list-group-item"><a href="" class="list-rink">BEST 20</a></li>
   <li class="list-group-item"><a href="" class="list-rink">TOP</a></li>
   <li class="list-group-item"><a href="" class="list-rink">BOTTOM</a></li>
</ul>
<ul class="list-group mt-3">
	<li class="list-group-item"><a href="/htashop/notice-board/list.jsp" class="list-rink">NOTICE</a></li>
	<li class="list-group-item"><a href="/htashop/qa-board/list.jsp" class="list-rink">Q&A</a></li>
	<li class="list-group-item"><a href="" class="list-rink">REVIEW</a></li>
</ul>
