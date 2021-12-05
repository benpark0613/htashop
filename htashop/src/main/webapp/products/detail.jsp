<%@page import="com.shop.dto.ReviewDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="com.shop.vo.Review"%>
<%@page import="java.util.List"%>
<%@page import="utils.Pagination"%>
<%@page import="com.shop.dao.ReviewDao"%>
<%@page import="com.shop.vo.Product"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="../resources/css/newstyle.css" rel="stylesheet" />
<title>Insert title here</title>
<style type="text/css"> 
a { text-decoration:none;
	color : black;
	 } 
</style> 
</head>
</head>
<body>
	<%
	pageContext.setAttribute("menu", "detail");
	pageContext.setAttribute("leftMenu", "detail");
	%>
	<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-sm-2">
				<%@ include file="../common/left.jsp"%>
			</div>
			<div class="col-sm-10 align-self-end mt-4">
				<div class="row mb-3">
					<%
					int no = Integer.parseInt(request.getParameter("no"));

					ProductDao productDao = ProductDao.getInstance();
					ReviewDto reviewDto = new ReviewDto();
					Product product = productDao.getProductDetailById(no);
					int reviewNo = reviewDto.getReviewNo();
					String pageNo = request.getParameter("pageNo");
					ReviewDao reviewDao = new ReviewDao();
					int totalRecords = reviewDao.getTotalRecordsByReview(product.getNo());
					Pagination pagination = new Pagination(pageNo, totalRecords);
					// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
					List<ReviewDto> reviewList = reviewDao.getReviewListByNo(pagination.getBegin(), pagination.getEnd(), product.getNo());
					%>
					<div class="container">
						<div class="row">
							<div class="col">
								<img src="../resources/images/<%=product.getName()%>.jpg"
									style="width: 500px; height: 500px">
							</div>
							<div class="col">
								<h3><%=product.getName()%></h3>
								<p>
									카테고리 : <%=product.getCategory()%></p>
								<p></p>
								<table class="table">

									<tbody>
										<tr class="d-flex">
											<th class="col-3">가격</th>
											<td class="col-4"><%=product.getPrice()%></td>
										</tr>
										<tr class="d-flex">
											<th class="col-3">재고</th>
											<td class="col-4"><%=product.getStock()%></td>
										</tr>
										<tr class="d-flex">
											<th class="col-3">판매수량</th>
											<td class="col-4"><%=product.getSalesRate()%>개</td>
										</tr>
									</tbody>
								</table>
								<p>
								<form method="get" action="buy.jsp">
									<label for="quantity">수량</label> <select
										class="form-select form-select-sm" id="quantity"
										name="quantity" size="1">
										<optgroup label="수량을 선택하세요">
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</optgroup>
									</select> <br> <input type="hidden" id="no" name="productNo"
										value="<%=product.getNo()%>">

									<%
									if (loginedUserInfo != null) {
									%>
									<input class="btn btn-outline-primary" type='submit' id="no"
										value='구매' onclick='return submit1(this.form);'> <input
										class="btn btn-outline-dark" type='submit' value='장바구니'
										onclick='return submit2(this.form);'>
								</form>
								<%
								}
								%>
							</div>
							<div align="right">
								<a href="../index.jsp" class="btn btn-primary pull-right">목록</a>
							</div>
						</div>
						<hr>
						<h4>리뷰</h4>
						<div class="row mb-3">
							<div class="col">
								<table class="table">
									<thead>
										<tr class="d-flex">
											<th class="col-1">번호</th>
											<th class="col-5">제목</th>
											<th class="col-2">작성자</th>
											<th class="col-2">조회수</th>
											<th class="col-2">등록일</th>
										</tr>
									</thead>
									<tbody>
										<%
										if (reviewList.isEmpty()) {
										%>
										<tr>
											<td class="text-center" colspan="6">게시글이 존재하지 않습니다.</td>
										</tr>
										<%
										} else {

										for (ReviewDto review : reviewList) {
										%>
										<tr class="d-flex">
											<td class="col-1"><%=review.getReviewNo()%></td>
											<td class="col-5"><a
												href="reviewDetail.jsp?reviewNo=<%=review.getReviewNo()%>&pageNo=<%=pageNo%>"><%=review.getTitle()%></a></td>
											<td class="col-2"><%=review.getUserName()%></td>
											<td class="col-2"><%=review.getViewCount()%></td>
											<td class="col-2"><%=review.getReviewCreatedDate()%></td>
										</tr>
										<%
										}
										}
										%>
									</tbody>
								</table>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-6 offset-3">
								<nav>
									<ul class="pagination justify-content-center">
										<!-- 
                  Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
                  Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
                -->
										<li
											class="page-item <%=!pagination.isExistPrev() ? "disabled" : ""%>"><a
											class="page-link"
											href="detail.jsp?no=<%=product.getNo()%>&pageNo=<%=pagination.getPrevPage()%>">
												이전 </a></li>
										<%
										// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
										for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
										%>
										<li
											class="page-item <%=pagination.getPageNo() == num ? "active" : ""%>"><a
											class="page-link"
											href="detail.jsp?no=<%=product.getNo()%>&pageNo=<%=num%>"><%=num%></a></li>
										<%
										}
										%>
										<!-- 
                  Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
                  Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
                -->
										<li
											class="page-item <%=!pagination.isExistNext() ? "disabled" : ""%>"><a
											class="page-link"
											href="detail.jsp?no=<%=product.getNo()%>&pageNo=<%=pagination.getNextPage()%>">
												다음 </a></li>
									</ul>
								</nav>
							</div>
<!-- 							<div class="col-3 text-end">
								<a href="reviewForm.jsp" class="btn btn-outline-primary">새 글</a>
							</div> -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">		
	</script>
	<script>
		function submit1(frm) {
			frm.action = '../order/form.jsp';
			frm.submit();
			return true;
		}
		function submit2(frm) {
			frm.action = '../cart/temp-addcart.jsp';

			frm.submit();
			return true;
		}
	</script>
</body>
</html>