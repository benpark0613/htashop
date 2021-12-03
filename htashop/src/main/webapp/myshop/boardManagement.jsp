<%@page import="utils.Pagination"%>
<%@page import="com.shop.vo.Criteria"%>
<%@page import="com.shop.dto.BoardDto"%>
<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.vo.Review"%>
<%@page import="com.shop.dao.QaBoardDao"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/navbar.jsp"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title></title>
</head>
<%
ReviewDao reviewDao = new ReviewDao();
QaBoardDao qaBoardDao = new QaBoardDao();

int totalRecords = qaBoardDao.countAllQaBoards(loginedUserInfo.getUserNo());
String pageNo = request.getParameter("pageNo");

Pagination pagination = new Pagination(pageNo, totalRecords);
//List<QaBoard> qaboardList = qaBoardDao.getAllQAByUserNoRN(loginedUserInfo.getUserNo(), pagination.getBegin(), pagination.getEnd());
List<QaBoard> qaboardList = qaBoardDao.getAllQAByUserNo(loginedUserInfo.getUserNo());
List<Review> reviewList = reviewDao.getAllReviewByUserNo(loginedUserInfo.getUserNo());


// 페이지번호, 검색옵션, 검색키워드를 요청파라미터에서 조회한다.

String section = request.getParameter("section");



// 검색조건을 저장하는 Criteria 객체를 생성한다.
//Criteria criteria = new Criteria();

// 검색옵션과 검색키워드가 모두 있는 경우에만 Criteria객체에 검색옵션과 검색 키워드를 저장한다.
//if (!StringUtils.isEmpty(option) && !StringUtils.isEmpty(keyword)) {
//  	criteria.setOption(option);
  	//criteria.setKeyword(keyword);
//}
// 검색조건에 맞는 게시글의 총 갯수를 조회한다.
//int totalRows = reviewDao.getAllBoardsCount(criteria);

// 페이징처리에 필요한 정보를 제공하는 Pagination객체를 생성한다.
//Pagination1 pagination = new Pagination1(pageNo, totalRows);

// 게시글 리스틀 조회할 때 필요한 조회범위를 Criteria객체에 저장한다.
//criteria.setBeginIndex(pagination.getBegin());
//criteria.setEndIndex(pagination.getEnd());

// 검색조건에 맞는 게시글 목록을 조회한다.
//List<BoardDto> boardsList = reviewDao.getAllBoardList(criteria);
%>
<body>
	<div class="container">
		<div class="row">
			<div class="col-1">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-11">
			
				<div class="container">
				
					<div class="btn-group">
						<a href="boardSearch.jsp?section=review" class="btn btn-primary active" aria-current="page">리뷰</a> 
						<a href="boardSearch.jsp?section=QA" class="btn btn-primary">QA</a> 
					</div>

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
							if("QA".equals(section)){
							for (QaBoard qaboard : qaboardList) {
							%>
							<tr>
								<th scope="row"><%=qaboard.getNo()%></th>
								<td>QA</td>
								<td><%=qaboard.getTitle()%></td>
								<td><%=loginedUserInfo.getName()%></td>
								<td><%=qaboard.getRegdate()%></td>
								<td><%=qaboard.getViewCount()%></td>
							</tr>
							<%
								}
							}
							if("review".equals(section)){
							for (Review reviewboard : reviewList) {
							%>
							<tr>
								<th scope="row"><%=reviewboard.getReviewNo()%></th>
								<td>리뷰</td>
								<td><%=reviewboard.getTitle()%></td>
								<td><%=loginedUserInfo.getName()%></td>
								<td><%=reviewboard.getCreatedDate()%></td>
								<td><%=reviewboard.getViewCount()%></td>
							</tr>
							<%
							}
							}
							%>

						</tbody>
					</table>
					<div>
						<form id="form-search" method="get" action="boardManagement.jsp">
							<input type="hidden" id="page-field" name="page" value="1">
							<select name="option">
								<option value="title">제목</option>
								<option value="writer">작성자</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="keyword">
							<button type="button" onclick="searchBoards(1)">검색</button>
						</form>
						<ul class="pagination">
						
							<li class="page-item"><a href="">1</a></li>
							<li class="page-item"><a href="">2</a></li>
							<li class="page-item"><a href="">3</a></li>
							<li class="page-item"><a href="">4</a></li>
							<li class="page-item"><a href="">5</a></li>
						</ul>

					</div>
				</div>
			</div>


		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>