<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.dto.NoticeBoardListDto"%>
<%@page import="com.shop.vo.NoticeBoard"%>
<%@page import="com.shop.dao.NoticeBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" />
<title>공지</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "notice");
%>
<%@ include file="../common/navbar.jsp"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	String pageNo = request.getParameter("pageNo");
	String error = request.getParameter("error");
	
	NoticeBoardDao noticeBoardDao = NoticeBoardDao.getInstance();
	NoticeBoardListDto dto = noticeBoardDao.getNoticeBoardByNo(no);
	dto.setNoticeViewCount(dto.getNoticeViewCount() + 1);
	noticeBoardDao.updateNoticeBoard(dto);
%>
	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-10">
				<div class="row mb-3">
					<div class="col">
						<h1 class="fs-3">게시글 상세</h1>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col">
						<table class="table">
							<tbody>
								<tr class="d-flex">
									<th class="col-2">번호</th>
									<td class="col-4"><%=dto.getNoticeNo()%></td>
									<th class="col-2">등록일</th>
									<td class="col-4"><%=dto.getNoticeRegDate()%></td>
								</tr>
								<tr class="d-flex">
									<th class="col-2">제목</th>
									<td class="col-4"><%=dto.getNoticeTitle()%></td>
									<th class="col-2">작성자</th>
									<td class="col-4"><%=dto.getNoticeWriter()%></td>
								</tr>
								<tr class="d-flex">
									<th class="col-2">조회수</th>
									<td class="col-4"><%=dto.getNoticeViewCount()%></td>
								</tr>
								<tr class="d-flex">
									<th class="col-2">내용</th>
									<td class="col-10 row-20"><%=dto.getNoticeContent()%></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row mb-3">
					<div class="col">
						<div class="d-flex justify-content-between">
<% 
	if (loginedUserInfo != null && "admin".equals(loginedUserInfo.getId())) { 
%>
							<div>
								<a href="form.jsp" class="btn btn-success">글쓰기</a>
								<a href="modify.jsp?no=<%=dto.getNoticeNo() %>&pageNo=<%=pageNo %>" class="btn btn-warning">수정</a>
								<!-- Button trigger modal -->
								<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#notice-delete">
								  	삭제
								</button>
								<!-- Modal -->
								<div class="modal fade" id="notice-delete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title" id="staticBackdropLabel">게시글 삭제 확인</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								        정말 게시글을 삭제하시겠습니까?
								      </div>
								      <div class="modal-footer">
								        <a href="delete.jsp?no=<%=dto.getNoticeNo( )%>&pageNo=<%=pageNo %>" class="btn btn-danger" id="notice-delete">삭제</a> 
								        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								      </div>
								    </div>
								  </div>
								</div>
							</div>
<%
	}
%>
							<div>
								<a href="list.jsp?pageNo=<%=pageNo%>" class="btn btn-primary">목록</a>
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
