<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<title>Insert title here</title>
</head>
<body>
<%-- <%
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp의 6번째 라인에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "board");
%> --%>
<%@ include file="../common/navbar.jsp" %>
<%-- <%
	//로그인한 사용자정보가 세션에 존재하지 않으면 입력폼을 요청할 수 없다.
	// 클라이언트에게 로그인 정보를 입력하는 loginform.jsp를 재요청하는 응답을 보낸다.
	// 재요청 URL에 오류원인을 포함시킨다.
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
%> --%>
<div class="container">    
	<div class="row mb-3">
		<div class="col">
			<h1 class="fs-3">게시글 등록폼</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
<%
	// form.jsp에서는 요청객체에서 요청파라미터값 error을 조회한다.
	// 새 글 링크를 눌러서 form.jsp를 요청하는 경우에는 요청파라미터 error값이 존재하지 않는다.
	// 새 글 등록에 실패한 경우에만 form.jsp를 요청할 때 생성한 요청객체에 요청파라미터로 error값이 존재한다.
	String error = request.getParameter("error");

	if ("empty-title".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>리뷰 등록 실패!!</strong> 리뷰 제목은 필수입력값입니다.
			</div>
<%
	} else if ("empty-content".equals(error)) {
%>
			<div class="alert alert-danger">
				<strong>리뷰 등록 실패!!</strong> 리뷰 내용은 필수입력값입니다.
			</div>
<%
	}
%>
			<!-- 
				게시글 정보 입력폼이다.
				title, content 정보를 입력받아서 register.jsp로 제출한다.
				register.jsp에서 게시글을 등록하고, 오류가 발생하면 이 페이지를 재요청하는 URL을 응답으로 보낸다.
				register.jsp에서 게시글 등록이 완료되면, list.jsp를 재요청하는 URL을 클라이언트에 응답으로 보낸다. 
			 -->
			<form class="border p-3 bg-light" method="post" action="reviewRegister.jsp">
				<div class="mb-3">
					<label class="form-label" for="review-title">제목</label>
					<input type="text" class="form-control" name="title" id="review-title">
				</div>
				<div class="mb-3">
					<label class="form-label" for="review-content">내용</label>
					<textarea rows="6" class="form-control" name="content"></textarea>
				</div>
				<div class="mb-3 text-end">
					<a href="detail.jsp" class="btn btn-secondary">취소</a>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>