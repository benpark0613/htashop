<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="java.util.List"%>
<%@page import="utils.Pagination"%>
<%@page import="com.shop.vo.Criteria"%>
<%@page import="com.shop.dao.QaBoardDao"%>
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
	
	QaBoardDao qaBoardDao = new QaBoardDao();
	Criteria criteria = new Criteria();
	if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
      	criteria.setOption(option);
      	criteria.setKeyword(keyword);
    }
	int totalRows = qaBoardDao.getCountQaBoardsByUserNo(criteria, loginedUserInfo.getUserNo());
	
	Pagination pagination = new Pagination(pageNo, totalRows);
	
	criteria.setBeginIndex(pagination.getBegin());
	criteria.setEndIndex(pagination.getEnd());
	
	List<QaBoard> qaBoardList = qaBoardDao.getAllQAByUserNoRN(criteria, loginedUserInfo.getUserNo());
%>
	<div class="container">
		<div class="row">
			<div class="col-1">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-11">
				<div class="btn-group">
						<a href="reviewManagement.jsp" class="btn btn-primary active" aria-current="page">리뷰</a> 
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
							for (QaBoard qaboard : qaBoardList) {
							%>
							<tr>
								<th scope="row"><%=qaboard.getNo()%></th>
								<td>QA</td>
								<td><a href="../qa-board/detail.jsp?no=<%=qaboard.getNo()%>"><%=qaboard.getTitle()%></a></td>
								<td><%=loginedUserInfo.getName()%></td>
								<td><%=qaboard.getRegdate()%></td>
								<td><%=qaboard.getViewCount()%></td>
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
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getPrevPage() %>)" aria-label="Previous"> 
								<span aria-hidden="true">&laquo;</span>
							</a>
						</li>
						<%
							for(int no=pagination.getBeginPage(); no<=pagination.getEndPage(); no++){
							
						%>
						<li class="page-item <%=no == pagination.getPageNo() ? "active" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=no %>)"><%=no %></a>
						</li>
						<%
							}
						%>
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" : "" %>">
							<a class="page-link" href="" onclick="moveToPage(event, <%=pagination.getNextPage() %>)" aria-label="Next"> 
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
			
			

		</div>
		<div class="row text-center">

			<form id="form-search" method="get" action="qaBoardManagement.jsp">
			
				<input type="hidden" id="page-field" name="page" value="<%=pageNo%>">
				<select name="option">
					<option value="title" <%="title".equals(option) ? "selected" : "" %>>제목</option>
					<option value="content" <%="content".equals(option) ? "selected" : "" %>>내용</option>
				</select>
				<input type="text" id="search-keyword"name="keyword" value="<%=StringUtils.isBlank(keyword) ? "" : keyword %>" placeholder="검색어를 입력하세요">
				<button type="button" onclick="searchBoards(1)">검색</button>

			</form>

		</div>
	</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
		<script type="text/javascript">
			function moveToPage(event, page){
				event.preventDefault();
				searchBoards(page);
			}
			
			function searchBoards(page){
					document.getElementById("page-field").value = page;
					var form = document.getElementById("form-search");
					form.submit();
			}		
		</script>
</body>
</html>