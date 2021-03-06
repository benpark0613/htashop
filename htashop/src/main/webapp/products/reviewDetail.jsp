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
<title>커뮤니티 게시판::리뷰상세 페이지</title>
</head>
<body>
	<%
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
								<h1 class="fs-4"><strong>리뷰상세</strong></h1>
							</div>
					<%
					int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
					String pageNo = request.getParameter("pageNo");
					String error = request.getParameter("error");
					ReviewDao reviewDao = new ReviewDao();
					ReviewDto reviewDto = reviewDao.getReviewDetailByNo(reviewNo);
					reviewDto.setViewCount(reviewDto.getViewCount() + 1);
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
							<img src="../resources/images/<%=reviewDto.getProductName()%>.jpg" style="width: 200px; height: 200px">
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
					<br>
					<div class="col">
						<h1 class="fs-4"><strong>답글</strong></h1>
					</div>
						<hr>											
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
									href="detail.jsp?productNo=<%=reviewDto.getProductNo() %>&reviewNo=<%=reviewDto.getReviewNo()%>&pageNo=<%=pageNo%>" class="btn btn-primary">목록</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>