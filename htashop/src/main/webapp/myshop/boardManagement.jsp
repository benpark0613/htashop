<%@page import="com.shop.vo.Review"%>
<%@page import="com.shop.vo.QABoard"%>
<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp" %>
<%@ include file="../common/left.jsp" %>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<%
	ReviewDao reviewDao = new ReviewDao();
	QaBoardDao qaBoardDao = new QaBoardDao();
	List<Review> reviewList = reviewDao.getAllReviewByCustomerNo(loginedCustomerInfo.getCustomerNo());
	List<QABoard> QAList = qaBoardDao.getAllQAByCustomerNo(loginedCustomerInfo.getCustomerNo());
	
%>
<body>
<div class="container">    
 <table class="table">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">분류</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">작성일</th>
	      <th scope="col">조회수</th>
	    </tr>
	  </thead>
	  <tbody>
<%
	for(Review review : reviewList){
%>	  
	    <tr>
	      <th scope="row"><%=loginedCustomerInfo.getCustomerNo() %></th>
	      <td>리뷰</td>
	      <td><%=review.getTitle() %></td>
	      <td><%=loginedCustomerInfo.getCustomerName() %></td>
	      <td><%=review.getCreatedDate() %></td>
	      <td><%=review.getViewCount() %></td>
	    </tr>
<%
	}
%>	    

<%
	for(QABoard qa : QAList){
%>	  
	    <tr>
	      <th scope="row"><%=loginedCustomerInfo.getCustomerNo() %></th>
	      <td>QA</td>
	      <td><%=qa.getTitle() %></td>
	      <td><%=loginedCustomerInfo.getCustomerName() %></td>
	      <td><%=qa.getRegDate() %></td>
	      <td><%=qa.getViewCount() %></td>
	    </tr>
<%
	}
%>	    
	    
	  </tbody>
	</table>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>