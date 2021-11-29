<%@page import="com.shop.vo.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.shop.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../navigation/nav.jsp" %>    
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    
    
    <title></title>
    
    
</head>

<body>
<div class="container mb-3">
	<h2>MY SHOP</h2>
  <div class="row mb-3">
    <div class="col bg-light">
		
        <p>저희 쇼핑몰을 이용해 주셔서 감사합니다. <strong><%=customer.getName() %>님</strong>은 [<strong><%=customer.getGrade() %></strong>] 회원이십니다.</p>
    </div>
    </div>


    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">총 적립금 :[<%=customer.getPoint() %>]원 </h2>
		<button type="button" class="btn btn-secondary">조회</button>
        <h2 class="featurette-heading">사용적립금 :[]원 </h2>
        <h2 class="featurette-heading">총주문 :[]원 </h2>
      </div>

    </div>
    
    <hr class="featurette-divider">

<%
/*
	OrderDao orderDao = new OrderDao();
	Order order = orderDao.getOrdersByNo(customer.getNo());

	if("입금전".equals(order.getState())){
		int cnt1 = 0;
		cnt1 ++;
	}
	if("배송준비중".equals(order.getState())){
		int cnt2 = 0;
		cnt2 ++;
	}
	if("배송중".equals(order.getState())){
		int cnt3 = 0;
		cnt3 ++;
	}
	if("배송완료".equals(order.getState())){
		int cnt4 = 0;
		cnt4 ++;
	}
	if("취소".equals(order.getState())){
		int cnt5 = 0;
		cnt5 ++;
	}
	if("교환".equals(order.getState())){
		int cnt6 = 0;
		cnt6 ++;
	}
	if("반품".equals(order.getState())){
		int cnt7 = 0;
		cnt7 ++;
	}
*/
	OrderDao orderDao = new OrderDao();
	int beforeDeposit = orderDao.countbeforeDeposit(customer.getNo());
	int cancel = orderDao.countCancel(customer.getNo());
	int exchange = orderDao.countExchange(customer.getNo());
	int preparingDelevery = orderDao.countPreparingDelevery(customer.getNo());
	int rtn = orderDao.countRtn(customer.getNo());
	int shippedComplete = orderDao.countShippedComplete(customer.getNo());
	int shipping = orderDao.countShipping(customer.getNo());
%>   
    
    <div class="row featurette">
      <div class="col-md-7">
        <h2 class="featurette-heading">나의 주문처리 현황 (최근 3개월 기준) </h2>
        <h2 class="featurette-heading">입금전 : <%=beforeDeposit %> </h2>
        <h2 class="featurette-heading">배송준비중 : <%=preparingDelevery %>  </h2>
        <h2 class="featurette-heading">배송중 : <%=shipping %> </h2>
        <h2 class="featurette-heading">배송완료 : <%=shippedComplete %> </h2>
        <h5 class="featurette-heading">취소 : <%=cancel %> </h5>
        <h5 class="featurette-heading">교환 : <%=exchange %> </h5>
        <h5 class="featurette-heading">반품 : <%=rtn %> </h5>
      </div>
    </div>
    
    <hr class="featurette-divider">

    
</div>
            <div class="container px-lg-5">
                <!-- Page Features-->
                <div class="row gx-lg-5">
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-collection"></i></div>
                                <a href="orderList.jsp"><h2 class="fs-4 fw-bold">주문내역조회</h2></a>
                                <p class="mb-0">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-cloud-download"></i></div>
                                <a href="customerInfo.jsp"><h2 class="fs-4 fw-bold">회원정보</h2></a>
                                <p class="mb-0">회원이신 고객님의 개인정보를 관리하는 공간입니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-card-heading"></i></div>
                                <a href="point.jsp"><h2 class="fs-4 fw-bold">적립금</h2></a>
                                <p class="mb-0">적립금은 상품 구매시 사용하실 수 있습니다.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-xxl-4 mb-5">
                        <div class="card bg-light border-0 h-100">
                            <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                                <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-bootstrap"></i></div>
                                <a href="boardManagement.jsp"><h2 class="fs-4 fw-bold">게시물 관리</h2></a>
                                <p class="mb-0">고객님께서 작성하신 게시물을 관리하는 공간입니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>