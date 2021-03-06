<%@page import="com.shop.vo.User"%>
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
<title>제품상세정보 페이지</title>
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
//	User loginedUserInfo = (User)session.getAttribute("logined_user_info");
%>
<%@include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<div class="col-sm-2">
				<%@ include file="../common/left.jsp" %>
			</div>
				<div class="col-sm-10 align-self-end mt-4">
					<div class="row mb-3">
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String pageNo = request.getParameter("pageNo");
	String cart = request.getParameter("cart");
	String error = request.getParameter("error");
	
	ProductDao productDao = ProductDao.getInstance();
	ReviewDto reviewDto = new ReviewDto();
	Product product = productDao.getProductDetailById(productNo);
	int reviewNo = reviewDto.getReviewNo();
	ReviewDao reviewDao = new ReviewDao();
	int totalRecords = reviewDao.getTotalRecordsByReview(product.getNo());
	Pagination pagination = new Pagination(pageNo, totalRecords);
	List<ReviewDto> reviewList = reviewDao.getReviewListByNo(pagination.getBegin(), pagination.getEnd(), product.getNo());
%>
			<div class="container">
				<div class="row">
<%
	if ("complete".equals(cart)) {
%>
					<div class="alert alert-success d-flex align-items-center" role="alert">장바구니에 추가를 완료하였습니다.</div>
<%
	}
%>
					<div class="col">
						<img src="../resources/images/<%=product.getImage()%>" style="width: 500px; height: 500px">
					</div>

					<div class="col">
						<h3><%=product.getName()%></h3>
						<p>카테고리 : <%=product.getCategory()%></p>
						<table class="table">
							<tbody>
								<tr class="d-flex">
									<th class="col-3">가격</th>
									<td class="col-4"><%=product.getPrice()%>원</td>
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
						<form method="get" action="orderForm.jsp">
							<input type="hidden" name="pageNo" value="<%=pageNo %>">
							<label for="quantity">수량</label> 
							<select class="form-select form-select-sm" id="quantity" name="quantity" size="1">
								<optgroup label="수량을 선택하세요">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</optgroup>
							</select>
							<br>
							<input type="hidden" id="no" name="productNo" value="<%=product.getNo()%>">
<%
                            if (loginedUserInfo != null) {	// 로그인한 상태 중에서
                                if (product.isSoldOut() == false) {		// 판매중인 상품일때
%>
                                    <input class="btn btn-outline-primary" type='submit' id="no"
                                        value='구매' onclick='return submit1(this.form);'> <input
                                        class="btn btn-outline-dark" type='submit' value='장바구니'
                                        onclick='return submit2(this.form);'>
<%
                                } else {	// 판매종료 상품일때
%>
                                    <div class="alert alert-danger" role="alert">
                                        <strong> 품절된 상품입니다.</strong>
                                    </div>
<%
                                }
                            } else {	// 로그인하지 않은 경우
%>
                                <div class="alert alert-primary" role="alert">
                                    <strong> 로그인 후 구매할 수 있습니다.</strong>
                                </div>
<%
                            }
%>

<%
	if ("empty-quantity".equals(error)) {
%>
	
<% 
	}
%>
						</form>
					</div>
					<div align="right">
						<a href="../index.jsp" class="btn btn-primary pull-right">목록</a>
					</div>
				</div>
				<hr>
				<div class="row mt-2">
					<div class="row mb-3" id="container_title">
						<div class="col">
							<h1 class="fs-6"><strong>리뷰</strong> | 회원님들의 리뷰입니다.</h1>
						</div>
					</div>
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
											<td class="col-5">
												<a 
													href="reviewDetail.jsp?productNo=<%=review.getProductNo() %>&reviewNo=<%=review.getReviewNo()%>&pageNo=<%=pageNo%>">
													<%=review.getTitle()%><%=review.getAnswerContent() != null ? "(1)" : "" %>
												</a>
											</td>
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
										<li	class="page-item <%=!pagination.isExistPrev() ? "disabled" : ""%>">
											<a class="page-link"	href="detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=pagination.getPrevPage()%>">이전</a>
										</li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
										<li	class="page-item <%=pagination.getPageNo() == num ? "active" : ""%>">
											<a	class="page-link" href="detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=num%>"><%=num%></a>
										</li>
<%
    }
%>
										<!-- 
							                 Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
							                 Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
						                -->
										<li	class="page-item <%=!pagination.isExistNext() ? "disabled" : ""%>">
											<a class="page-link"	href="detail.jsp?productNo=<%=product.getNo()%>&pageNo=<%=pagination.getNextPage()%>">다음</a>
										</li>
									</ul>
								</nav>
							</div>
							<div class="col-3 text-end">
								<a href="reviewForm.jsp?productNo=<%=productNo%>&pageNo=<%=pageNo %>" class="btn btn-outline-primary">새 글</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>	
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js">		
</script>
<script>
	function submit1(frm) {
		frm.action = '../cart/addCart1.jsp';
		frm.submit();
		return true;
	}
	function submit2(frm) {
		frm.action = '../cart/addCart.jsp';
		frm.submit();
		return true;
	}
</script>
</body>
</html>