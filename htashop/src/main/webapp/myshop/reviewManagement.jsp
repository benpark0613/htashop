<%@page import="com.shop.vo.Review"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.List"%>
<%@page import="utils.Pagination"%>
<%@page import="com.shop.vo.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
<%
	String section = request.getParameter("section");

	String pageNo = StringUtils.defaultString(request.getParameter("page"), "1");
	String option = StringUtils.defaultString(request.getParameter("option"), "");
	String keyword = StringUtils.defaultString(request.getParameter("keyword"), "");
    
	ReviewDao reviewDao = new ReviewDao();
	Criteria criteria = new Criteria();
	if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
      	criteria.setOption(option);
      	criteria.setKeyword(keyword);
    }
	
	int totalRows = reviewDao.getCountReviewByUserNo(criteria, loginedUserInfo.getUserNo());
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	criteria.setBeginIndex(pagination.getBegin());
	criteria.setEndIndex(pagination.getEnd());
	
	List<Review> reviewList = reviewDao.getAllReviewByUserNo(criteria, loginedUserInfo.getUserNo());
%>
	<div class="container">
		<div class="row">
			<div class="col-1">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-11">
				<div class="btn-group">
						<a href="reviewManagement.jsp" class="btn btn-primary active">리뷰</a> 
						<a href="qaBoardManagement.jsp" class="btn btn-primary">QA</a> 
				</div>

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
							for (Review review : reviewList) {
							%>
							<tr>
								<th scope="row"><%=review.getReviewNo()%></th>
								<td>Review</td>
								<td><a href="../products/reviewDetail.jsp?reviewNo=<%= review.getReviewNo()%>"><%=review.getTitle()%></a></td>
								<td><%=loginedUserInfo.getName()%></td>
								<td><%=review.getCreatedDate()%></td>
								<td><%=review.getViewCount()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col text-center">
				<div class="container">
					<ul class="pagination justify-content-center">
					
						<li class="page-item <%=pagination.isExistPrev() ? "" : "disabled" %>">
							<a href="" class="page-link" onclick="moveToPage(event, <%=pagination.getPrevPage() %>)" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						
						<%
							for(int no = pagination.getBeginPage(); no <= pagination.getEndPage(); no++){
						%>
							<li class="page-item <%=no == pagination.getPageNo() ? "active" : "" %>">
								<a href=""class="page-link" onclick="moveToPage(event, <%=no%>)"><%=no%></a>
							</li>
						<%
							}
						%>
						<li class="page-item <%=pagination.isExistNext() ? "" : "disabled" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getNextPage() %>)" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			
			

		</div>
		<div class="row text-center">

			<form id="form-search" class="row row-cols-lg-auto g-3" method="get" action="reviewManagement.jsp">
					<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
					<div class="col-2 offset-3">
						<div class="input-group">
							<select class="form-select" id="search-option" name="option">
								<option value="title" <%="title".equals(option) ? "selected" : ""%>>제목</option>
								<option value="content" <%="content".equals(option) ? "selected" : ""%>>내용</option>
							</select>
						</div>
					</div>
					<div class="col-3">
						<div class="input-group">
							<input type="text" class="form-control" id="search-keyword" name="keyword" value="<%=StringUtils.isBlank(keyword) ? "" : keyword%>"	placeholder="검색어를 입력하세요">
						</div>
					</div>
					<div class="col-2">
						<div class="input-group">
							<button class="btn btn-primary" type="button" id="btn-search" onclick="searchBoards(1)">검색</button>
						</div>
					</div>
				</form>

		</div>
	</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<script type="text/javascript">
		
		function moveToPage(event, page) {
			event.preventDefault();	
			searchBoards(page);
		}
		
		function searchBoards(page) {
			document.getElementById("page-field").value = page;
			var form = document.getElementById("form-search");
			form.submit();
		}  
		</script>
</body>
</html>