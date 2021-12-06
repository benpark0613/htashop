<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="com.shop.vo.Review"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>커뮤니티 게시판::상세</title>
</head>
<body>
	<%
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp의 6번째 라인에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "reivew");
	pageContext.setAttribute("leftMenu", "review");
	%>
	<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-sm-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-sm-10 align-self-end mt-4">
				<div class="row mb-3">
					<div class="col">
						<h1 class="fs-3">리뷰 상세</h1>
					</div>
					<%
					// 클라이언트는 게시글 상세 페이지를 조회할 때 "detail.jsp?no=글번호&pageNo=페이지번호" 로 요청한다.(list.jsp의 78번 라인 참조)
					// 요청파라미터에서 글번호와 페이지 번호를 조회한다.
					int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
					String pageNo = request.getParameter("pageNo");
					String error = request.getParameter("error");
					// 게시글 정보를 제공하는 BoardDao객체를 획득한다.
					ReviewDao reviewDao = new ReviewDao();
					// 게시글 번호에 해당하는 글 정보를 조회한다.
					ReviewDto reviewDto = reviewDao.getReviewDetailByNo(reviewNo);
					// 게시글의 조회수를 1 증가시킨다.
					reviewDto.setViewCount(reviewDto.getViewCount() + 1);
					// 조회수가 1증가된 글정보를 테이블에 반영시킨다.
					reviewDao.updateReviewDetail(reviewDto);
					%>
					<div class="row mb-3">
						<div class="col">
							<%
							if ("deny-delete".equals(error)) {
							%>
							<div class="alert alert-danger">
								<strong>삭제 실패!!</strong> 자신이 작성한 글이 아닌 경우 삭제할 수 없습니다.
							</div>
							<%
							} else if ("deny-update".equals(error)) {
							%>
							<div class="alert alert-danger">
								<strong>수정 실패!!</strong> 자신이 작성한 글이 아닌 경우 수정할 수 없습니다.
							</div>
							<%
							}
							%>
							<img
								src="../resources/images/<%=reviewDto.getProductName()%>.jpg"
								style="width: 200px; height: 200px">
							<table class="table">
								<tbody>
									<tr class="d-flex">
										<th class="col-2">물품명</th>
										<td class="col-10"><%=reviewDto.getProductName()%></td>
									</tr>								
									<tr class="d-flex">
										<th class="col-2">작성자</th>
										<td class="col-4"><%=reviewDto.getUserName()%></td>
										<th class="col-2">등록일</th>
										<td class="col-4"><%=reviewDto.getReviewCreatedDate()%></td>
									</tr>
									<tr class="d-flex">
										<th class="col-2">제목</th>
										<td class="col-4"><%=reviewDto.getTitle()%></td>

									</tr>
									<tr class="d-flex">
										<th class="col-2">내용</th>
										<td class="col-10"><%=reviewDto.getReviewContent()%></td>
									</tr>
								</tbody>
							</table>
				
							<%
								if(reviewDto.getAnswerContent() != null){
							%>
							<hr>
					<div class="col">
						<h5 class="fs-3">리뷰 답글</h5>
					</div>							
							<table class="table">
								<tbody>							
									<tr class="d-flex">
										<th class="col-2">작성자</th>
										<td class="col-4">HTA shop</td>
										<th class="col-2">등록일</th>
										<td class="col-4"><%=reviewDto.getReviewCreatedDate()%></td>
									</tr>
									<tr class="d-flex">
										<th class="col-2">내용</th>
										<td class="col-10"><%=reviewDto.getAnswerContent()%></td>
									</tr>
								</tbody>
							</table>
							<% 
								}
							%>							
						</div>
					</div>
					<div class="row mb-3">
						<div class="col">
							<div class="d-flex justify-content-between">
								<div>
									<%
									if (loginedUserInfo != null && (loginedUserInfo.getUserNo() == reviewDto.getUserNo())) {
									%>
										<a href="delete.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>&productNo=<%=reviewDto.getProductNo()%>"
										class="btn btn-danger">리뷰 삭제</a> 
										<a href="modifyForm.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>"
										class="btn btn-warning">리뷰 수정</a>
									<%
									}
									%>
									<%
									if (loginedUserInfo != null && "admin".equals(loginedUserInfo.getUserType())) {
									%>
									<%
										if(reviewDto.getAnswerContent() != null) {
									%>
										<a href="delete.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>&productNo=<%=reviewDto.getProductNo()%>"
										class="btn btn-danger">리뷰 삭제</a>  									
										<a href="replyForm.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>"
										class="btn btn-info">답글 수정</a>	
										<a href="answerDelete.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>&productNo=<%=reviewDto.getProductNo()%>"
										class="btn btn-danger">답글 삭제</a>																				
									<% 		
										} else if ((reviewDto.getAnswerContent() == null)){		
									%>
										<a href="delete.jsp?reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>&productNo=<%=reviewDto.getProductNo()%>"
										class="btn btn-danger">리뷰 삭제</a> 										
										<a href="replyForm.jsp?reviewNo=<%=reviewNo%>&pageNo=<%=pageNo%>"
										class="btn btn-primary">답글 작성</a>
																		
									<%		
										}									
									%>	
									<div>
									</div>
									<%
									}
									%>
								</div>
								<a
									href="detail.jsp?productNo=<%=reviewDto.getProductNo() %>&reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>"
									class="btn btn-primary">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>