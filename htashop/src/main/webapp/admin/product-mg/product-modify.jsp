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
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>상품관리::상품정보 수정</title>
<%@ include file="../../common/admin-navbar.jsp" %>	
</head>
<body>
<%
	pageContext.setAttribute("menu", "product-modify");
	pageContext.setAttribute("leftMenu", "product-modify");
%>
<div class="container">    
	<div class="row justify-content-center text-center mt-3 mb-3">
		<div class="col-sm-2">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
	
		<div class="col-10 justify-content-center text-center mt-3">
			<form class="form" action="">
<%
	ProductDao productDao = ProductDao.getInstance();
	List<Product> productList = productDao.getAllProducts();

	for (Product product : productList) {
%>
			<div class="alert alert-success" role="alert">
				<strong>변경할 내용을 입력하고 수정버튼을 누르세요.</strong>
			</div>
	
				<div class="row justify-content-evenly">
					<div class="card text-center col-5" style="height: 500px; border: none;">
 						<img src="../../resources/images/<%=product.getImage() %>" class="card-img-top">
  					</div>
				
				<div class="col-6">
  				<div class="row mt-5 mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">상품번호</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="no" id="productNo" placeholder="<%=product.getNo() %>">
    				</div>
    			</div>
    				
    			<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">카테고리</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="category" id="productCategory" placeholder="<%=product.getCategory() %>">
    				</div>
				</div>
				
				<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">상품명</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="name" id="productName" placeholder="<%=product.getName() %>">
    				</div>
    			</div>	

				<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">상품가격</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="price" id="productPrice" placeholder="<%=product.getPrice() %>">
    				</div>
				</div>
				
				<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">재고량</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="stock" id="productStock" placeholder="<%=product.getStock() %>">
    				</div>
				</div>
				
				<div class="row mb-3">
   					<label for="inputEmail3" class="col-sm-3 col-form-label">상품이미지</label>
    				<div class="col-sm-7">
      					<input type="text" class="form-control" name="image" id="productImage" placeholder="<%=product.getImage() %>">
    				</div>
    			</div>
    			</div>	
    			</div>
    				
 <%
 		break;
	}
 %> 			
 				<button type="submit" class="btn btn-primary">수정</button>
  			
  <!-- 
  			<div class="row mb-3">
    			<div class="col-sm-10 offset-sm-2">
      				<div class="form-check">
        				<input class="form-check-input" type="checkbox" id="gridCheck1">
        					<label class="form-check-label" for="gridCheck1">Example checkbox</label>
      				</div>
    			</div>
  			</div>
  
  <fieldset class="row mb-3">
    			<legend class="col-form-label col-sm-2 pt-0">Radios</legend>
    			<div class="col-sm-10">
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
        <label class="form-check-label" for="gridRadios1">
          First radio
        </label>
      </div>
      <div class="form-check">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
        <label class="form-check-label" for="gridRadios2">
          Second radio
        </label>
      </div>
      <div class="form-check disabled">
        <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios3" value="option3" disabled>
        <label class="form-check-label" for="gridRadios3">
          Third disabled radio
        </label>
      </div>
    </div>
  		</fieldset>
   -->
			</form>

		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>