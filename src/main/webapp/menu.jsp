
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page
	import="java.util.List, com.tap.model.Menu, com.tap.model.Restaurant, com.tap.model.user, com.tap.model.Carts, com.tap.model.CartItems"%>


<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Menu Item Card</title>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="index.css">

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
</script>

</head>
<body>

	<!-- Header Navigation -->
	<header class="header">
		<div class="header-container">
			<a href="accessed"
				onclick="localStorage.clear(); sessionStorage.clear();" class="logo">
				<span class="logo-icon"><i class="fa-solid fa-arrow-pointer"></i></span>
				Click<span>Chow</span>
			</a>

			<%
			user user = (user) session.getAttribute("loggedInUser");
			if (user == null) {
				response.sendRedirect("login.jsp");
				return;
			}
			%>

			<div class="profile">

				<button class="profile-btn" onclick="toggleProfile()">
					👤
					<%=user.getUser_name()%></button>

				<div class="profile-card" id="profileCard">

					<h3>My Profile</h3>

					<div class="row">
						<span>Username</span> <span><%=user.getUser_name()%></span>
					</div>

					<div class="row">
						<span>Email</span> <span><%=user.getEmail()%></span>
					</div>
					<div class="row">
						<span>Address</span> <span><%=user.getAddress()%></span>
					</div>

					<div class="row">
						<span>Role</span> <span><%=user.getRole()%></span>
					</div>

					<a href="orderHistory">📜 Order History</a>
					<a href="editProfile.jsp">✏ Edit Profile</a> <a
						href="LogoutServlet">🚪 Logout</a>

				</div>

			</div>

			<%
			Carts initialCartObj = (Carts) session.getAttribute("cart");
			double initTotal = 0;
			int initCount = 0;
			%>

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
				<button type="button" class="cart-btn" onclick="openSideCart()"
					style="cursor: pointer; border: none;">
					<i class="fa-solid fa-bag-shopping"></i> View Cart <span
						id="headerCartCount"
						style="background: #fff; color: #ff5a36; padding: 2px 8px; border-radius: 12px; font-weight: 800; font-size: 12px; margin-left: 4px;"><%=initCount%></span>
				</button>
			</div>






		</div>
	</header>

	<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
	<div class="top-back-bar">
		<a href="accessed" class="btn-back-nav" id="backToRestaurantsBtn">
			<i class="fa-solid fa-arrow-left"></i> <span>Restaurants</span>
		</a>
	</div>

	<div class="menu-header">


		<h1 class="gradient-text">
			Explore Our Delicious <br> Menu
		</h1>

		<%
		Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
		String restName = (restaurant != null && restaurant.getName() != null)
				? restaurant.getName()
				: "Click Chow Signature Feast";
		%>
		<h3 class="restaurantname">
			<%=restName%>
		</h3>
	</div>

	<div class="food-grid">

		<%!public String getUniqueDishImage(com.tap.model.Menu menu) {
		if (menu == null)
			return "assets/images/biryani.png";
		String name = menu.getItemName() != null ? menu.getItemName().toLowerCase() : "";
		String customPath = menu.getImagePath();

		// If customPath is valid asset path (not missing images/menu/ folder), use it
		if (customPath != null && !customPath.trim().isEmpty() && !customPath.startsWith("images/menu/")
				&& !customPath.contains("biryani.png")) {
			return customPath;
		}

		// Match food dish keywords to available project food images
		if (name.contains("biryani") || name.contains("rice") || name.contains("pulao") || name.contains("thali")
				|| name.contains("tiffin") || name.contains("dosa") || name.contains("idli")) {
			return "assets/images/biryani.png";
		}
		if (name.contains("burger") || name.contains("sandwich") || name.contains("wrap") || name.contains("roll")) {
			return "assets/images/burger.png";
		}
		if (name.contains("pizza") || name.contains("naan") || name.contains("roti") || name.contains("bread")
				|| name.contains("pasta") || name.contains("kulcha")) {
			return "assets/images/pizza.png";
		}
		if (name.contains("paneer") || name.contains("tikka") || name.contains("tandoori") || name.contains("kebab")
				|| name.contains("chicken") || name.contains("mutton") || name.contains("lamb")
				|| name.contains("starter") || name.contains("curry") || name.contains("masala") || name.contains("fry")
				|| name.contains("rasam") || name.contains("chukka") || name.contains("roast")) {
			return "assets/images/paneertikka.png";
		}
		if (name.contains("sushi") || name.contains("noodle") || name.contains("ramen") || name.contains("fish")
				|| name.contains("seafood") || name.contains("asian") || name.contains("prawn")
				|| name.contains("lobster")) {
			return "assets/images/sushi.png";
		}
		if (name.contains("dessert") || name.contains("cake") || name.contains("ice cream") || name.contains("sweet")
				|| name.contains("shake") || name.contains("coffee") || name.contains("tea") || name.contains("drink")
				|| name.contains("lassi") || name.contains("payasam") || name.contains("kesari")
				|| name.contains("jamun") || name.contains("chocolate")) {
			return "assets/images/dessert.png";
		}

		// Deterministic local food image cycling based on menuID so every menu item gets a unique local image
		String[] localFoodPhotos = {"assets/images/burger.png", "assets/images/pizza.png",
				"assets/images/paneertikka.png", "assets/images/sushi.png", "assets/images/dessert.png",
				"assets/images/biryani.png"};
		int idx = Math.abs(menu.getMenuID()) % localFoodPhotos.length;
		return localFoodPhotos[idx];
	}%>

		<%
		@SuppressWarnings("unchecked")
		List<Menu> menuByRestaurant = (List<Menu>) request.getAttribute("menuByRestaurant");

		// Fallback loading via DAO if attribute is missing
		if (menuByRestaurant == null || menuByRestaurant.isEmpty()) {
			com.tap.daoIMP.MenuDAOImp mDao = new com.tap.daoIMP.MenuDAOImp();
			Integer curRestId = (Integer) session.getAttribute("restaurantid");
			if (curRestId != null) {
				menuByRestaurant = mDao.getMenuByRestaurant(curRestId);
			}
			if (menuByRestaurant == null || menuByRestaurant.isEmpty()) {
				menuByRestaurant = mDao.getAllMenu();
			}
		}

		// Hardcoded high-quality fallback items if DB returns no records
		if (menuByRestaurant == null || menuByRestaurant.isEmpty()) {
			menuByRestaurant = new java.util.ArrayList<Menu>();
			int rId = (restaurant != null) ? restaurant.getRestaurant_id() : 1;
			menuByRestaurant.add(new Menu(1, rId, "Hyderabadi Dum Biryani",
			"Fragrant basmati rice cooked with authentic spices and succulent meat.", 299.0, true,
			"assets/images/biryani.png", 4.9));
			menuByRestaurant.add(new Menu(2, rId, "Gourmet Cheese Burger",
			"Juicy grilled patty topped with melted cheddar, lettuce & house sauce.", 199.0, true,
			"assets/images/burger.png", 4.8));
			menuByRestaurant.add(new Menu(3, rId, "Supreme Pepperoni Pizza",
			"Hand-tossed crust with rich tomato sauce, mozzarella & spicy pepperoni.", 349.0, true,
			"assets/images/pizza.png", 4.9));
			menuByRestaurant.add(
			new Menu(4, rId, "Paneer Tikka Masala", "Char-grilled cottage cheese cubes simmered in spiced cream gravy.",
					240.0, true, "assets/images/paneertikka.png", 4.7));
			menuByRestaurant.add(
			new Menu(5, rId, "Dragon Salmon Sushi Roll", "Fresh salmon rolled with avocado, cucumber & Japanese mayo.",
					450.0, true, "assets/images/sushi.png", 4.9));
			menuByRestaurant.add(
			new Menu(6, rId, "Belgian Choco Lava Cake", "Warm chocolate cake filled with molten dark chocolate center.",
					150.0, true, "assets/images/dessert.png", 4.9));
		}

		for (Menu menu : menuByRestaurant) {
		%>

		<div class="menu-card" id="menu-item-<%=menu.getMenuID()%>" data-menuid="<%=menu.getMenuID()%>" data-itemname="<%=menu.getItemName().toLowerCase()%>">

			<img src="<%=getUniqueDishImage(menu)%>"
				alt="<%=menu.getItemName()%>"
				onerror="this.onerror=null; this.src='assets/images/paneertikka.png';">

			<div class="card-content">

				<h2><%=menu.getItemName()%></h2>

				<p class="description">
					<%=menu.getDescription()%>
				</p>

				<div class="details">
					<span class="rating">⭐ <%=menu.getRating()%></span> <span
						class="price">₹ <%=menu.getPrice()%></span>
				</div>

				<div class="extra-details">
					<span><i class="fa-solid fa-fire"></i> Fresh</span> <span><i
						class="fa-solid fa-clock"></i> 20-30 mins</span>
				</div>



				<form action="cartServlet" method="post"
					onsubmit="submitAddToCart(event, this)">

					<input type="hidden" name="menuid" value="<%=menu.getMenuID()%>">
					<input type="hidden" name="restaurantid"
						value="<%=menu.getRestaurantID()%>"> <input type="hidden"
						name="quantity" value="1"> <input type="hidden"
						name="action" value="add"> <input type="hidden"
						name="itemname"
						value="<%=menu.getItemName()%>">
					<input type="hidden" name="itemprice" value="<%=menu.getPrice()%>">
					<input type="hidden" name="itemimage"
						value="<%=getUniqueDishImage(menu)%>">
					<button type="submit" class="btn" value="Add to cart">🛒
						Add to Cart</button>

				</form>



			</div>

		</div>

		<%
		}
		%>

	</div>

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
.profile {
	position: relative;
	display: inline-block;
}

