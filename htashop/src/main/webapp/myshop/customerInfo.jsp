<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<%@ include file="../navigation/nav.jsp" %>    

<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<%
	String failReason = request.getParameter("fail");
%>
<body>
<div class="container">    
<%
	if("password".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">
   		비밀번호를 입력 하세요!
 	</div>
<%
	}
%>
<%
	if("name".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">
   		이름을 입력 하세요!
 	</div>
<%
	}
%>
<%
	if("email".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">
   		이메일을 입력 하세요!
 	</div>
<%
	}
%>
<%
	if("tel".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">
   		전화번호를 입력 하세요!
 	</div>
<%
	}
%>
<%
	if("region".equals(failReason)){
%>
	<div class="alert alert-danger d-flex align-items-center" role="alert">
   		주소를 입력 하세요!
 	</div>
<%
	}
%>
    <div class="row g-5">
      
      <div class="col-md-7 col-lg-8">
        <h4 class="mb-3">회원정보 수정</h4>
        
        <hr class="featurette-divider">
        
        <form class="needs-validation" method="post" action="updateCustomer.jsp">
          <div class="row g-3">
            <div class="col-sm-6">
              <label for="id" class="form-label">아이디</label>
              <input type="text" class="form-control" id="id" name="id" placeholder="<%=customer.getId() %>" disabled>
            </div>


            <div class="col-12">
              <label for="password" class="form-label">비밀번호</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" id="password" name="password" placeholder="비밀번호">
              </div>
            </div>
            
            
            <div class="col-12">
              <label for="" class="form-label">비밀번호 확인</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" id="" name="id" placeholder="비밀번호">
              </div>
            </div>
            
            
            <div class="col-12">
              <label for="name" class="form-label">이름</label>
              <div class="input-group has-validation">
                <input type="text" class="form-control" id="name" name="name" placeholder="<%=customer.getName() %>">
              </div>
            </div>
            
            <div class="col-12">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" placeholder="<%=customer.getEmail() %>">
            </div>

            <div>전화번호</div>
            <div class="col-4 ">
              <input type="text" class="form-control" id="tel1" name="tel1" placeholder="010">
            </div>
            
            <div class="col-4">
              <input type="text" class="form-control" id="tel2" name="tel2" >
            </div>
            <div class="col-4">
              <input type="text" class="form-control" id="tel3" name="tel3" >
            </div>
            
            
            <div>생년월일</div>
            <div class="col-4 ">
              <input type="text" class="form-control" id="year" name="year" placeholder="년">
            </div>
            
            <div class="col-4">
              <input type="text" class="form-control" id="month" name="month" placeholder="월">
            </div>
            <div class="col-4">
              <input type="text" class="form-control" id="day" name="day" placeholder="일">
            </div>
            



            <div class="col-md-6">
              <label for="region" class="form-label">지역</label>
              <select class="form-select" id="region" name="region" >
                <option value="">Choose</option>
                <option>서울</option>
                <option>경기도</option>
                <option>경상북도</option>
                <option>경상남도</option>
                <option>충청북도</option>
                <option>충청남도</option>
                <option>전라북도</option>
                <option>전라남도</option>
                <option>강원도</option>
                <option>제주도</option>
              </select>
            </div>



          <hr class="my-4">

          <button class="w-30 btn btn-primary btn-lg" type="submit">회원정보 수정</button>
          </div>
        </form>
      </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>