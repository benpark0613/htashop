<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
	<h1>검색</h1>
		<div class="row mb-3">
			<div class="col" id="product-search">
				<form class="d-flex justify-content-center offset-1" id="form-search" name="search" method="get" action="search-products.jsp">
					<!-- 페이지 정보 -->
					<div>
						<input type="hidden" id="page-field" name="page" value="1">
					</div>
					<!-- 옵션 정보 -->
					<div class="col-2">
						<select class="form-select" name="searchRequirement">
							<option value="name">이름</option>
							<option value="price">가격</option>
							<option value="category">카테고리</option>
						</select>
					</div>
					<!-- 검색 키워드 -->
					<div class="col-3">
						<input class="form-control" type="text" name="searchField" />
					</div>
					<div class="col-2">
						<button class="btn btn-primary" type="submit" onclick="searchBoards(1)">검색</button>
					</div>
				</form>
			</div>
		</div>
    	
    	
    	
    	
    	
    	
    	
	<!-- 검색기능은 search-result.jsp에서 구현 -->
	
	<!-- ** 검색결과 출력할 테이블(결과가 있을떄만) -->
	
	
	
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function moveToPage(event, page) {
		event.preventDefault();
		searchBords(page);
	}

	function searchBoards(page) {
		document.getElementById("page-field").value = page;
		var form = document.getElementById("form-search");
		form.submit();
	}
</script>
</body>
</html>