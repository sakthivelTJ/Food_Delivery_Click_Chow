<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed | Click Chow</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="index.css">


<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Outfit', sans-serif;
}

body {
	background: #090b12;
	color: #fff;
	overflow: hidden;
	overflow-x :auto;
}

/* Background Glow */
body::before {
	content: "";
	position: absolute;
	width: 450px;
	height: 450px;
	background: #ff5a36;
	filter: blur(180px);
	opacity: .18;
	top: -120px;
	left: -120px;
}

body::after {
	content: "";
	position: absolute;
	width: 450px;
	height: 450px;
	background: #ec4899;
	filter: blur(180px);
	opacity: .18;
	bottom: -150px;
	right: -150px;
}

/* Header */
.header {
	width: 100%;
	padding: 20px 6%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: rgba(24, 29, 43, .95);
	backdrop-filter: blur(15px);
	border-bottom: 1px solid rgba(255, 255, 255, .08);
}

.logo {
	text-decoration: none;
	color: #fff;
	font-size: 28px;
	font-weight: 800;
}

.logo span {
	color: #ff5a36;
}

.secure {
	color: #fff;
	font-weight: 600;
}

.secure i {
	color: #ff5a36;
}

/* Main */
.container {
	height: calc(100vh - 82px);
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.card {
	margin-top:400px;
	width: 700px;
	max-width: 95%;
	background: #181d2b;
	border-radius: 30px;
	border: 1px solid rgba(255, 255, 255, .08);
	box-shadow: 0 25px 60px rgba(0, 0, 0, .45);
	text-align: center;
	padding: 60px 50px;
	position: relative;
	z-index: 2;
}

/* Success Icon */
.success-icon {
	width: 120px;
	height: 120px;
	margin: auto;
	border-radius: 50%;
	background: linear-gradient(135deg, #22c55e, #16a34a);
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 0 35px rgba(34, 197, 94, .45);
	animation: pop .7s ease;
}

.success-icon i {
	font-size: 58px;
	color: #fff;
}

@
keyframes pop { 0%{
	transform: scale(.3);
	opacity: 0;
}

70
%
{
transform
:
scale(
1.15
);
}
100
%
{
transform
:
scale(
1
);
opacity
:
1;
}
}
h1 {
	margin-top: 30px;
	font-size: 42px;
	font-weight: 800;
}

.gradient {
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.message {
	margin-top: 18px;
	color: #b9c1d2;
	font-size: 18px;
	line-height: 1.8;
}

/* Order Info */
.info {
	margin: 40px 0;
	display: flex;
	justify-content: center;
	gap: 25px;
	flex-wrap: wrap;
}

.box {
	width: 210px;
	background: #232938;
	border-radius: 18px;
	padding: 22px;
	border: 1px solid rgba(255, 255, 255, .08);
}

.box i {
	color: #ff5a36;
	font-size: 28px;
	margin-bottom: 12px;
}

.box h3 {
	margin-bottom: 8px;
	font-size: 18px;
}

.box p {
	color: #b3b9c7;
}

/* Buttons */
.buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
	flex-wrap: wrap;
}

.btn {
	text-decoration: none;
	padding: 16px 38px;
	border-radius: 50px;
	font-size: 17px;
	font-weight: 700;
	transition: .35s;
}

.primary {
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff;
	box-shadow: 0 12px 25px rgba(255, 90, 54, .35);
}

.primary:hover {
	transform: translateY(-4px);
}

.secondary {
	border: 2px solid #ff5a36;
	color: #ff5a36;
}

.secondary:hover {
	background: #ff5a36;
	color: #fff;
}

/* Footer */
.footer {
	margin-top: 40px;
	color: #7f8798;
	font-size: 15px;
}

/* Responsive */
@media ( max-width :768px) {
	.card {
		padding: 40px 25px;
	}
	h1 {
		font-size: 34px;
	}
	.message {
		font-size: 16px;
	}
}
</style>

</head>

<body>

	<header class="header">

		<a href="restaurant" class="logo"> Click<span>Chow</span>
		</a>

		<div style="display: flex; align-items: center; gap: 15px;">
			<div class="secure">
				<i class="fa-solid fa-shield-halved"></i> Order Secured
			</div>
			<!-- Top Right Food Search Bar -->
			<div class="header-search-wrapper" id="header-search-wrapper">
				<button type="button" class="header-search-trigger" id="header-search-trigger" title="Search Food">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
				<div class="header-search-box" id="header-search-box">
					<i class="fa-solid fa-magnifying-glass search-inner-icon"></i>
					<input type="text" id="top-food-search" class="top-food-search-input" placeholder="Search food (e.g. biryani, pizza...)" autocomplete="off" />
					<button type="button" class="header-search-close" id="header-search-close">
						<i class="fa-solid fa-xmark"></i>
					</button>
				</div>
				<div class="top-search-dropdown" id="top-search-dropdown"></div>
			</div>
			<button class="theme-toggle" id="theme-toggle-btn" aria-label="Toggle Theme" style="background:transparent; border:none; color:inherit; font-size:1.2rem; cursor:pointer;">
				<i class="fa-solid fa-moon"></i>
			</button>
		</div>

	</header>


	<div class="container">


		<div class="card">

			<div class="success-icon">
				<i class="fa-solid fa-check"></i>
			</div>

			<h1>
				Order <span class="gradient">Confirmed!</span>
			</h1>

			<p class="message">
				Thank you for choosing <b>Click Chow</b>.<br> Your delicious
				food is being prepared and will reach you soon.
			</p>

			<div class="info">

				<div class="box">
					<i class="fa-solid fa-clock"></i>
					<h3>Estimated Delivery</h3>
					<p>25 - 30 Minutes</p>
				</div>
				<%
					
				
				%>

				<div class="box">
					<i class="fa-solid fa-receipt"></i>
					<h3>Order ID</h3>
					<p>#CC102458</p>
				</div>

			</div>

			<div class="buttons">

				<a href="orderHistory" class="btn primary"> <i
					class="fa-solid fa-clock-rotate-left"></i> View Order History
				</a> <a href="accessed" class="btn secondary"> <i
					class="fa-solid fa-house"></i> Back to Home
				</a>

			</div>


			<div class="footer">We appreciate your order ❤️ Enjoy your
				meal!</div>

		</div>

	</div>
<script src="app.js"></script>
</body>
</html>