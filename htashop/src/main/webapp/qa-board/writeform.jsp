<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
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
<title>write</title>
</head>
<body>
	<%@ include file="../common/navbar.jsp"%>
	<%
	String fail = request.getParameter("fail");
	if (loginedUserInfo == null) {
		response.sendRedirect("../loginform.jsp?fail=login-required");
		return;
	}
	ProductDao productDao = ProductDao.getInstance();
	List<Product> productList = productDao.getAllProducts();
	%>
	<div class="container">
		<div class="row mb-3">
			<div class="col-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-sm-10">
				<div class="row mt-2" id="container_title">
					<div class="col">
						<h4 class="fs-6">
							<font color=#777777>Q & A</font> | Q&A 작성
						</h4>
					</div>
				</div>
				<div class="col">
					<form class="border p-3 bg-light" method="post" action="write.jsp">
						<div class="mb-3">
							<label class="col-1 col-form-label text-front">제목</label> <select
								name="title">
								<option selected="selected" value="상품문의">상품문의</option>
								<option value="배송문의">배송문의</option>
								<option value="교환 및 환불문의">교환 및 환불문의</option>
								<option value="기타문의">기타문의</option>
							</select>
						</div>
						<div class="mb-3">
							<label class="col-1 col-form-label text-front">상품명</label> <select
								name="productNo">
								<option selected="selected" value="0">--상품--</option>
								<%
								for (Product product : productList) {
								%>
								<option value="<%=product.getNo()%>"><%=product.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="mb-3">
							<label class="col-1 col-form-label text-front" for="qa-content">내용</label>
							<textarea rows="6" class="form-control" name="content"
								id="content"></textarea>
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
			<%
			if ("emptyTitle".equals(fail)) {
			%>
			<div class="alert alert-danger">
				<strong>[제목 없음]</strong> 제목은 반드시 기입하셔야합니다.
			</div>
			<%
			} else if ("emptyContent".equals(fail)) {
			%>
			<div class="alert alert-danger">
				<strong>[내용 없음]</strong> 내용은 반드시 기입하셔야합니다.
			</div>
			<%
			} else if ("emptyProductName".equals(fail)) {
			%>
			<div class="alert alert-danger">
				<strong>[상품명 없음]</strong> 상품명은 반드시 선택하셔야합니다.
			</div>
			<%
			}
			%>
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>