.profile-btn {
	padding: 12px 22px;
	margin-right: 10px;
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
/* Header Styles */
.userbutton {
	padding: 10px 20px;
	font-size: 0.95rem;
	background: var(--bg-card);
	color: var(--text-primary);
	border: 1px solid var(--border-color);
	font-weight: 500;
	padding: 12px 28px;
	border-radius: var(--border-radius-full);
	transition: var(--transition-fast);
}

.header {
	background: rgba(9, 11, 18, 0.85);
	backdrop-filter: blur(12px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	position: sticky;
	top: 0;
	z-index: 100;
	padding: 15px 0;
}

.header-container {
	width: 95%;
	max-width: 1650px;
	margin: 0 auto;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

a.logo {
	margin-right: auto;
}

.logo {
	color: white;
	text-decoration: none;
	font-size: 24px;
	font-weight: 800;
	display: flex;
	align-items: center;
	gap: 8px;
}

.logo span {
	background: linear-gradient(90deg, #ff5a36, #ec4899);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.logo-icon {
	color: #ff5a36;
}

.cart-btn {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 10px 20px;
	border-radius: 50px;
	background: linear-gradient(90deg, #ff5a36, #ec4899);
	color: white;
	text-decoration: none;
	font-weight: 700;
	box-shadow: 0 8px 20px rgba(255, 90, 54, 0.3);
	transition: 0.3s;
}

.cart-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 12px 25px rgba(255, 90, 54, 0.45);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Outfit', sans-serif;
}

.food-grid {
	width: 95%;
	max-width: 1650px;
	margin: 60px auto;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(270px, 1fr));
	gap: 32px;
	justify-items: center;
	align-items: start;
}

body {
	background: #090b12;
}

.menu-container {
	width: 95%;
	margin: 60px auto;
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
	gap: 28px;
}

.menu-card {
	width: 100%;
	max-width: 310px;
	background: #1b2030;
	border-radius: 22px;
	overflow: hidden;
	border: 1px solid rgba(255, 255, 255, .08);
	transition: .35s;
	box-shadow: 0 12px 30px rgba(0, 0, 0, .35);
	display: flex;
	flex-direction: column;
}

.menu-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 20px 45px rgba(255, 90, 54, .20);
}

.menu-card img {
	width: 100%;
	height: 180px;
	object-fit: cover;
}

.card-content {
	padding: 18px;
	display: flex;
	flex-direction: column;
	flex: 1;
}

.card-content h2 {
	color: white;
	font-weight: 700;
	margin-bottom: 8px;
}

.description {
	color: #AEB8CC;
	font-size: 15px;
	line-height: 24px;
	min-height: 48px;
	max-height: 48px;
	overflow: hidden;
	margin-bottom: 18px;
}

.details {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 18px;
}

.rating {
	color: #ffb703;
	font-size: 18px;
	font-weight: 700;
}

.price {
	font-size: 24px;
	font-weight: 800;
	background: linear-gradient(90deg, #ff5a36, #ec4899);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.extra-details {
	display: flex;
	justify-content: space-between;
	border-top: 1px solid rgba(255, 255, 255, .08);
	padding-top: 16px;
	margin-bottom: 18px;
	color: #9AA6BE;
	font-size: 14px;
}

.extra-details span i {
	color: #ff5a36;
	margin-right: 6px;
}

.btn {
	margin-top: auto;
	width: 100%;
	padding: 14px;
	border-radius: 50px;
	text-align: center;
	text-decoration: none;
	background: linear-gradient(90deg, #ff5a36, #ec4899);
	color: white;
	font-weight: 700;
	transition: .3s;
}

.btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 30px rgba(255, 90, 54, .35);
}

.menu-header {
	text-align: center;
	max-width: 850px;
	margin: 60px auto 50px;
	padding: 0 20px;
}

.restaurantname {
	display: inline-block;
	padding: 10px 22px;
	border-radius: 40px;
	background: rgba(255, 90, 54, .12);
	letter-spacing: 1px;
	margin-bottom: 22px;
	font-size: 64px;
	line-height: 74px;
	font-weight: 800;
	color: white;
	margin-bottom: 18px;
	background: linear-gradient(90deg, #ffffff 0%, #ffffff 45%, #ff5a36 65%, #ec4899
		100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.menu-tag {
	display: inline-block;
	padding: 10px 22px;
	border-radius: 40px;
	background: rgba(255, 90, 54, .12);
	color: #ff744c;
	font-size: 15px;
	font-weight: 700;
	letter-spacing: 1px;
	margin-bottom: 22px;
}

.gradient-text {
	font-size: 45px;
	line-height: 74px;
	font-weight: 800;
	color: white;
	margin-bottom: 18px;
}

.gradient-text {
	background: linear-gradient(90deg, #ffffff 0%, #ffffff 45%, #ff5a36 65%, #ec4899
		100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.menu-header p {
	color: #9FA9BC;
	font-size: 20px;
	line-height: 34px;
	max-width: 760px;
	margin: auto;
}

.divider {
	width: 120px;
	height: 5px;
	margin: 35px auto 0;
	border-radius: 20px;
	background: linear-gradient(90deg, #ff5a36, #ec4899);
}
</style>

	<%
	StringBuilder initJson = new StringBuilder("[");
	if (initialCartObj != null && initialCartObj.getItems() != null) {
		boolean f = true;
		for (CartItems ci : initialCartObj.getItems().values()) {
			if (!f)
				initJson.append(",");
			f = false;
			String ciName = (ci.getName() != null && !ci.getName().trim().isEmpty())
					? ci.getName()
					: "Food Item #" + ci.getMenuId();
			double ciPrice = ci.getPrice();
			int ciQty = ci.getQuantity() > 0 ? ci.getQuantity() : 1;
			double sub = ci.getSubTotal();
			initTotal += sub;
			initCount += ciQty;
			String nameEsc = com.tap.CartServlet.escapeJson(ciName);
			String imgEsc = ci.getImagePath() != null ? com.tap.CartServlet.escapeJson(ci.getImagePath()) : "assets/images/paneertikka.png";
			initJson.append("{").append("\"menuId\":").append(ci.getMenuId()).append(",").append("\"restaurantId\":")
					.append(ci.getRestaurantId()).append(",").append("\"name\":\"").append(nameEsc).append("\",")
					.append("\"price\":").append(ciPrice).append(",").append("\"quantity\":").append(ciQty).append(",")
					.append("\"subtotal\":").append(sub).append(",").append("\"imagePath\":\"").append(imgEsc).append("\"")
					.append("}");
		}
	}
	initJson.append("]");
	double initDelivery = 40.0;
	double initGst = 35.0;
	double initGrand = initTotal > 0 ? (initTotal + initDelivery + initGst) : 0;
	%>

	<!-- Toast Notification Container -->
	<div id="cartToastContainer"></div>

	<!-- Floating Cart Action Launcher (Bottom-Right) -->
	<div class="floating-cart-trigger" id="floatingCartTrigger"
		onclick="toggleSideCart()">
		<i class="fa-solid fa-bag-shopping"></i> <span>Cart</span> <span
			class="floating-cart-badge" id="floatingCartBadge"><%=initCount%></span>
	</div>

	<!-- Floating Side Cart Drawer -->
	<div class="cart-drawer" id="sideCartDrawer">
		<div class="cart-drawer-overlay" onclick="closeSideCart()"></div>
		<div class="cart-drawer-content">
			<div class="cart-drawer-header">
				<h3>
					Your Cart <span class="cart-count-title" id="sideCartTitleCount">(<%=initCount%>)
					</span>
				</h3>
				<button type="button" class="close-cart-btn"
					onclick="closeSideCart()">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</div>

			<div class="cart-items-container" id="sideCartItemsContainer">
				<!-- Rendered dynamically by JS -->
			</div>

			<div class="cart-drawer-footer" id="sideCartFooter">
				<div class="cart-summary-row">
					<span>Subtotal</span> <span id="sideCartSubtotal">₹<%=String.format("%.2f", initTotal)%></span>
				</div>
				<div class="cart-summary-row">
					<span>Delivery Fee</span> <span>₹40.00</span>
				</div>
				<div class="cart-summary-row">
					<span>Tax (GST)</span> <span>₹35.00</span>
				</div>
				<div class="cart-summary-divider"></div>
				<div class="cart-summary-row total-row">
					<span>Total</span> <span id="sideCartGrandTotal">₹<%=String.format("%.2f", initGrand)%></span>
				</div>
				<div
					style="display: flex; flex-direction: column; gap: 10px; margin-top: 14px;">
					<a href="checkOut.jsp" class="btn-side-cart-checkout"> Proceed
						to Checkout <i class="fa-solid fa-arrow-right"></i>
					</a>
					<div style="display: flex; gap: 10px;">
						<a href="cart.jsp"
							style="flex: 1; text-align: center; display: flex; align-items: center; justify-content: center; gap: 6px; padding: 12px; border-radius: 50px; text-decoration: none; font-size: 14px; font-weight: 700; color: #fff; background: rgba(255, 255, 255, 0.08); border: 1px solid rgba(255, 255, 255, 0.12); transition: 0.2s;"
							onmouseover="this.style.background='rgba(255,255,255,0.15)';"
							onmouseout="this.style.background='rgba(255,255,255,0.08)';">
							<i class="fa-solid fa-cart-shopping"></i> View Cart Page
						</a>
						<button type="button" onclick="clearCart()"
							style="padding: 12px 18px; border-radius: 50px; border: 1px solid rgba(239, 68, 68, 0.3); background: rgba(239, 68, 68, 0.12); color: #ef4444; font-size: 14px; font-weight: 700; cursor: pointer; transition: 0.2s;"
							onmouseover="this.style.background='#ef4444'; this.style.color='#fff';"
							onmouseout="this.style.background='rgba(239,68,68,0.12)'; this.style.color='#ef4444';">
							<i class="fa-solid fa-trash"></i> Clear Cart
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
let localCartState = {
    items: <%=initJson.toString()%>,
    subtotal: <%=initTotal%>,
    totalCount: <%=initCount%>,
    deliveryFee: <%=initDelivery%>,
    gst: <%=initGst%>,
    grandTotal: <%=initGrand%>
};

let hasOpenedCartDrawer = localCartState.items && localCartState.items.length > 0;

// --- Normalizes ANY item shape (client-built or servlet JSON) into one consistent shape,
// falling back to whatever we already know locally if a field is missing/blank.
function normalizeItem(raw, existing) {
    existing = existing || {};
    const menuId = raw.menuId ?? raw.menuid ?? raw.id ?? existing.menuId ?? 0;
    const restaurantId = raw.restaurantId ?? raw.restaurantid ?? existing.restaurantId ?? 1;

    let name = raw.name ?? raw.itemName ?? raw.itemname ?? existing.name;
    if (!name || String(name).trim() === '') name = 'Food Item #' + menuId;

    let price = parseFloat(raw.price ?? raw.itemPrice ?? raw.itemprice ?? existing.price);
    if (isNaN(price) || price < 0) price = (existing.price >= 0 ? existing.price : 0);

    let quantity = parseInt(raw.quantity ?? raw.qty ?? existing.quantity);
    if (isNaN(quantity) || quantity < 1) quantity = 1;

    let imagePath = raw.imagePath ?? raw.image ?? existing.imagePath;
    if (!imagePath || String(imagePath).trim() === '') imagePath = 'assets/images/paneertikka.png';

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

// Merges a servlet response into localCartState instead of blindly replacing it
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
    const headerCount = document.getElementById('headerCartCount');
    const titleCount = document.getElementById('sideCartTitleCount');
    const subtotalEl = document.getElementById('sideCartSubtotal');
    const grandTotalEl = document.getElementById('sideCartGrandTotal');
    const footerEl = document.getElementById('sideCartFooter');

    if (!data || !data.items || data.items.length === 0) {
        container.innerHTML = '<div class="cart-empty-state">'
            + '<i class="fa-solid fa-basket-shopping empty-icon"></i>'
            + '<p>Your cart is empty!</p>'
            + '<span>Tap "Add to Cart" on any menu item to start ordering tasty food.</span>'
            + '</div>';
        if (badge) badge.innerText = "0";
        if (headerCount) headerCount.innerText = "0";
        if (titleCount) titleCount.innerText = "(0)";
        if (subtotalEl) subtotalEl.innerText = "₹0.00";
        if (grandTotalEl) grandTotalEl.innerText = "₹0.00";
        if (footerEl) footerEl.style.display = "none";
        return;
    }

    if (badge) badge.innerText = data.totalCount;
    if (headerCount) headerCount.innerText = data.totalCount;
    if (titleCount) titleCount.innerText = '(' + data.totalCount + ')';
    if (subtotalEl) subtotalEl.innerText = '₹' + data.subtotal.toFixed(2);
    if (grandTotalEl) grandTotalEl.innerText = '₹' + data.grandTotal.toFixed(2);
    if (footerEl) footerEl.style.display = "block";

    let html = '';
    data.items.forEach(item => {
        const itemSubtotal = (item.price * item.quantity).toFixed(2);
        html += '<div class="cart-item" data-menu-id="' + item.menuId + '">'
            + '<img src="' + item.imagePath + '" alt="' + item.name + '" onerror="this.onerror=null; this.src=\'assets/images/paneertikka.png\';">'
            + '<div class="cart-item-info">'
            + '<h4 style="font-size: 1.1rem; font-weight: 800; color: #ffffff; margin-bottom: 6px; display: block; line-height: 1.3;">' + item.name + '</h4>'
            + '<div style="font-size: 13px; color: #9ca3af; margin-bottom: 10px;">'
            + 'Price: <strong style="color: #ff5a36; font-size: 14px;">₹' + item.price.toFixed(2) + '</strong> <br>'
            + 'Subtotal: <strong style="color: #10b981; font-size: 14px;">₹' + itemSubtotal + '</strong>'
            + '</div>'
            + '<div class="cart-item-controls" style="display: flex; align-items: center; gap: 12px;">'
            + '<button type="button" class="cart-qty-btn" onclick="updateCartItem(' + item.menuId + ', ' + item.restaurantId + ', ' + (item.quantity - 1) + ')" title="Decrease quantity">'
            + '<i class="fa-solid fa-minus"></i>'
            + '</button>'
            + '<span class="cart-qty-val" style="font-size: 1.1rem; font-weight: 800; color: #ffffff; min-width: 24px; text-align: center; display: inline-block;">' + item.quantity + '</span>'
            + '<button type="button" class="cart-qty-btn" onclick="updateCartItem(' + item.menuId + ', ' + item.restaurantId + ', ' + (item.quantity + 1) + ')" title="Increase quantity">'
            + '<i class="fa-solid fa-plus"></i>'
            + '</button>'
            + '</div>'
            + '</div>'
            + '<button type="button" class="remove-item-btn" onclick="deleteCartItem(' + item.menuId + ', ' + item.restaurantId + ')" title="Remove item from cart">'
            + '<i class="fa-solid fa-trash-can"></i>'
            + '</button>'
            + '</div>';
    });
    container.innerHTML = html;
}

function openSideCart() {
    document.getElementById('sideCartDrawer').classList.add('open');
    document.body.style.overflow = 'hidden';
    hasOpenedCartDrawer = true;
}
function closeSideCart() {
    document.getElementById('sideCartDrawer').classList.remove('open');
    document.body.style.overflow = 'auto';
}
function toggleSideCart() {
    const drawer = document.getElementById('sideCartDrawer');
    drawer.classList.contains('open') ? closeSideCart() : openSideCart();
}

function showAddToCartToast(itemName, itemImage) {
    const container = document.getElementById('cartToastContainer');
    if (!container) return;
    const toast = document.createElement('div');
    toast.className = 'add-to-cart-toast';
    toast.innerHTML = '<img src="' + itemImage + '" alt="' + itemName + '" onerror="this.onerror=null; this.src=\'assets/images/paneertikka.png\';">'
        + '<div class="toast-content">'
        + '<div class="toast-title">Added to Cart!</div>'
        + '<div class="toast-subtitle">' + itemName + '</div>'
        + '</div>'
        + '<div class="toast-check"><i class="fa-solid fa-circle-check"></i></div>';
    container.appendChild(toast);
    requestAnimationFrame(() => toast.classList.add('show'));
    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 350);
    }, 2200);
}

function showReplaceCartModal(onConfirm, onCancel) {
    let modal = document.getElementById('replaceCartModal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'replaceCartModal';
        modal.className = 'custom-modal-backdrop';
        modal.innerHTML = `
            <div class="custom-modal-card">
                <div class="custom-modal-icon">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <h3 class="custom-modal-title">Replace cart items?</h3>
                <p class="custom-modal-text">
                    Your cart contains items from another restaurant. Do you want to clear your cart and add items from this restaurant instead?
                </p>
                <div class="custom-modal-actions">
                    <button type="button" class="btn-modal-cancel" id="btnCancelReplaceCart">
                        No, Keep Cart
                    </button>
                    <button type="button" class="btn-modal-confirm" id="btnConfirmReplaceCart">
                        Yes, Change Cart
                    </button>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }
    modal.style.display = 'flex';

    const confirmBtn = modal.querySelector('#btnConfirmReplaceCart');
    const cancelBtn = modal.querySelector('#btnCancelReplaceCart');

    confirmBtn.onclick = function() {
        modal.style.display = 'none';
        if (onConfirm) onConfirm();
    };

    cancelBtn.onclick = function() {
        modal.style.display = 'none';
        if (onCancel) onCancel();
    };

    modal.onclick = function(e) {
        if (e.target === modal) {
            modal.style.display = 'none';
            if (onCancel) onCancel();
        }
    };
}

function submitAddToCart(event, form, forceOverride) {
    if (event) event.preventDefault();
    const formData = new FormData(form);
    const menuId = parseInt(formData.get('menuid')) || 0;
    const restaurantId = parseInt(formData.get('restaurantid')) || 1;
    const itemName = formData.get('itemname') || ('Food Item #' + menuId);
    const itemPrice = parseFloat(formData.get('itemprice')) || 199.0;
    const itemImage = formData.get('itemimage') || 'assets/images/paneertikka.png';

    // Single Restaurant Validation Check
    if (!forceOverride && localCartState.items && localCartState.items.length > 0) {
        const existingWithRest = localCartState.items.find(i => i.restaurantId > 0);
        const currentRestId = existingWithRest ? existingWithRest.restaurantId : null;

        if (currentRestId && restaurantId && currentRestId != restaurantId) {
            showReplaceCartModal(
                function onConfirm() {
                    localCartState.items = [];
                    recalculateCartState();
                    renderCartData(localCartState);
                    submitAddToCart(null, form, true);
                },
                function onCancel() {}
            );
            return false;
        }
    }

    showAddToCartToast(itemName, itemImage);
    const submitBtn = form.querySelector('button[type="submit"]');
    if (submitBtn) {
        const originalHTML = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fa-solid fa-circle-check"></i> Added!';
        submitBtn.style.background = 'linear-gradient(135deg, #10b981, #059669)';
        submitBtn.style.transform = 'scale(0.96)';
        setTimeout(() => { submitBtn.style.transform = 'scale(1.04)'; }, 120);
        setTimeout(() => {
            submitBtn.innerHTML = originalHTML;
            submitBtn.style.background = '';
            submitBtn.style.transform = '';
        }, 1200);
    }

    const isFirstItem = localCartState.items.length === 0;
    if (isFirstItem || !hasOpenedCartDrawer) {
        openSideCart();
    } else {
        const badge = document.getElementById('floatingCartBadge');
        if (badge) {
            badge.style.transform = 'scale(1.4)';
            setTimeout(() => { badge.style.transform = 'scale(1)'; }, 250);
        }
    }

    // Optimistic local update, normalized
    const existing = localCartState.items.find(i => i.menuId == menuId);
    if (existing) {
        existing.quantity += 1;
    } else {
        localCartState.items.push(normalizeItem(
            { menuId, restaurantId, name: itemName, price: itemPrice, quantity: 1, imagePath: itemImage },
            null
        ));
    }
    recalculateCartState();
    renderCartData(localCartState);

    const params = new URLSearchParams();
    for (const pair of formData.entries()) params.append(pair[0], pair[1]);
    if (forceOverride) params.append('force', 'true');
    params.append('ajax', 'true');

    fetch('cartServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8', 'X-Requested-With': 'XMLHttpRequest' },
        body: params.toString()
    })
    .then(res => res.json())
    .then(data => {
        if (data && data.status === 'conflict') {
            showReplaceCartModal(
                function() {
                    localCartState.items = [];
                    recalculateCartState();
                    renderCartData(localCartState);
                    submitAddToCart(null, form, true);
                },
                function() {}
            );
        } else {
            renderCartData(mergeServerCartState(data));
        }
    })
    .catch(err => console.error('Cart sync error:', err));
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
    // Normalize the SSR-rendered initial items too, in case JSP-side fields were blank
    localCartState.items = localCartState.items.map(it => normalizeItem(it, null));
    recalculateCartState();
    renderCartData(localCartState);
});
</script>
<script src="app.js"></script>
</body>
</html>
