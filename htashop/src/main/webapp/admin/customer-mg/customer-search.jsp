<%@page import="org.apache.commons.lang3.time.DateUtils"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="utils.PaginationCustomerMG"%>
<%@page import="com.shop.dao.UserDao"%>
<%@page import="com.shop.vo.CriteriaCustomerMG"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.apache.commons.lang3.math.NumberUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<title>관리자:회원정보조회</title>
</head>
<body>
<%@ include file="../../common/admin-navbar.jsp" %>

<%
	pageContext.setAttribute("menu", "customer-search");
	pageContext.setAttribute("leftMenu", "customer-search");
	
	int pageNo = NumberUtils.toInt(request.getParameter("page"), 1);
	String privateInfo = StringUtils.defaultString(request.getParameter("privateInfo"), "");
	String privateInfoKeyword = StringUtils.defaultString(request.getParameter("privateInfoKeyword"), "");
	String grade = StringUtils.defaultString(request.getParameter("grade"), "");
	String minDate = StringUtils.defaultString(request.getParameter("minDate"), "");
	String maxDate = StringUtils.defaultString(request.getParameter("maxDate"), "");
	String gender = StringUtils.defaultString(request.getParameter("gender"), "");
	
	CriteriaCustomerMG criteriaCustomerMG = new CriteriaCustomerMG();
	
	if (!StringUtils.isEmpty(privateInfo) && !StringUtils.isEmpty(privateInfoKeyword)) {
		criteriaCustomerMG.setPrivateInfo(privateInfo);
		criteriaCustomerMG.setPrivateInfoKeyword(privateInfoKeyword);
	}
	if (!StringUtils.isEmpty(grade)) {
		criteriaCustomerMG.setGrade(grade);
	}
	if (!StringUtils.isEmpty(minDate)) {
		criteriaCustomerMG.setMinDate(minDate);		
	}
	if (!StringUtils.isEmpty(maxDate)) {
		criteriaCustomerMG.setMaxDate(maxDate);
	}
	if(!StringUtils.isEmpty(gender)) {
		criteriaCustomerMG.setGender(gender);		
	}

	UserDao userDao = new UserDao();
	int totalRows = userDao.getTotalRows(criteriaCustomerMG);
	PaginationCustomerMG paginationCustomerMG = new PaginationCustomerMG(pageNo, totalRows);
	
	criteriaCustomerMG.setBeginIndex(paginationCustomerMG.getBeginIndex());
	criteriaCustomerMG.setEndIndex(paginationCustomerMG.getEndIndex());
	
	List<User> userList = userDao.getSearchedUserList(criteriaCustomerMG);
