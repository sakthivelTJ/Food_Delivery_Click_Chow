<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.util.List, com.tap.model.Restaurant, com.tap.model.Carts, com.tap.model.CartItems"%>
	<%@ page import="com.tap.model.user"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Click Chow | Fast Food Delivery</title>
<!-- Web Favicon -->
<link rel="icon" href="assets/images/icon.png">
<text y="%22.9em%22" font-size="%2280%22"></text>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;0,800;1,600&display=swap"
	rel="stylesheet" />
<!-- FontAwesome for Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<!-- Stylesheet -->
<link rel="stylesheet" href="index.css" />

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

			if (card.style.display == "block") {

				card.style.display = "none";

			}

		}

	}
</script>

<style>
/* Background Loop Video Styling */
/*=================================================
            FEATURED RESTAURANTS SECTION
==================================================*/
.restaurants-grid {
	width: 100%;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(310px, 1fr));
	gap: 30px;
	margin-top: 60px;
	padding: 10px 0;
}

/*================ CARD =================*/
.restaurant-card {
	background: #181d2b;
	border: 1px solid rgba(255, 255, 255, .08);
	border-radius: 24px;
	overflow: hidden;
	position: relative;
	transition: .35s ease;
	box-shadow: 0 15px 40px rgba(0, 0, 0, .35), inset 0 0 0
		rgba(255, 255, 255, 0);
}

.restaurant-card:hover {
	transform: translateY(-12px);
	border-color: #ff5a36;
	box-shadow: 0 20px 45px rgba(0, 0, 0, .45), 0 0 30px
		rgba(255, 90, 54, .18);
}

/*================ IMAGE =================*/
.restaurant-img-wrapper {
	position: relative;
	width: 100%;
	height: 210px;
	overflow: hidden;
}

.restaurant-img-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: .5s;
}

.restaurant-card:hover .restaurant-img-wrapper img {
	transform: scale(1.08);
}

/*================ TOP BADGE =================*/
.restaurant-tag {
	position: absolute;
	top: 16px;
	left: 16px;
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff;
	font-size: 13px;
	font-weight: 700;
	padding: 7px 14px;
	border-radius: 30px;
	box-shadow: 0 8px 18px rgba(236, 72, 153, .35);
}

/*================ CONTENT =================*/
.restaurant-info {
	padding: 22px;
}

.restaurant-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12px;
}

.restaurant-header h3 {
	color: #fff;
	font-size: 29px;
	font-weight: 700;
	letter-spacing: -.3px;
}

.restaurant-rating {
	color: #f7b731;
	font-weight: 700;
	font-size: 16px;
}

.restaurant-rating i {
	margin-right: 4px;
}

/*================ CUISINE =================*/
.restaurant-cuisine {
	color: #b3b9c7;
	font-size: 17px;
	margin-bottom: 12px;
	line-height: 1.6;
}

/*================ META =================*/
.restaurant-meta {
	display: flex;
	gap: 24px;
	align-items: center;
	padding-top: 18px;
	margin-top: 18px;
	border-top: 1px solid rgba(255, 255, 255, .08);
}

.restaurant-meta span {
	color: #9ea8bc;
	font-size: 15px;
	display: flex;
	align-items: center;
	gap: 7px;
}

.restaurant-meta i {
	color: #ff5a36;
}

/*================ BUTTON =================*/
.restaurant-actions {
	margin-top: 22px !important;
}

.restaurant-actions a {
	display: flex !important;
	justify-content: center;
	align-items: center;
	width: 100%;
	height: 58px;
	border-radius: 50px;
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff !important;
	font-size: 18px;
	font-weight: 700;
	text-decoration: none;
	transition: .35s;
	box-shadow: 0 10px 25px rgba(255, 90, 54, .30);
}

