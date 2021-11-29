
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<title>Insert title here</title>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>



<%

	int no = Integer.parseInt(request.getParameter("no"));

	
	// 게시글 정보를 제공하는 BoardDao객체를 획득한다.
	ProductDao productDao = ProductDao.getInstance();	
	
	// 게시글 번호에 해당하는 글 정보를 조회한다.
	Product product = productDao.getProductDetailById(no); 
	
	
%> 

	<div class="container">	
	<div class="row">
		<div class="col">

			  <img src="../resources/images/<%=product.getName() %>.jpg" style="width:500px; height:500px">
		</div>
		<div class="col">
				<h3>상품명</h3>
				<p>카테고리</p>
				<p>상세정보 들어감</p>
			<table class="table">
				<tbody>
					<tr class="d-flex">
						<th class="col-2">카테고리</th>
						<td class="col-4"><%=product.getCategory() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">상품명</th>
						<td class="col-4"><%=product.getName() %></td>
					</tr>					
					<tr class="d-flex">
						<th class="col-2">가격</th>
						<td class="col-4"><%=product.getPrice() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">재고</th>
						<td class="col-4"><%=product.getStock() %></td>
					</tr>
					<tr class="d-flex">
						<th class="col-2">판매수량</th>
						<td class="col-10"><%=product.getSalesRate() %></td>
					</tr>
				</tbody>				
			</table>
			<p>
			dasdsad
			</p>

<p>

	<form method="get" action="buy.jsp">
		<label for="color">색상</label> 
		<select class="form-select form-select-sm" id="color" name="color" size="1">
     <optgroup label="색상을 선택하세요">
        <option value="흰색">흰색</option>
        <option value="검은색">검은색</option>
     </optgroup>
		</select> <br>
		<label for="size">사이즈</label> 
		<select class="form-select form-select-sm" id="size" name="size" size="1">
     <optgroup label="사이즈를 선택하세요">
        <option value="100">100</option>
        <option value="95">95</option>	
     </optgroup>
     </select> <br>
		<label for="quantity">수량</label> 
		<select class="form-select form-select-sm" id="quantity" name="quantity" size="1">
     <optgroup label="수량을 선택하세요">
        <option value="1">1</option>
        <option value="2">2</option> 	
        <option value="3">3</option> 	
        <option value="4">4</option> 	
        <option value="5">5</option> 	
     </optgroup>     	
		</select>  <br>
	
	
	<button class="btn btn-outline-primary" name="no">구매하기</button>
<!-- 	<button class="btn btn-outline-dark">장바구니 담기</button> -->

	</form>

		</div>
	</div>
<hr>
<h4>리뷰</h4>

<%-- <%
	// 요청파라미터에서 pageNo값을 조회한다.
	// 요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
	String pageNo = request.getParameter("pageNo");

	// 게시글 정보 관련 기능을 제공하는 BoardDao객체를 획득한다.
	ReviewDao reviewDao = ReviewDao.getInstance();
	
	// 총 데이터 갯수를 조회한다.
	int totalRecords = reviewDao.getTotalRecords();
	
	// 페이징 처리 필요한 값을 계산하는 Paginatition객체를 생성한다.
	Pagination pagination = new Pagination(pageNo, totalRecords);
	
	// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
	List<Review> reviewList = reviewDao.getReviewList(pagination.getBegin(), pagination.getEnd());
%> --%>
		
<%-- 	<div class="row mb-3">
		<div class="col">
			<table class="table">
				<thead>
					<tr class="d-flex">
						<th class="col-1">번호</th>
						<th class="col-5">제목</th>
						<th class="col-3">작성자</th>
						<th class="col-1">조회수</th>
						<th class="col-2">등록일</th>
					</tr>
				</thead>
				<tbody>
<%
		for (Review review : reviewList) {
%>							
					<tr class="d-flex">
						<td class="col-1"><%=review.getReviewNo() %></td>
						<td class="col-5"><a href="detail.jsp?no=<%=review.getReviewNo()%>&pageNo=<%=pagination.getPageNo()%>"><%=review.getTitle() %></a></td>
						<td class="col-5">제목</td>
						<td class="col-3">작성자</td>
						<td class="col-1">조회수</td>
						<td class="col-2">등록일</td>
					</tr>
<%
		}
%>					
							
				</tbody>				
			</table>
				<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" > 이전 </a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" > 다음 </a></li>
				</ul>
			</nav>
		</div>
		<div class="col-3 text-end">
			<a href="reviewForm.jsp" class="btn btn-outline-primary">새 글</a>
		</div>
	</div>
			
		</div>
	</div>	 --%>						
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>