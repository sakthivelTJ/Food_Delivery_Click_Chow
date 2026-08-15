<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, java.util.ArrayList, java.text.SimpleDateFormat, com.tap.model.user, com.tap.model.order_table, com.tap.model.order_item, com.tap.model.Restaurant, com.tap.model.Menu, com.tap.daoIMP.order_tableDAOIMP, com.tap.daoIMP.orderItemDAOIMP, com.tap.daoIMP.RestaurantDAOImp, com.tap.daoIMP.MenuDAOImp, com.tap.model.Carts"%>

<%
user user = (user) session.getAttribute("loggedInUser");
if (user == null) {
	response.sendRedirect("login.jsp");
	return;
}

@SuppressWarnings("unchecked")
List<order_table> userOrders = (List<order_table>) request.getAttribute("userOrders");
if (userOrders == null) {
	order_tableDAOIMP orderDAO = new order_tableDAOIMP();
	userOrders = orderDAO.getOrdersByUserId(user.getUser_id());
}

RestaurantDAOImp restDAO = new RestaurantDAOImp();
orderItemDAOIMP itemDAO = new orderItemDAOIMP();
MenuDAOImp menuDAO = new MenuDAOImp();
SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");

int totalOrdersCount = (userOrders != null) ? userOrders.size() : 0;
double grandSpent = 0;
int deliveredCount = 0;

if (userOrders != null) {
	for (order_table ord : userOrders) {
		grandSpent += ord.getTotalAmount();
		if ("Delivered".equalsIgnoreCase(ord.getStatus()) || "Confirmed".equalsIgnoreCase(ord.getStatus())) {
			deliveredCount++;
		}
	}
}

Carts cartObj = (Carts) session.getAttribute("cart");
int cartCount = 0;
if (cartObj != null && cartObj.getItems() != null) {
	cartCount = cartObj.getItems().size();
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Order History | Click Chow</title>
<!-- Web Favicon -->
<link rel="icon" href="assets/images/icon.png" />

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet" />
<!-- FontAwesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<!-- Stylesheet -->
<link rel="stylesheet" href="index.css" />

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
	min-height: 100vh;
	background-image: radial-gradient(circle at top left, rgba(255, 90, 54, 0.12), transparent 40%),
		radial-gradient(circle at bottom right, rgba(236, 72, 153, 0.12), transparent 40%);
}

.history-container {
	max-width: 1200px;
	margin: 20px auto 60px auto;
	padding: 0 20px;
}

/* Page Header & Stats */
.history-hero {
	background: linear-gradient(135deg, rgba(24, 29, 43, 0.9), rgba(18, 22, 32, 0.9));
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 24px;
	padding: 35px 30px;
	margin-bottom: 30px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 20px;
}

.history-hero-text h1 {
	font-size: 36px;
	font-weight: 800;
	margin-bottom: 8px;
}

.history-hero-text p {
	color: #9ea8bc;
	font-size: 16px;
}

.stats-grid {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
}

.stat-pill {
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.08);
	padding: 14px 22px;
	border-radius: 16px;
	display: flex;
	align-items: center;
	gap: 14px;
}

.stat-pill i {
	font-size: 24px;
	color: #ff5a36;
}

.stat-val {
	font-size: 20px;
	font-weight: 800;
	color: #ffffff;
}

.stat-lbl {
	font-size: 13px;
	color: #9ea8bc;
}

/* Order Filters */
.filter-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 15px;
	margin-bottom: 25px;
}

.filter-tabs {
	display: flex;
	gap: 10px;
}

.tab-btn {
	padding: 10px 20px;
	border-radius: 30px;
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.08);
	color: #b3b9c7;
	font-weight: 600;
	font-size: 14px;
	cursor: pointer;
	transition: 0.3s;
}

.tab-btn.active, .tab-btn:hover {
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff;
	border-color: transparent;
	box-shadow: 0 4px 15px rgba(255, 90, 54, 0.3);
}

.search-input-box {
	position: relative;
	width: 300px;
}

.search-input-box input {
	width: 100%;
	padding: 12px 18px 12px 42px;
	background: rgba(24, 29, 43, 0.9);
	border: 1px solid rgba(255, 255, 255, 0.1);
	border-radius: 30px;
	color: #fff;
	font-size: 14px;
	outline: none;
}