.restaurant-actions a:hover {
	transform: translateY(-3px);
	box-shadow: 0 15px 30px rgba(255, 90, 54, .45);
	background: linear-gradient(135deg, #ff6838, #ff3d87);
}

/*================ RESPONSIVE =================*/
@media ( max-width :1200px) {
	.restaurants-grid {
		grid-template-columns: repeat(3, 1fr);
	}
}

@media ( max-width :992px) {
	.restaurants-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

@media ( max-width :650px) {
	.restaurants-grid {
		grid-template-columns: 1fr;
	}
	.restaurant-header h3 {
		font-size: 25px;
	}
}

.profile {
	position: relative;
	display: inline-block;
}

.profile-btn {
	padding: 12px 22px;
	border: none;
	border-radius: 50px;
	background: linear-gradient(135deg, #ff5a36, #ec4899);
	color: #fff;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	box-shadow: 0 8px 20px rgba(255, 90, 54, .3);
}

.profile-card {
	position: absolute;
	right: 0;
	top: 65px;
	width: 320px;
	background: rgba(26, 31, 44, .96);
	backdrop-filter: blur(18px);
	border: 1px solid rgba(255, 255, 255, .08);
	border-radius: 20px;
	padding: 20px;
	display: none;
	box-shadow: 0 15px 40px rgba(0, 0, 0, .45);
	z-index: 1000;
}

.profile-card h3 {
	color: #fff;
	margin-bottom: 18px;
	text-align: center;
}

.row {
	display: flex;
	justify-content: space-between;
	margin: 14px 0;
	color: #b9c0ca;
	font-size: 15px;
	border-bottom: 1px solid rgba(255, 255, 255, .08);
	padding-bottom: 10px;
}

.row span:last-child {
	color: #fff;
	font-weight: 600;
}

.profile-card a {
	display: block;
	text-decoration: none;
	margin-top: 15px;
	padding: 12px;
	border-radius: 12px;
	background: #232938;
	color: #fff;
	transition: .3s;
}

.profile-card a:hover {
	background: linear-gradient(135deg, #ff5a36, #ec4899);
}
/* Background Loop Video Styling */
.hero {
	position: relative;
	overflow: hidden;
	background: #090b12;
}

.hero-bg-video {
	position: absolute;
	top: 50%;
	left: 50%;
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height: auto;
	transform: translate(-50%, -50%);
	object-fit: cover;
	z-index: 1;
	pointer-events: none;
	opacity: 100;
}

.hero-container {
	position: relative;
	z-index: 2;
}

/* Fallback background overlay */
.hero::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(9, 11, 18, 0.45);
	z-index: 1;
	pointer-events: none;
}
</style>
</head>
<body>

	<!-- Header Navigation -->
	<header class="header">
		<div class="header-container">
			<a href="logoLogout" onclick="localStorage.clear(); sessionStorage.clear();" class="logo"> <span class="logo-icon"><i
					class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
			</a>

			<nav class="nav-links">
				<a href="#hero" class="active">Home</a> <a
					href="#restaurants-section">Restaurants</a> <a href="orderHistory">Order History</a> <a href="#about">About</a>
				<a href="#contact">Contact</a>
			</nav>


			<div class="header-actions">
				<button class="theme-toggle" id="theme-toggle-btn"
					aria-label="Toggle Theme">
					<i class="fa-solid fa-moon"></i>
				</button>
				<div class="cart-btn-wrapper">
					<a href="cart.jsp" class="cart-toggle-btn" id="cart-toggle-btn"
						style="text-decoration: none; display: flex; align-items: center; justify-content: center;">
						<i class="fa-solid fa-bag-shopping"></i> <span class="cart-count"
						id="cart-count"></span>
					</a>
				</div>
				 <a href="LogoutServlet"
					class="btn-secondary login-btn" style="padding: 10px 20px;">Logout</a>
				

				<%
				user user = (user) session.getAttribute("loggedInUser");

				if (user == null) {
					response.sendRedirect("login.jsp");
					return;
				}
				%>

				<div class="profile">

					<button class="profile-btn" onclick="toggleProfile()">👤
						 <%=user.getUser_name() %></button>

					<div class="profile-card" id="profileCard">

						<h3>My Profile</h3>

						<div class="row">
							<span>Username</span> <span><%=user.getUser_name()%></span>
						</div>

						<div class="row">
							<span>Email</span> <span><%=user.getEmail() %></span>
						</div>
						<div class="row">
							<span>Address</span> <span><%=user.getAddress() %></span>
						</div>

						<div class="row">
							<span>Role</span> <span><%=user.getRole() %></span>
						</div>

						<a href="editProfile.jsp">✏ Edit Profile</a> <a href="LogoutServlet">🚪
							Logout</a>

					</div>

				</div>





				<button class="mobile-menu-btn" id="mobile-menu-btn">
					<i class="fa-solid fa-bars"></i>
				</button>
			</div>
		</div>
	</header>

	

	<!-- Hero Section -->
	<section class="hero" id="hero">
		<!-- Background Loop Video -->
		<video autoplay loop muted playsinline class="hero-bg-video">
			<source src="assets/bg_video.mp4" type="video/mp4">
			Your browser does not support the video tag.
		</video>

		<div class="hero-container">
			<div class="hero-content">
				<div class="promo-badge">
					<span class="badge-text"><i class="fa-solid fa-fire"></i>
						50% Off Your First Order</span>
				</div>
				<h1 class="hero-title">
					Delicious Food,<br /> Tapped to Your <span class="gradient-text">Doorstep</span>.
				</h1>
				<p class="hero-subtitle">Savor the best local flavors with just
					one tap. Fast delivery, fresh ingredients, and premium chefs
					prepared just for you.</p>

				<!-- Search Box -->
				<div class="search-box">
					<i class="fa-solid fa-magnifying-glass search-icon"></i> <input
						type="text" id="food-search"
						placeholder="Search pizza, burgers, sushi, cake..." />
					<button class="search-btn">Search</button>
				</div>

				<!-- Hero CTA Actions -->
				<div class="hero-cta-actions"
					style="display: flex; gap: 15px; margin-top: -20px; margin-bottom: 45px;">
					<a href="login.jsp" class="btn-primary"><i
						class="fa-solid fa-right-to-bracket"></i> Login to Order</a> <a
						href="#restaurants-section" class="btn-secondary"><i
						class="fa-solid fa-utensils"></i> Browse Restaurants</a>
				</div>

				<!-- Stats Flexbox -->
				<div class="hero-stats">
					<div class="stat-item">
						<h3>50k+</h3>
						<p>Orders Delivered</p>
					</div>
					<div class="stat-divider"></div>
					<div class="stat-item">
						<h3>
							4.9 <i class="fa-solid fa-star star-icon"></i>
						</h3>
						<p>User Ratings</p>
					</div>
					<div class="stat-divider"></div>
					<div class="stat-item">
						<h3>15-30m</h3>
						<p>Average Delivery</p>
					</div>
				</div>
			</div>

			<!-- Hero Image Showcase -->
			<div class="hero-image-wrapper">
				<div class="hero-blob"></div>
				<div class="hero-image-card card-floating-1">
					<img src="assets/images/burger.png" alt="Delicious Burger"
						id="hero-slider-img" />
					<div class="floating-badge badge-top-right">
						<span class="badge-rating" id="hero-badge-rating"><i
							class="fa-solid fa-star"></i> 4.9</span>
						<h4 id="hero-badge-title">Gourmet Burger</h4>
						<p id="hero-badge-price">₹199</p>
					</div>
				</div>
				<!-- Small floaters -->
				<div class="floater floater-1 animate-float">
					<i class="fa-solid fa-pizza-slice"></i>
				</div>
				<div class="floater floater-2 animate-float-delayed">
					<i class="fa-solid fa-bowl-food"></i>
				</div>
				<div class="floater floater-3 animate-float">
					<i class="fa-solid fa-ice-cream"></i>
				</div>
			</div>
		</div>
	</section>

	<!-- Info / Flexbox Features Section -->
	<section class="features-section">
		<div class="container">
			<div class="section-header">
				<h2>
					Why Choose <span class="gradient-text">Click Chow</span>?
				</h2>
				<p>We provide the quickest, most aesthetic, and easiest food
					ordering experience in town.</p>
			</div>
			<div class="features-grid">
				<div class="feature-card">
					<div class="feature-icon bg-orange">
						<i class="fa-solid fa-bolt"></i>
					</div>
					<h3>Super Fast Delivery</h3>
					<p>Get food delivered hot and fresh in less than 30 minutes at
						your doorstep.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon bg-pink">
						<i class="fa-solid fa-utensils"></i>
					</div>
					<h3>Premium Quality</h3>
					<p>We curate only the highest-rated restaurants and
						professional chefs near you.</p>
				</div>
				<div class="feature-card">
					<div class="feature-icon bg-yellow">
						<i class="fa-solid fa-location-dot"></i>
					</div>
					<h3>Live GPS Tracking</h3>
					<p>Track your food in real-time from the restaurant kitchen
						straight to your home.</p>
				</div>
			</div>
		</div>
	</section>

	<!-- Featured Restaurants Section -->
	<section class="restaurants-section" id="restaurants-section">
		<div class="container">
			<div class="section-header">
				<h2>
					Featured <span class="gradient-text">Restaurants</span>
				</h2>
				<p>Order from the most popular and highly-rated local eateries
					in your area.</p>
			</div>

			<div class="restaurants-grid">
				<%
				@SuppressWarnings("unchecked")
				List<Restaurant> allRestaurant = (List<Restaurant>) request.getAttribute("allRestaurant");
				if (allRestaurant == null || allRestaurant.isEmpty()) {
					com.tap.daoIMP.RestaurantDAOImp rDao = new com.tap.daoIMP.RestaurantDAOImp();
					try { allRestaurant = rDao.getAllRestaurant(); } catch (Exception e) {}
				}
				if (allRestaurant == null || allRestaurant.isEmpty()) {
					allRestaurant = new java.util.ArrayList<Restaurant>();
					allRestaurant.add(new Restaurant(1, "Annalakshmi Restaurant", "South Indian, Veg", "20-30 mins", "Cathedral Road, Chennai", 4.8, true, "images/restaurants/annalakshmi.png"));
					allRestaurant.add(new Restaurant(2, "Avartana - ITC Grand Chola", "Luxury South Indian", "30-40 mins", "Guindy, Chennai", 4.9, true, "images/restaurants/avartana.jpg"));
					allRestaurant.add(new Restaurant(3, "Paati Veedu", "Traditional Tamil", "25-35 mins", "T. Nagar, Chennai", 4.7, true, "images/restaurants/paati_veedu.png"));
					allRestaurant.add(new Restaurant(4, "Southern Spice", "South & Chettinad", "25-35 mins", "Nungambakkam, Chennai", 4.8, true, "images/restaurants/southern_spice.jpg"));
					allRestaurant.add(new Restaurant(5, "Pakwan Chennai", "North Indian, Mughlai", "30-40 mins", "T. Nagar, Chennai", 4.6, true, "images/restaurants/pakwan_chennai.jpg"));
				}
				for (Restaurant restaurant : allRestaurant) {
				%>
				<div class="restaurant-card">
					<div class="restaurant-img-wrapper">
						<img src="<%=restaurant.getImagePath()%>"
							alt="<%=restaurant.getName()%>" /> <span class="restaurant-tag">Top
							Rated</span>
					</div>
					<div class="restaurant-info">
						<div class="restaurant-header">
							<h3><%=restaurant.getName()%></h3>
							<span class="restaurant-rating"><i
								class="fa-solid fa-star"></i> <%=restaurant.getRating()%></span>
						</div>
						<p class="restaurant-cuisine"><%=restaurant.getCustomerType()%></p>
						<p class="restaurant-cuisine"><%=restaurant.getAddress()%></p>
						<div class="restaurant-meta">
							<span><i class="fa-solid fa-bicycle"></i> Free Delivery</span> <span><i
								class="fa-solid fa-clock"></i> <%=restaurant.getDeliveryTime()%></span>
						</div>
						<div class="restaurant-actions"
							style="margin-top: 15px; display: flex; justify-content: flex-end;">
							<a href="menu?restaurantId=<%=restaurant.getRestaurant_id()%>"
								style="display: inline-block; width: 100%; text-align: center; text-decoration: none; padding: 14px 20px; border-radius: 50px; background: linear-gradient(135deg, #ff5a36, #ec4899); color: #fff; font-size: 16px; font-weight: 700; font-family: Outfit, sans-serif; box-shadow: 0 8px 20px rgba(255, 90, 54, .30); transition: all .3s ease;">
								View Menu </a>
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</section>

	<!-- App Promo / Banner Section -->
	<section class="promo-banner-section" id="about">
		<div class="container">
			<div class="promo-banner">
				<div class="promo-text">
					<h2>Click & Eat with the Click Chow App</h2>
					<p>Get exclusive app-only deals, scratch cards, and faster
						checkouts. Download now on iOS and Android.</p>
					<div class="app-buttons">
						<a href="#" class="app-btn"><i class="fa-brands fa-apple"></i>
							App Store</a> <a href="#" class="app-btn"><i
							class="fa-brands fa-google-play"></i> Google Play</a>
					</div>
				</div>
				<div class="promo-visual">
					<div class="phone-mockup">
						<div class="phone-screen">
							<div class="phone-header">
								<span class="phone-logo">Click Chow</span> <i
									class="fa-solid fa-wifi"></i>
							</div>
							<div class="phone-content">
								<div class="phone-card">
									<img src="assets/images/pizza.png" alt="Promo Pizza" />
									<div class="phone-card-info">
										<h5>Double Pepperoni</h5>
										<p>⭐⭐⭐⭐⭐ (4.9)</p>
										<span>₹349</span>
									</div>
								</div>
								<div class="phone-notification">
									<i class="fa-solid fa-truck-ramp-box"></i>
									<div>
										<h6>Rider is near!</h6>
										<p>Arriving in 2 mins</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer Section -->
	<footer class="footer" id="contact">
		<div class="footer-container">
			<div class="footer-brand">
				<a href="#" class="logo"> <span class="logo-icon"><i
						class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
				</a>
				<p class="footer-desc">Your favorite meals, delivered fresh and
					fast, right to your doorstep. Experience the power of single-click
					food ordering.</p>
				<div class="social-icons">
					<a href="#" aria-label="Facebook"><i
						class="fa-brands fa-facebook-f"></i></a> <a href="#"
						aria-label="Twitter"><i class="fa-brands fa-twitter"></i></a> <a
						href="#" aria-label="Instagram"><i
						class="fa-brands fa-instagram"></i></a> <a href="#"
						aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
				</div>
			</div>

			<div class="footer-links-grid">
				<div class="footer-col">
					<h4>Quick Links</h4>
					<ul>
						<li><a href="#hero">Home</a></li>
						<li><a href="#restaurants-section">Restaurants</a></li>
						<li><a href="#about">About Us</a></li>
						<li><a href="#contact">Contact</a></li>
					</ul>
				</div>
				<div class="footer-col">
					<h4>Popular Categories</h4>
					<ul>
						<li><a href="#restaurants-section">Burgers</a></li>
						<li><a href="#restaurants-section">Pizzas</a></li>
						<li><a href="#restaurants-section">Indian Dishes</a></li>
						<li><a href="#restaurants-section">Sushi Platters</a></li>
						<li><a href="#restaurants-section">Desserts</a></li>
					</ul>
				</div>
				<div class="footer-col">
					<h4>Contact Us</h4>
					<ul class="contact-info">
						<li><i class="fa-solid fa-phone"></i> +1 (555) 123-4567</li>
						<li><i class="fa-solid fa-envelope"></i>
							contact@clickchow.com</li>
						<li><i class="fa-solid fa-location-dot"></i> 456 Delicious
							Lane, Foodie City, FC 90210</li>
					</ul>
				</div>
			</div>

			<div class="footer-newsletter">
				<h4>Subscribe to our Newsletter</h4>
				<p>Stay updated with our latest delicious deals and weekly
					weekly promo codes.</p>
				<form class="newsletter-form"
					onsubmit="event.preventDefault(); alert('Subscribed! Thank you for joining Click Chow.');">
					<input type="email" placeholder="Your Email Address" required />
					<button type="submit">
						<i class="fa-solid fa-paper-plane"></i>
					</button>
				</form>
			</div>
		</div>

		<div class="footer-bottom">
			<div class="footer-bottom-content">
				<p>&copy; 2026 Click Chow. All rights reserved. Designed for
					ultimate appetite.</p>
				<div class="footer-bottom-links">
					<a href="#">Privacy Policy</a> <a href="#">Terms of Service</a>
				</div>
			</div>
		</div>
	</footer>

	<!-- JavaScript -->
	<script src="app.js"></script>

	<%
	Carts initialCartObj = (Carts) session.getAttribute("cart");
	double initTotal = 0;
	int initCount = 0;
	StringBuilder initJson = new StringBuilder("[");
	if (initialCartObj != null && initialCartObj.getItems() != null) {
		boolean f = true;
		for (CartItems ci : initialCartObj.getItems().values()) {
			if (!f) initJson.append(",");
			f = false;
			String ciName = (ci.getName() != null && !ci.getName().trim().isEmpty()) ? ci.getName() : "Food Item #" + ci.getMenuId();
			double ciPrice = ci.getPrice() > 0 ? ci.getPrice() : 199.0;
			int ciQty = ci.getQuantity() > 0 ? ci.getQuantity() : 1;
			double sub = ciPrice * ciQty;
			initTotal += sub;
			initCount += ciQty;
			String nameEsc = com.tap.CartServlet.escapeJson(ciName);
			String imgEsc = ci.getImagePath() != null ? com.tap.CartServlet.escapeJson(ci.getImagePath()) : "";
			initJson.append("{")
					.append("\"menuId\":").append(ci.getMenuId()).append(",")
					.append("\"restaurantId\":").append(ci.getRestaurantId()).append(",")
					.append("\"name\":\"").append(nameEsc).append("\",")
					.append("\"price\":").append(ciPrice).append(",")
					.append("\"quantity\":").append(ciQty).append(",")
					.append("\"subtotal\":").append(sub).append(",")
					.append("\"imagePath\":\"").append(imgEsc).append("\"")
					.append("}");
		}
	}
	initJson.append("]");
	double initDelivery = 40.0;
	double initGst = 35.0;
	double initGrand = initTotal > 0 ? (initTotal + initDelivery + initGst) : 0;
	%>

	<!-- Floating Cart Action Launcher (Bottom-Right) -->
	<div class="floating-cart-trigger" id="floatingCartTrigger" onclick="toggleSideCart()">
		<i class="fa-solid fa-bag-shopping"></i> <span>Cart</span>
		<span class="floating-cart-badge" id="floatingCartBadge"><%= initCount %></span>
	</div>

	<!-- Floating Side Cart Drawer -->
	<div class="cart-drawer" id="sideCartDrawer">
		<div class="cart-drawer-overlay" onclick="closeSideCart()"></div>
		<div class="cart-drawer-content">
			<div class="cart-drawer-header">
				<h3>
					Your Cart <span class="cart-count-title" id="sideCartTitleCount">(<%= initCount %>)</span>
				</h3>
				<button type="button" class="close-cart-btn" onclick="closeSideCart()">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</div>

			<div class="cart-items-container" id="sideCartItemsContainer">
				<!-- Rendered dynamically by JS -->
			</div>

			<div class="cart-drawer-footer" id="sideCartFooter">
				<div class="cart-summary-row">
					<span>Subtotal</span> <span id="sideCartSubtotal">₹<%= String.format("%.2f", initTotal) %></span>
				</div>
				<div class="cart-summary-row">
					<span>Delivery Fee</span> <span>₹40.00</span>
				</div>
				<div class="cart-summary-row">
					<span>Tax (GST)</span> <span>₹35.00</span>
				</div>
				<div class="cart-summary-divider"></div>
				<div class="cart-summary-row total-row">
					<span>Total</span> <span id="sideCartGrandTotal">₹<%= String.format("%.2f", initGrand) %></span>
				</div>
				<div style="display: flex; flex-direction: column; gap: 10px; margin-top: 14px;">
					<a href="checkOut.jsp" class="btn-side-cart-checkout"> Proceed to Checkout <i class="fa-solid fa-arrow-right"></i></a>
					<div style="display: flex; gap: 10px;">
						<a href="cart.jsp" style="flex: 1; text-align: center; display: flex; align-items: center; justify-content: center; gap: 6px; padding: 12px; border-radius: 50px; text-decoration: none; font-size: 14px; font-weight: 700; color: #fff; background: rgba(255, 255, 255, 0.08); border: 1px solid rgba(255, 255, 255, 0.12); transition: 0.2s;" onmouseover="this.style.background='rgba(255,255,255,0.15)';" onmouseout="this.style.background='rgba(255,255,255,0.08)';">
							<i class="fa-solid fa-cart-shopping"></i> View Cart Page
						</a>
						<button type="button" onclick="clearCart()" style="padding: 12px 18px; border-radius: 50px; border: 1px solid rgba(239, 68, 68, 0.3); background: rgba(239, 68, 68, 0.12); color: #ef4444; font-size: 14px; font-weight: 700; cursor: pointer; transition: 0.2s;" onmouseover="this.style.background='#ef4444'; this.style.color='#fff';" onmouseout="this.style.background='rgba(239,68,68,0.12)'; this.style.color='#ef4444';">
							<i class="fa-solid fa-trash"></i> Clear Cart
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
    let localCartState = {
        items: <%= initJson.toString() %>,
        subtotal: <%= initTotal %>,
        totalCount: <%= initCount %>,
        deliveryFee: <%= initDelivery %>,
        gst: <%= initGst %>,
        grandTotal: <%= initGrand %>
    };

    function normalizeItem(raw, existing) {
        existing = existing || {};
        const menuId = raw.menuId ?? raw.menuid ?? raw.id ?? existing.menuId ?? 0;
        const restaurantId = raw.restaurantId ?? raw.restaurantid ?? existing.restaurantId ?? 1;

        let name = raw.name ?? raw.itemName ?? raw.itemname ?? existing.name;
        if (!name || String(name).trim() === '') name = 'Food Item #' + menuId;

        let price = parseFloat(raw.price ?? raw.itemPrice ?? raw.itemprice ?? existing.price ?? NaN);
        if (isNaN(price) || price <= 0) price = (existing.price > 0 ? existing.price : 199.0);

        let quantity = parseInt(raw.quantity ?? raw.qty ?? existing.quantity ?? NaN);
        if (isNaN(quantity) || quantity < 1) quantity = 1;

        let imagePath = raw.imagePath ?? raw.image ?? existing.imagePath ?? 'assets/images/paneertikka.png';

        return {
            menuId, restaurantId, name, price, quantity,
            subtotal: price * quantity,
            imagePath
        };
    }

    function recalculateCartState() {
        let subtotal = 0, count = 0;
        localCartState.items.forEach(item => {
            subtotal += item.price * item.quantity;
            count += item.quantity;
        });
        localCartState.subtotal = subtotal;
        localCartState.totalCount = count;
        localCartState.deliveryFee = 40.0;
        localCartState.gst = 35.0;
        localCartState.grandTotal = subtotal > 0 ? (subtotal + 40.0 + 35.0) : 0;
    }

    function mergeServerCartState(serverData) {
        const prevByMenuId = {};
        localCartState.items.forEach(it => prevByMenuId[it.menuId] = it);

        const rawItems = (serverData && serverData.items) ? serverData.items : [];
        const items = rawItems.map(raw => {
            const key = raw.menuId ?? raw.menuid ?? raw.id;
            return normalizeItem(raw, prevByMenuId[key]);
        });

        localCartState = {
            items,
            subtotal: 0, totalCount: 0, deliveryFee: 40.0, gst: 35.0, grandTotal: 0
        };
        recalculateCartState();
        return localCartState;
    }

    function renderCartData(data) {
        const container = document.getElementById('sideCartItemsContainer');
        const badge = document.getElementById('floatingCartBadge');
        const headerBadge = document.getElementById('cart-count');
        const titleCount = document.getElementById('sideCartTitleCount');
        const subtotalEl = document.getElementById('sideCartSubtotal');
        const grandTotalEl = document.getElementById('sideCartGrandTotal');
        const footerEl = document.getElementById('sideCartFooter');

        if (!data || !data.items || data.items.length === 0) {
            if (container) {
                container.innerHTML = `
                    <div class="cart-empty-state">
                        <i class="fa-solid fa-basket-shopping empty-icon"></i>
                        <p>Your cart is empty!</p>
                        <span>Tap "Add to Cart" on any menu item to start ordering tasty food.</span>
                    </div>
                `;
            }
            if (badge) badge.innerText = "0";
            if (headerBadge) headerBadge.innerText = "0";
            if (titleCount) titleCount.innerText = "(0)";
            if (subtotalEl) subtotalEl.innerText = "₹0.00";
            if (grandTotalEl) grandTotalEl.innerText = "₹0.00";
            if (footerEl) footerEl.style.display = "none";
            return;
        }

        if (badge) badge.innerText = data.totalCount;
        if (headerBadge) headerBadge.innerText = data.totalCount;
        if (titleCount) titleCount.innerText = '(' + data.totalCount + ')';
        if (subtotalEl) subtotalEl.innerText = '₹' + data.subtotal.toFixed(2);
        if (grandTotalEl) grandTotalEl.innerText = '₹' + data.grandTotal.toFixed(2);
        if (footerEl) footerEl.style.display = "block";

        let html = '';
        data.items.forEach(item => {
            const itemSubtotal = (item.price * item.quantity).toFixed(2);
            html += `
                <div class="cart-item" data-menu-id="${item.menuId}">
                    <img src="${item.imagePath}" alt="${item.name}" onerror="this.onerror=null; this.src='assets/images/paneertikka.png';">
                    <div class="cart-item-info">
                        <h4 style="font-size: 1.1rem; font-weight: 800; color: #ffffff; margin-bottom: 6px; display: block; line-height: 1.3;">${item.name}</h4>
                        <div style="font-size: 13px; color: #9ca3af; margin-bottom: 10px;">
                            Price: <strong style="color: #ff5a36; font-size: 14px;">₹${item.price.toFixed(2)}</strong>
                            <span style="margin: 0 6px; color: rgba(255,255,255,0.2);">|</span>
                            Subtotal: <strong style="color: #10b981; font-size: 14px;">₹${itemSubtotal}</strong>
                        </div>
                        <div class="cart-item-controls" style="display: flex; align-items: center; gap: 12px;">
                            <button type="button" class="cart-qty-btn" onclick="updateCartItem(${item.menuId}, ${item.restaurantId}, ${item.quantity - 1})" title="Decrease quantity">
                                <i class="fa-solid fa-minus"></i>
                            </button>
                            <span class="cart-qty-val" style="font-size: 1.1rem; font-weight: 800; color: #ffffff; min-width: 24px; text-align: center; display: inline-block;">${item.quantity}</span>
                            <button type="button" class="cart-qty-btn" onclick="updateCartItem(${item.menuId}, ${item.restaurantId}, ${item.quantity + 1})" title="Increase quantity">
                                <i class="fa-solid fa-plus"></i>
                            </button>
                        </div>
                    </div>
                    <button type="button" class="remove-item-btn" onclick="deleteCartItem(${item.menuId}, ${item.restaurantId})" title="Remove item from cart">
                        <i class="fa-solid fa-trash-can"></i>
                    </button>
                </div>
            `;
        });
        if (container) container.innerHTML = html;
    }

    function openSideCart() {
        document.getElementById('sideCartDrawer').classList.add('open');
        document.body.style.overflow = 'hidden';
    }
    function closeSideCart() {
        document.getElementById('sideCartDrawer').classList.remove('open');
        document.body.style.overflow = 'auto';
    }
    function toggleSideCart() {
        const drawer = document.getElementById('sideCartDrawer');
        drawer.classList.contains('open') ? closeSideCart() : openSideCart();
    }

    function updateCartItem(menuId, restaurantId, newQuantity) {
        if (newQuantity <= 0) { deleteCartItem(menuId, restaurantId); return; }

        localCartState.items.forEach(item => {
            if (item.menuId == menuId) item.quantity = newQuantity;
        });
        recalculateCartState();
        renderCartData(localCartState);

        const params = new URLSearchParams();
        params.append('action', 'update');
        params.append('menuid', menuId);
        params.append('restaurantid', restaurantId);
        params.append('quantity', newQuantity);
        params.append('ajax', 'true');

        fetch('cartServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8', 'X-Requested-With': 'XMLHttpRequest' },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => renderCartData(mergeServerCartState(data)))
        .catch(err => console.error('Error updating cart:', err));
    }

    function deleteCartItem(menuId, restaurantId) {
        localCartState.items = localCartState.items.filter(item => item.menuId != menuId);
        recalculateCartState();
        renderCartData(localCartState);

        const params = new URLSearchParams();
        params.append('action', 'delete');
        params.append('menuid', menuId);
        params.append('restaurantid', restaurantId);
        params.append('ajax', 'true');

        fetch('cartServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8', 'X-Requested-With': 'XMLHttpRequest' },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => renderCartData(mergeServerCartState(data)))
        .catch(err => console.error('Error deleting cart item:', err));
    }

    function clearCart() {
        if (!confirm("Are you sure you want to clear all items from your cart?")) return;
        localCartState.items = [];
        recalculateCartState();
        renderCartData(localCartState);

        const params = new URLSearchParams();
        params.append('action', 'clear');
        params.append('ajax', 'true');

        fetch('cartServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8', 'X-Requested-With': 'XMLHttpRequest' },
            body: params.toString()
        })
        .then(res => res.json())
        .then(data => renderCartData(mergeServerCartState(data)))
        .catch(err => console.error('Error clearing cart:', err));
    }

    document.addEventListener('DOMContentLoaded', () => {
        localCartState.items = localCartState.items.map(it => normalizeItem(it, null));
        recalculateCartState();
        renderCartData(localCartState);
        const headerCartToggle = document.getElementById('cart-toggle-btn');
        if (headerCartToggle) {
            headerCartToggle.addEventListener('click', (e) => {
                e.preventDefault();
                toggleSideCart();
            });
        }
    });
	</script>
</body>
</html>
