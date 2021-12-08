<%@page import="com.shop.vo.QaBoard"%>
<%@page import="com.shop.dao.QaBoardDao"%>
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
<title></title>
</head>
<body>
	<%@ include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<%
			String fail = request.getParameter("fail");
			QaBoardDao qaBoardDao = QaBoardDao.getInstance();
			int no = Integer.parseInt(request.getParameter("no"));
			QaBoard qaBoard = qaBoardDao.getQuestionByNo(no);
			%>
			<div class="col">
				<form method="post" action="modify.jsp?">
					<input type="hidden" name="productNo"
						value="<%=qaBoard.getProductNo()%>"> <input type="hidden"
						name="no" value="<%=qaBoard.getNo()%>">
					<table class="table border p-3 bg-light">
						<tbody>
							<tr class="d-flex">
								<th class="col-2">번호</th>
								<td class="col-4"><%=qaBoard.getNo()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">제목</th>
								<td class="col-4"><select name="title">
										<option selected="selected" disabled="disabled"
											value="<%=qaBoard.getTitle()%>"><%=qaBoard.getTitle()%></option>
										<option selected="selected" value="상품문의">상품문의</option>
										<option value="배송문의">배송문의</option>
										<option value="교환 및 환불문의">교환 및 환불문의</option>
										<option value="기타문의">기타문의</option>
								</select></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">작성자</th>
								<td class="col-4"><%=qaBoard.getUserName()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">작성일</th>
								<td class="col-4"><%=qaBoard.getRegdate()%></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">내용</th>
								<td class="col-10"><textarea rows="20" class="form-control"
										name="content" style="resize: none;"><%=qaBoard.getContent()%></textarea></td>
							</tr>
							<tr class="d-flex">
								<th class="col-2">댓글</th>
								<td class="col-10"><%=qaBoard.getReply()%></td>
							</tr>
						</tbody>
					</table>
					<div class="mb-3 text-end">
						<a href="detail.jsp?no=<%=qaBoard.getNo()%>"
							class="btn btn-secondary">취소</a>
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</form>
			</div>
		</div>
		<%
		if ("content".equals(fail)) {
		%>
		<div class="alert alert-danger">
			<strong>[내용을 입력하세요]</strong> 내용은 반드시 기입해주세요..
		</div>
		<%
		}
		%>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">
	</script>
</body>
</html>