.search-input-box i {
	position: absolute;
	left: 16px;
	top: 50%;
	transform: translateY(-50%);
	color: #9ea8bc;
}

/* Order Card */
.order-card {
	background: #181d2b;
	border: 1px solid rgba(255, 255, 255, 0.08);
	border-radius: 24px;
	padding: 25px;
	margin-bottom: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s, border-color 0.3s;
}

.order-card:hover {
	border-color: rgba(255, 90, 54, 0.4);
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.45);
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-bottom: 18px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	flex-wrap: wrap;
	gap: 15px;
}

.rest-details {
	display: flex;
	align-items: center;
	gap: 16px;
}

.rest-avatar {
	width: 54px;
	height: 54px;
	border-radius: 16px;
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	color: #fff;
	box-shadow: 0 4px 12px rgba(255, 90, 54, 0.3);
	overflow: hidden;
}

.rest-avatar img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.rest-meta h3 {
	font-size: 20px;
	font-weight: 700;
	color: #fff;
	margin-bottom: 4px;
}

.order-id-date {
	font-size: 13px;
	color: #9ea8bc;
	display: flex;
	gap: 12px;
	align-items: center;
}

.order-status-badge {
	padding: 6px 16px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 700;
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.status-pending {
	background: rgba(245, 158, 11, 0.15);
	color: #f59e0b;
	border: 1px solid rgba(245, 158, 11, 0.3);
}

.status-delivered, .status-confirmed {
	background: rgba(16, 185, 129, 0.15);
	color: #10b981;
	border: 1px solid rgba(16, 185, 129, 0.3);
}

.status-cancelled {
	background: rgba(239, 68, 68, 0.15);
	color: #ef4444;
	border: 1px solid rgba(239, 68, 68, 0.3);
}

/* Order Items Table/List */
.order-items-list {
	padding: 20px 0;
	display: flex;
	flex-direction: column;
	gap: 14px;
}

.order-item-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	background: rgba(255, 255, 255, 0.02);
	padding: 12px 18px;
	border-radius: 14px;
	border: 1px solid rgba(255, 255, 255, 0.04);
}

.item-info {
	display: flex;
	align-items: center;
	gap: 14px;
}

.item-img {
	width: 44px;
	height: 44px;
	border-radius: 10px;
	object-fit: cover;
	background: #11141c;
}

.item-name {
	font-size: 15px;
	font-weight: 600;
	color: #f3f4f6;
}

.item-qty-price {
	font-size: 13px;
	color: #9ea8bc;
	margin-top: 2px;
}

.item-total-val {
	font-size: 16px;
	font-weight: 700;
	color: #ff5a36;
}

/* Order Footer */
.order-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-top: 18px;
	border-top: 1px solid rgba(255, 255, 255, 0.08);
	flex-wrap: wrap;
	gap: 15px;
}

.order-total-info {
	font-size: 14px;
	color: #9ea8bc;
}

.order-total-info strong {
	font-size: 20px;
	color: #ffffff;
	margin-left: 6px;
}

.order-actions {
	display: flex;
	gap: 12px;
}

.btn-reorder {
	padding: 10px 22px;
	border-radius: 30px;
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff;
	font-weight: 700;
	font-size: 14px;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	box-shadow: 0 4px 15px rgba(255, 90, 54, 0.3);
	transition: 0.3s;
}

.btn-reorder:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(255, 90, 54, 0.45);
}

.btn-invoice {
	padding: 10px 20px;
	border-radius: 30px;
	background: rgba(255, 255, 255, 0.05);
	border: 1px solid rgba(255, 255, 255, 0.12);
	color: #f3f4f6;
	font-weight: 600;
	font-size: 14px;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: 0.3s;
}

.btn-invoice:hover {
	background: rgba(255, 255, 255, 0.1);
	border-color: #ff5a36;
}

/* Empty State */
.empty-history-card {
	background: #181d2b;
	border: 1px dashed rgba(255, 255, 255, 0.15);
	border-radius: 24px;
	padding: 60px 30px;
	text-align: center;
}

.empty-icon {
	width: 90px;
	height: 90px;
	border-radius: 50%;
	background: rgba(255, 90, 54, 0.1);
	color: #ff5a36;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 40px;
	margin: 0 auto 20px auto;
}