%>
<div class="container-fluid">
	<div class="row">
		<div class="col-2 min-vh-100 bg-light">
			<%@ include file="../../common/admin-left.jsp" %>
		</div>
		<div class="col-10">
			<div class="row mb-2">
				<div class="col m-1">
					<form class="" method="post" id="form-search" action="customer-search.jsp">
						<input type="hidden" id="page-field" name="page" value="<%=pageNo %>">
						<table class="table table-bordered caption-top">
							<caption class="fs-4 fw-bold">회원정보조회</caption>
							<tbody>
								<tr>
									<th class="col-2 table-light"><label>개인정보</label></th>
									<td class="col-2" colspan="4">
										<select name="privateInfo">
											<option value="name" <%="name".equals(privateInfo) ? "selected" : "" %>>이름
											<option value="id" <%="id".equals(privateInfo) ? "selected" : "" %>>아이디
											<option value="address" <%="address".equals(privateInfo) ? "selected" : "" %>>주소
											<option value="phone-number" <%="phone-number".equals(privateInfo) ? "selected" : "" %>>휴대폰번호
										</select>
										<input type="text" name="privateInfoKeyword" value="<%=StringUtils.isBlank(privateInfoKeyword) ? "" : privateInfoKeyword %>">
									</td>
								</tr>
								<tr>
									<th class="col-2 table-light"><label>회원등급</label></th>
									<td class="col-2" colspan="4">
										<select name="grade">
											<option value="all" <%="all".equals(grade) ? "selected" : "" %>>전체
											<option value="다이아" <%="다이아".equals(grade) ? "selected" : ""  %>>다이아
											<option value="골드" <%="골드".equals(grade) ? "selected" : ""  %>>골드
											<option value="실버" <%="실버".equals(grade) ? "selected" : ""  %>>실버
											<option value="브론즈" <%="브론즈".equals(grade) ? "selected" : ""  %>>브론즈
										</select>
									</td>
								</tr>
								<tr>
									<th class="col-2 table-light"><label>가입일</label></th>
									<td class="col-2" colspan="4"><input type="date" name="minDate" value="<%=minDate %>"> ~ <input type="date" name="maxDate" value="<%=maxDate%>"></td>
								</tr>
								<tr>
									<th class="col-2 table-light"><label>성별</label></th>
									<td class="col-4">
										<input type="radio" name="gender" value="all" <%="all".equals(gender) || gender.isEmpty() ? "checked" : "" %>>전체&nbsp;&nbsp;
										<input type="radio" name="gender" value="male" <%="male".equals(gender) ? "checked" : "" %> >남&nbsp;&nbsp;
										<input type="radio" name="gender" value="female" <%="female".equals(gender) ? "checked" : "" %>>여&nbsp;&nbsp;
									</td>
								</tr>
							</tbody>
						</table>
						<div class="col">
							<button class="btn btn-primary" type="button" onclick="searchCustomers(1)">검색</button>
						</div>
					</form>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col m-1">
					<table class="table caption-top">
						<caption class="fs-4 fw-bold">회원목록</caption>
						<thead>
							<tr>
								<th class="col-2">가입일</th>
								<th class="col-2">이름</th>
								<th class="col-2">아이디</th>
								<th class="col-2">등급</th>
								<th class="co1-2">휴대전화</th>
								<th class="col-1">성별</th>
								<th class="col-1">지역</t1h>
							</tr>
						</thead>
						<tbody>
<%
	if (userList.isEmpty()) {
%>
							<tr>
								<td class="col-2 text-center" colspan="10">검색된 회원 내역이 없습니다.</td>
							</tr>
<%
	} else {
		for (User user : userList) {
%>
							<tr>
								<td class="col-2"><%=user.getCreatedDate() %></td>
								<td class="col-2"><%=user.getName() %></td>
								<td class="col-2"><%=user.getId() %></td>
								<td class="col-2"><%=user.getGrade() %></td>
								<td class="col-2"><%=user.getTel() %></td>
								<td class="col-1"><%=user.getGender() %></td>
								<td class="col-1"><%=user.getAddress() %></td>
							</tr>
<%
		}
	}
%>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 페이지네이션 추가 중 -->
			<div class="row mb-3">
				<div class="col">
					<ul class="pagination justify-content-center">
						<li class="page-item <%=paginationCustomerMG.isExistPrev() ? "" : "disabled" %>">
							<a href="" class="page-link" onclick="moveToPage(event, <%=paginationCustomerMG.getPrev()%>)">이전</a>
						</li>
<%
	for (int num = paginationCustomerMG.getBegin(); num <= paginationCustomerMG.getEnd(); num++) {
%>
						<li class="page-item <%=num == paginationCustomerMG.getPage() ? "active" : ""%>">
							<a href="" class="page-link" onclick="moveToPage(event, <%=num %>)"><%=num %></a>
						</li>
<%
	}
%>
						<li class="page-item <%=paginationCustomerMG.isExistNext() ? "" : "disabled"%>">
							<a href="" class="page-link" onclick="moveToPage(event, <%=paginationCustomerMG.getNext()%>)">다음</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
		function moveToPage(event, page) {
			event.preventDefault();
			searchCustomers(page);	
		}
		
		function searchCustomers(page) {
			document.getElementById("page-field").value = page;
			var form = document.getElementById("form-search");
			form.submit();
		}
	</script>
</body>
</html>