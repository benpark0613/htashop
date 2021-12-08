<%@page import="com.shop.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>상품관리::상품정보 수정</title>
<%@ include file="../../common/admin-navbar.jsp"%>
</head>
<body>
<%
	pageContext.setAttribute("menu", "product-modifyform");
	pageContext.setAttribute("leftMenu", "product-modifyform");
%>
	<div class="container">
		<div class="row justify-content-center text-center mt-3 mb-3">
			<div class="col-sm-2">
				<%@ include file="../../common/admin-left.jsp"%>
			</div>

			<div class="col-10 justify-content-center text-center mt-3">
				<form class="form" method="post" action="product-modify.jsp">

					<div class="alert alert-success" role="alert">
						<strong> 변경할 내용을 입력하고 수정버튼을 누르세요.<br> 상품명은 최대 6글자까지
							입력할 수 있습니다.
						</strong>
					</div>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductDetailById(productNo);
%>
					<div class="row justify-content-evenly">
						<div class="card text-center col-5 mt-3"
							style="height: 500px; border: none;">
							<img src="../../resources/images/<%=product.getImage()%>"
								class="card-img-top">
						</div>

						<div class="col-6 mt-3">
							<div class="row mt-5 mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">상품번호</label>
								<div class="col-sm-7">
									<input readonly type="number" class="form-control"
										name="productNo" id="productNo" value="<%=product.getNo()%>">
								</div>
							</div>

							<div class="row mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">카테고리</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" name="productCategory"
										id="productCategory" value="<%=product.getCategory()%>">
								</div>
							</div>

							<div class="row mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">상품명</label>
								<div class="col-sm-7">
									<input type="text" maxlength="6" class="form-control"
										name="productName" id="productName"
										value="<%=product.getName()%>">
								</div>
							</div>

							<div class="row mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">상품가격</label>
								<div class="col-sm-7">
									<input type="number" class="form-control" name="productPrice"
										id="productPrice" value="<%=product.getPrice()%>">
								</div>
							</div>

							<div class="row mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">재고량</label>
								<div class="col-sm-7">
									<input type="number" class="form-control" name="productStock"
										id="productStock" value="<%=product.getStock()%>">
								</div>
							</div>

							<div class="row mb-3">
								<label for="productInfo" class="col-sm-4 col-form-label">판매상태</label>
								<div class="col sm-7 mt-2">
									<div class="form-check form-check-inline">
<%
	String soldOut = Boolean.toString(product.isSoldOut());

	if (soldOut == "true") {
%>	
  										<input class="form-check-input" type="radio" name="productIsSoldout" id="productIsSoldout" value="false">
  										<label class="form-check-label" for="productIsSoldout">판매중</label>
 										
									<div class="form-check form-check-inline">
 										 <input class="form-check-input mx-2" type="radio" name="productIsSoldout" id="productIsSoldout" value="true" checked>
  										 <label class="form-check-label" for="productIsSoldout">판매종료</label>
									</div>
<%
	} else {
%>									
										<input class="form-check-input" type="radio" name="productIsSoldout" id="productIsSoldout" value="false" checked>
  										<label class="form-check-label" for="productIsSoldout">판매중</label>
 										
									<div class="form-check form-check-inline">
 										 <input class="form-check-input mx-2" type="radio" name="productIsSoldout" id="productIsSoldout" value="true">
  										 <label class="form-check-label" for="productIsSoldout">판매종료</label>
									</div>
<%
	}
%>	
									</div>
								</div>
							</div>
							
							<button type="submit" class="btn btn-warning mt-4"><strong>수정</strong></button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

			<%-- 
				<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-4 col-form-label">상품이미지</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="productImage" id="productImage" placeholder="<%=product.getImage() %>">
    				</div>
    			</div> 
    		--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>