.empty-history-card h2 {
	font-size: 26px;
	font-weight: 700;
	margin-bottom: 10px;
}

.empty-history-card p {
	color: #9ea8bc;
	font-size: 16px;
	margin-bottom: 25px;
}

/* Profile Dropdown Header Fix */
.profile {
	position: relative;
	display: inline-block;
}

.profile-btn {
	background: rgba(255, 255, 255, 0.08);
	border: 1px solid rgba(255, 255, 255, 0.12);
	color: #fff;
	padding: 8px 18px;
	border-radius: 30px;
	cursor: pointer;
	font-weight: 600;
	font-size: 14px;
	transition: 0.3s;
}

.profile-btn:hover {
	background: rgba(255, 90, 54, 0.2);
	border-color: #ff5a36;
}

.profile-card {
	display: none;
	position: absolute;
	right: 0;
	top: 45px;
	width: 260px;
	background: #181d2b;
	border: 1px solid rgba(255, 255, 255, 0.12);
	border-radius: 18px;
	padding: 18px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
	z-index: 1000;
}

.profile-card h3 {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 12px;
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	padding-bottom: 8px;
}

.profile-card .row {
	display: flex;
	justify-content: space-between;
	font-size: 13px;
	margin-bottom: 8px;
	color: #9ea8bc;
}

.profile-card .row span:last-child {
	color: #fff;
	font-weight: 600;
}

.profile-card a {
	display: block;
	padding: 8px 12px;
	margin-top: 6px;
	border-radius: 10px;
	color: #f3f4f6;
	text-decoration: none;
	font-size: 14px;
	font-weight: 600;
	transition: 0.2s;
}

.profile-card a:hover {
	background: rgba(255, 90, 54, 0.15);
	color: #ff5a36;
}
</style>

<script type="text/javascript">
	function toggleProfile() {
		var card = document.getElementById("profileCard");
		if (card.style.display == "block") {
			card.style.display = "none";
		} else {
			card.style.display = "block";
		}
	}

	window.onclick = function(event) {
		if (!event.target.matches('.profile-btn')) {
			var card = document.getElementById("profileCard");
			if (card && card.style.display == "block") {
				card.style.display = "none";
			}
		}
	}

	function filterOrders(status, btn) {
		var tabs = document.querySelectorAll('.tab-btn');
		tabs.forEach(function(t){ t.classList.remove('active'); });
		if(btn) btn.classList.add('active');

		var cards = document.querySelectorAll('.order-card');
		cards.forEach(function(card) {
			var cardStatus = card.getAttribute('data-status');
			if (status === 'all' || cardStatus.toLowerCase() === status.toLowerCase()) {
				card.style.display = 'block';
			} else {
				card.style.display = 'none';
			}
		});
	}

	function searchOrders() {
		var query = document.getElementById('searchOrderInput').value.toLowerCase();
		var cards = document.querySelectorAll('.order-card');
		cards.forEach(function(card) {
			var content = card.textContent.toLowerCase();
			if (content.includes(query)) {
				card.style.display = 'block';
			} else {
				card.style.display = 'none';
			}
		});
	}

	function printReceipt(orderId) {
		var orderElement = document.getElementById('order-' + orderId);
		if (!orderElement) return;
		var printWin = window.open('', '', 'width=800,height=600');
		printWin.document.write('<html><head><title>Receipt #ORD-' + orderId + '</title>');
		printWin.document.write('<style>body{font-family:sans-serif;padding:30px;color:#000;} h1{color:#ff5a36;} table{width:100%;border-collapse:collapse;margin:20px 0;} th,td{border:1px solid #ddd;padding:10px;text-align:left;}</style>');
		printWin.document.write('</head><body>');
		printWin.document.write('<h1>Click Chow - Order Receipt</h1>');
		printWin.document.write(orderElement.innerHTML);
		printWin.document.write('</body></html>');
		printWin.document.close();
		printWin.focus();
		setTimeout(function(){ printWin.print(); printWin.close(); }, 500);
	}
