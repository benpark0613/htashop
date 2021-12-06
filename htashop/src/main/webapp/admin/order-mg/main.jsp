<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title></title>
<%@ include file="../../common/admin-navbar.jsp" %>		
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-1">
<%@ include file="../../common/admin-left.jsp" %>		
		</div>
			
		
		<div class="col-11">
				<div class="container">
					<p>실시간 매출현황</p>
					<div class="p-4 p-lg-2 bg-light rounded-3 text-center border">
						<div class="row">
							총 적립금 : []원
						</div>
						<div class="row">
							사용된 적립금 : []원
						</div>
						<div class="row">
							사용가능 적립금 : []원
						</div>
					</div>
				</div>

				<div class="container">

					<hr class="featurette-divider">

					<table class="table">
						<thead>
							<tr>
								<th scope="col">구분</th>
								<th scope="col">오늘</th>
								<th scope="col">이번 달</th>
								<th scope="col">바로가기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">총 주문금액 (건수)</th>
								<td>[]원 ([]건)</td>
								<td>[]원 ([]건)</td>
								<td>주문조회 버튼</td>
							</tr>
							<tr>
								<th scope="row">총 실 결제금액 (건수)</th>
								<td>[]원 ([]건)</td>
								<td>[]원 ([]건)</td>
								<td>주문조회 버튼</td>
							</tr>
							<tr>
								<th scope="row">총 환불 금액(건수)</th>
								<td>[]원 ([]건)</td>
								<td>[]원 ([]건)</td>
								<td>주문조회 버튼</td>
							</tr>
						</tbody>
					</table>
					
					<hr class="featurette-divider">
					<div class="row">
						<div class="col">
						<h3>오늘의 할 일</h3>
					<table class="table">
						<tbody>
							<tr>
								<th scope="row">입금전</th>
								<td>[]건</td>
							</tr>
							<tr>
								<th scope="row">배송준비중/배송보류중</th>
								<td>[]건 / []건</td>
							</tr>
							<tr>
								<th scope="row">배송중</th>
								<td>[]건</td>
							</tr>
						</tbody>
					</table>
					</div>
					<div class="col">
						<h3>오늘처리한 일</h3>
					
					<table class="table">
						<tbody>
							<tr>
								<th scope="row">수동입금확인 / 자동입금확인</th>
								<td>[]건</td>
							</tr>
							<tr>
								<th scope="row">배송중처리</th>
								<td>[]건</td>
							</tr>
							<tr>
								<th scope="row">배송완료</th>
								<td>[]건</td>
							</tr>
						</tbody>
					</table>
					</div>
					
					
					</div>
					
					</div>
				</div>

			</div>
	</div>
	
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>