<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>Checkout</title>
	<link rel="canonical" href="https://getbootstrap.kr/docs/5.1/examples/checkout/">
     <!-- Bootstrap core CSS -->
	<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body class="bg-light">

	<div class="container">
		<div class="row">

			<div class="col-1"></div>

			<div class="col-11">

				<div class="py-5 text-center">
					<h2>Checkout form</h2>
				</div>

				<div class="row g-5">
					<div class="col-md-5 col-lg-4 order-md-last">
						<h4 class="d-flex justify-content-between align-items-center mb-3">
							<span class="text-primary">Your cart</span> <span class="badge bg-primary rounded-pill"></span>
						</h4>
						<ul class="list-group mb-3">
							<li class="list-group-item d-flex justify-content-between lh-sm">
								<div>
									<h6 class="my-0"></h6>
									<small class="text-muted"></small>
								</div> <span class="text-muted"></span> <a href="deleteCart.jsp?productNo=<"><button type="button" class="btn btn-primary btn-sm">삭제</button></a>
							</li>

							<li class="list-group-item d-flex justify-content-between"><span>Total (\)</span> <strong>\20</strong></li>
						</ul>
					</div>

					<div class="col-md-7 col-lg-8">
						<h4 class="mb-3">Billing address</h4>
						<form class="needs-validation" novalidate>
							<div class="row g-3">
								<div class="col-sm-10">
									<label for="firstName" class="form-label">이름</label> <input type="text" class="form-control" id="firstName" placeholder="" value="" required>
									<div class="invalid-feedback">Valid first name is required.</div>
								</div>

								<div class="col-12">
									<label for="email" class="form-label">Email <span class="text-muted">(Optional)</span></label> <input type="email" class="form-control" id="email" placeholder="you@example.com">
									<div class="invalid-feedback">Please enter a valid email address for shipping updates.</div>
								</div>

								<div class="col-12">
									<label for="address" class="form-label">주소</label> <input type="text" class="form-control" id="address" required>
									<div class="invalid-feedback">Please enter your shipping address.</div>
								</div>

								<div class="col-md-4">
									<label for="country" class="form-label">전화번호</label>
									<select class="form-select" id="phoneNumber" required>
										<option value="010">Choose...</option>
										<option>010</option>
									</select>
								</div>

								<div class="col-md-4">
									<label for="state" class="form-label"></label>
									<select class="form-select" id="state" required>
										<option value=""></option>
										<option>California</option>
									</select>
									<div class="invalid-feedback">Please provide a valid state.</div>
								</div>

								<div class="col-md-3">
									<label for="zip" class="form-label"></label> <input type="text" class="form-control" id="zip" placeholder="" required>
									<div class="invalid-feedback">Zip code required.</div>
								</div>
							</div>

							<hr class="my-4">

							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="same-address"> <label class="form-check-label" for="same-address">Shipping address is the same as my billing address</label>
							</div>

							<div class="form-check">
								<input type="checkbox" class="form-check-input" id="save-info"> <label class="form-check-label" for="save-info">Save this information for next time</label>
							</div>

							<hr class="my-4">

							<h4 class="mb-3">Payment</h4>

							<div class="my-3">
								<div class="form-check">
									<input id="credit" name="paymentMethod" type="radio" class="form-check-input" checked required> <label class="form-check-label" for="credit">Credit card</label>
								</div>
								<div class="form-check">
									<input id="debit" name="paymentMethod" type="radio" class="form-check-input" required> <label class="form-check-label" for="debit">Debit card</label>
								</div>
								<div class="form-check">
									<input id="paypal" name="paymentMethod" type="radio" class="form-check-input" required> <label class="form-check-label" for="paypal">PayPal</label>
								</div>
							</div>

							<div class="row gy-3">
								<div class="col-md-6">
									<label for="cc-name" class="form-label">Name on card</label> <input type="text" class="form-control" id="cc-name" placeholder="" required> <small class="text-muted">Full name as displayed on card</small>
									<div class="invalid-feedback">Name on card is required</div>
								</div>

								<div class="col-md-6">
									<label for="cc-number" class="form-label">Credit card number</label> <input type="text" class="form-control" id="cc-number" placeholder="" required>
									<div class="invalid-feedback">Credit card number is required</div>
								</div>

								<div class="col-md-3">
									<label for="cc-expiration" class="form-label">Expiration</label> <input type="text" class="form-control" id="cc-expiration" placeholder="" required>
									<div class="invalid-feedback">Expiration date required</div>
								</div>

								<div class="col-md-3">
									<label for="cc-cvv" class="form-label">CVV</label> <input type="text" class="form-control" id="cc-cvv" placeholder="" required>
									<div class="invalid-feedback">Security code required</div>
								</div>
							</div>

							<hr class="my-4">

							<button class="w-100 btn btn-primary btn-lg" type="submit">Continue to checkout</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	 <script src="form-validation.js"></script>
</body>
</html>