</script>
</head>
<body>

	<!-- Header Navigation -->
	<header class="header">
		<div class="header-container">
			<a href="restaurant" class="logo"> <span class="logo-icon"><i
					class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
			</a>

			<nav class="nav-links">
				<a href="restaurant">Home</a>
				<a href="restaurant#restaurants-section">Restaurants</a>
				<a href="orderHistory" class="active">Order History</a>
			</nav>

			<div class="header-actions">
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
				<button class="theme-toggle" id="theme-toggle-btn" aria-label="Toggle Theme">
					<i class="fa-solid fa-moon"></i>
				</button>
				<a href="cart.jsp" class="cart-toggle-btn" style="text-decoration: none; display: flex; align-items: center; justify-content: center;">
					<i class="fa-solid fa-bag-shopping"></i>
					<span class="cart-count" style="margin-left: 6px;"><%=cartCount%></span>
				</a>

				<div class="profile" style="margin-left: 15px;">
					<button class="profile-btn" onclick="toggleProfile()">
						👤 <%=user.getUser_name()%>
					</button>

					<div class="profile-card" id="profileCard">
						<h3>My Account</h3>
						<div class="row">
							<span>Username</span> <span><%=user.getUser_name()%></span>
						</div>
						<div class="row">
							<span>Email</span> <span><%=user.getEmail()%></span>
						</div>
						<div class="row">
							<span>Role</span> <span><%=user.getRole()%></span>
						</div>

						<a href="orderHistory"><i class="fa-solid fa-clock-rotate-left"></i> Order History</a>
						<a href="editProfile.jsp"><i class="fa-solid fa-pen"></i> Edit Profile</a>
						<a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
					</div>
				</div>
			</div>
		</div>
	</header>

	<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER -->
	<div class="top-back-bar">
		<a href="restaurant" class="btn-back-nav" id="backToRestaurantsBtn">
			<i class="fa-solid fa-arrow-left"></i> <span>Restaurants</span>
		</a>
	</div>

	<!-- MAIN CONTENT -->
	<div class="history-container">

		<!-- HERO BANNER -->
		<div class="history-hero">
			<div class="history-hero-text">
				<h1>
					<span class="gradient-text">Your Order History</span>
				</h1>
				<p>Track your past food orders, review item details, and reorder with a single tap.</p>
			</div>

			<div class="stats-grid">
				<div class="stat-pill">
					<i class="fa-solid fa-receipt"></i>
					<div>
						<div class="stat-val"><%=totalOrdersCount%></div>
						<div class="stat-lbl">Total Orders</div>
					</div>
				</div>
				<div class="stat-pill">
					<i class="fa-solid fa-wallet"></i>
					<div>
						<div class="stat-val">₹<%=String.format("%.2f", grandSpent)%></div>
						<div class="stat-lbl">Total Spent</div>
					</div>
				</div>
				<div class="stat-pill">
					<i class="fa-solid fa-circle-check"></i>
					<div>
						<div class="stat-val"><%=deliveredCount%></div>
						<div class="stat-lbl">Delivered</div>
					</div>
				</div>
			</div>
		</div>

		<!-- FILTER & SEARCH BAR -->
		<% if (userOrders != null && !userOrders.isEmpty()) { %>
		<div class="filter-bar">
			<div class="filter-tabs">
				<button class="tab-btn active" onclick="filterOrders('all', this)">All Orders</button>
				<button class="tab-btn" onclick="filterOrders('pending', this)">Pending</button>
				<button class="tab-btn" onclick="filterOrders('delivered', this)">Delivered</button>
			</div>

			<div class="search-input-box">
				<i class="fa-solid fa-magnifying-glass"></i>
				<input type="text" id="searchOrderInput" onkeyup="searchOrders()" placeholder="Search order ID, restaurant..." />
			</div>
		</div>
		<% } %>

		<!-- ORDERS LIST -->
		<%
		if (userOrders == null || userOrders.isEmpty()) {
		%>
		<div class="empty-history-card">
			<div class="empty-icon">
				<i class="fa-solid fa-utensils"></i>
			</div>
			<h2>No Orders Placed Yet</h2>
			<p>Looks like you haven't placed any food orders yet. Explore our top-rated restaurants and order your favorite feast now!</p>
			<a href="restaurant" class="btn-primary" style="display: inline-flex; font-size: 16px; padding: 14px 32px;">
				<i class="fa-solid fa-compass"></i> Explore Restaurants
			</a>
		</div>
		<%
		} else {
			for (order_table ord : userOrders) {
				Restaurant rest = restDAO.getRestaurant(ord.getRestaurantID());
				String restName = (rest != null && rest.getName() != null) ? rest.getName() : "Click Chow Restaurant";
				String restImg = (rest != null && rest.getImagePath() != null && !rest.getImagePath().isEmpty())
						? rest.getImagePath()
						: "assets/images/biryani.png";
				
				List<order_item> itemsList = itemDAO.getOrderItemsByOrderId(ord.getOrderID());
				String status = ord.getStatus() != null ? ord.getStatus() : "Pending";
				String statusClass = "status-pending";
				if ("Delivered".equalsIgnoreCase(status) || "Confirmed".equalsIgnoreCase(status)) {
					statusClass = "status-delivered";
				} else if ("Cancelled".equalsIgnoreCase(status)) {
					statusClass = "status-cancelled";
				}
				
				String formattedDate = (ord.getOrderDate() != null) ? sdf.format(ord.getOrderDate()) : "N/A";
		%>
		<div class="order-card" data-status="<%=status%>" id="order-<%=ord.getOrderID()%>">
			<div class="order-header">
				<div class="rest-details">
					<div class="rest-avatar">
						<img src="<%=restImg%>" alt="<%=restName%>" onerror="this.src='assets/images/biryani.png'" />
					</div>
					<div class="rest-meta">
						<h3><%=restName%></h3>
						<div class="order-id-date">
							<span><i class="fa-solid fa-hashtag" style="color:#ff5a36;"></i> ORD-<%=ord.getOrderID()%></span>
							<span>•</span>
							<span><i class="fa-regular fa-clock"></i> <%=formattedDate%></span>
						</div>
					</div>
				</div>

				<div style="display: flex; flex-direction: column; align-items: flex-end; gap: 6px;">
					<span class="order-status-badge <%=statusClass%>">
						<i class="fa-solid fa-circle-dot"></i> <%=status%>
					</span>
					<span style="font-size: 12px; color: #9ea8bc;">
						Payment: <strong style="color:#fff;"><%=ord.getPaymentMethod() != null ? ord.getPaymentMethod() : "COD"%></strong>
					</span>
				</div>
			</div>

			<!-- ITEMS LIST -->
			<div class="order-items-list">
				<%
				if (itemsList != null && !itemsList.isEmpty()) {
					for (order_item item : itemsList) {
						Menu mItem = menuDAO.getMenu(item.getMenuID());
						String dishName = (mItem != null && mItem.getItemName() != null) ? mItem.getItemName() : ("Dish #" + item.getMenuID());
						String dishImg = "assets/images/biryani.png";
						if (mItem != null && mItem.getImagePath() != null && !mItem.getImagePath().isEmpty()) {
							dishImg = mItem.getImagePath();
						}
						double unitPrice = item.getItemTotal() / (item.getQuantity() > 0 ? item.getQuantity() : 1);
				%>
				<div class="order-item-row">
					<div class="item-info">
						<img src="<%=dishImg%>" alt="<%=dishName%>" class="item-img" onerror="this.src='assets/images/biryani.png'" />
						<div>
							<div class="item-name"><%=dishName%></div>
							<div class="item-qty-price">₹<%=String.format("%.2f", unitPrice)%> × <%=item.getQuantity()%></div>
						</div>
					</div>
					<div class="item-total-val">₹<%=String.format("%.2f", item.getItemTotal())%></div>
				</div>
				<%
					}
				} else {
				%>
				<div style="color: #9ea8bc; font-size: 14px; font-style: italic;">No specific itemized details recorded for this order.</div>
				<% } %>
			</div>

			<!-- ORDER FOOTER -->
			<div class="order-footer">
				<div class="order-total-info">
					Total Paid: <strong>₹<%=String.format("%.2f", ord.getTotalAmount())%></strong>
				</div>

				<div class="order-actions">
					<button type="button" class="btn-invoice" onclick="printReceipt(<%=ord.getOrderID()%>)">
						<i class="fa-solid fa-print"></i> Receipt
					</button>
					<a href="menu?restaurantId=<%=ord.getRestaurantID()%>" class="btn-reorder">
						<i class="fa-solid fa-rotate-right"></i> Reorder
					</a>
				</div>
			</div>
		</div>
		<%
			}
		}
		%>

	</div>

	<script src="app.js"></script>
</body>
</html>
