<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp의 6번째 라인에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "board");
%>

<%@ include file="../common/navbar.jsp" %>



<div class="container">
	<div class="row mb-3">
		<div class="col">
			<h4>
				<font color=#777777>Q & A</font> |
				상품 Q&A입니다.
			</h4>
		</div>
	</div>
<%	
		String error = request.getParameter("error");
	
	if ("empty".equals(error)) {								// login.jsp에서 사용자 인증처리를 할 때 id와 password값이 비어 있었다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 아이디와 비밀번호는 필수입력값입니다.
			</div>
<%
	} else if ("notfound-user".equals(error)) {					// login.jsp에서 사용자 인증처리를 할 때 id에 해당하는 회원정보가 검색되지 않았다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 회원정보가 존재하지 않습니다.
			</div>
<%	
	} else if ("mismatch-password".equals(error)) {			// login.jsp에서 사용자 인증처리를 회원가입시 입력한 비밀번호와 로그인시 입력한 비밀번호가 일치하지 않았다.
%>
			<div class="alert alert-danger">
				<strong>로그인 실패!!</strong> 비밀번호가 일치하지 않습니다.
			</div>
<%		
	} else if("login-required".equals(error)) {				// 로그인 후 사용가능한 JSP 페이지를 로그인없이 요청했다.
%>
			<div class="alert alert-danger">
				<strong>로그인 필수!!</strong> 로그인이 필요한 페이지를 요청하였습니다.
			</div>
<%
	}
%>
	
	
	
	<div class="row mb-10">
		<div class="col">
			<form class="border p-3 bg-light" method="post" action="write.jsp">
				<div class="mb-3">
					<label class="col-1 col-form-label text-front">제목</label>
					<select >
						<option selected="selected" name="title" title id="상훔문의">상품문의</option>
						<option name="title" title id="배송문의">배송문의</option>
						<option name="title" title id="교환 및 환불문의">교환 및 환불문의</option>
						<option name="title" title id="기타문의">기타문의</option>
					</select>
				</div>
				
				
				<div class="mb-3">
					<label class="col-1 col-form-label text-front" for="qa-content">내용</label>
					<textarea rows="6" class="form-control" name="content" id="content"></textarea>
				</div>
				<div class="row mb-3">
					<div class="col">
					<div class="mb-3 text-end">
						<a href="list.jsp" class="btn btn-secondary">취소</a>
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>