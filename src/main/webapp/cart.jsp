<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.tap.model.user,com.tap.model.Carts,com.tap.model.CartItems , com.tap.model.Menu,java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Click Chow | Cart</title>
<link
	href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="index.css">

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Outfit', sans-serif;
}

body {
	background: #0b0c10;
	color: #fff;
	min-height: 100vh;
	background-image: radial-gradient(circle at top left, #ff5a3630, transparent 35%),
		radial-gradient(circle at bottom right, #ec489930, transparent 35%);
}

a {
	text-decoration: none;
	color: inherit;
}

.navbar {
	position: sticky;
	top: 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 18px 6%;
	background: rgba(17, 20, 28, .75);
	backdrop-filter: blur(18px);
	border-bottom: 1px solid rgba(255, 255, 255, .08);
	z-index: 100;
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

.nav-links {
	display: flex;
	gap: 30px;
	align-items: center;
}

.nav-links a {
	color: #ddd;
	transition: .3s;
	font-weight: 500;
}

.nav-links a:hover {
	color: #ff6b35;
}

.container {
	width: 92%;
	max-width: 1400px;
	margin: 40px auto;
}

.page-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
}

.page-title h1 {
	font-size: 42px;
	font-weight: 800;
}

.continue-btn {
	padding: 14px 28px;
	border-radius: 50px;
	background: linear-gradient(135deg, #ff6b35, #ec4899);
	color: white;
	font-weight: 700;
}

.cart-layout {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 30px;
}

@media ( max-width :900px) {
	.cart-layout {
		grid-template-columns: 1fr;
	}
	.nav-links {
		gap: 16px;
		font-size: 14px;
	}
	.page-title {
		flex-direction: column;
		gap: 20px;
	}
}

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

.header {
	background: rgba(9, 11, 18, 0.85);
	backdrop-filter: blur(12px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.08);
	position: sticky;
	top: 0;
	z-index: 100;
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
</script>
</head>
<body>

	<%
	Integer restaurantId = (Integer) session.getAttribute("restaurantid");
	String continueUrl = (restaurantId != null)
	        ? "menu?restaurantId=" + restaurantId
	        : "restaurant";
	
	user u = (user) session.getAttribute("loggedInUser");
	if (u == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	Carts cart = (Carts) session.getAttribute("cart");
	%>

	<!-- Header Navigation -->
	<header class="header">
		<div class="header-container">
			<a href="accessed"  class="logo">
				<span class="logo-icon"><i class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
			</a>

			<div class="profile">
				<button class="profile-btn" onclick="toggleProfile()">👤 <%=u.getUser_name()%></button>
				<div class="profile-card" id="profileCard">
					<h3>My Profile</h3>
					<div class="row">
						<span>Username</span> <span><%=u.getUser_name()%></span>
					</div>
					<div class="row">
						<span>Email</span> <span><%=u.getEmail()%></span>
					</div>
					<div class="row">
						<span>Address</span> <span><%=u.getAddress()%></span>
					</div>
					<div class="row">
						<span>Role</span> <span><%=u.getRole()%></span>
					</div>
					<a href="orderHistory">📜 Order History</a>
					<a href="editProfile.jsp">✏ Edit Profile</a> 
					<a href="LogoutServlet">🚪 Logout</a>
				</div>
			</div>

			<div class="header-actions">
				<button type="button" class="cart-btn" onclick="openSideCart()" style="cursor: pointer; border: none;">
					<i class="fa-solid fa-bag-shopping"></i> Side Cart
				</button>
			</div>
		</div>
	</header>

	<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
	<div class="top-back-bar">
		<a href="menu" class="btn-back-nav" id="backToMenuBtn">
			<i class="fa-solid fa-arrow-left"></i> <span>Menu</span>
		</a>
	</div>

	<div class="container">


		<div class="page-title">
			<h1>🛒 My Cart</h1>
			<a href="<%=continueUrl%>" class="continue-btn"> ← Continue Shopping </a>
		</div>

		<div class="cart-layout" id="mainCartLayoutContainer">

			<%
			if (cart == null || cart.getItems() == null || cart.getItems().isEmpty()) {
			%>

			<div class="empty-cart"
				style="grid-column: 1/-1; text-align: center; padding: 80px; background: #171b25; border-radius: 25px;">
				<div style="font-size: 90px;">🛒</div>
				<h2 style="margin: 20px 0;">Your Cart is Empty</h2>
				<p style="color: #bbb; margin-bottom: 30px;">Looks like you haven't added anything yet.</p>
				<a href="<%=continueUrl%>" class="continue-btn">Browse Restaurants</a>
			</div>

			<%
			} else {
			double total = 0;
			%>

			<div class="cart-items">

				<%
				for (CartItems item : cart.getItems().values()) {
					double subtotal = item.getPrice() * item.getQuantity();
					total += subtotal;
				%>

				<div class="cart-card"
					style="display: grid; grid-template-columns: 170px 1fr 180px; gap: 25px; background: #171b25; padding: 22px; border-radius: 22px; margin-bottom: 22px; border: 1px solid rgba(255, 255, 255, .06);">

					<img src="<%=item.getImagePath()%>"
						style="width: 170px; height: 140px; object-fit: cover; border-radius: 18px;"
						onerror="this.onerror=null; this.src='assets/images/paneertikka.png';">

					<div class="details">
						<h2 style="margin-bottom: 10px;"><%=item.getName()%></h2>
						<div style="margin-top: 15px; font-size: 24px; color: #22c55e; font-weight: 700;">
							₹<%=item.getPrice()%>
						</div>
						<div style="margin-top: 10px; color: #bbb;">
							Subtotal : ₹<%=subtotal%>
						</div>
					</div>

					<div class="actions"
						style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 18px;">
						<div style="display: flex; align-items: center; background: #242b39; padding: 8px; border-radius: 40px;">
							<button type="button" onclick="updateCartItem(<%=item.getMenuId()%>, <%=item.getRestaurantId()%>, <%=item.getQuantity() - 1%>)"
								style="width: 40px; height: 40px; border: none; border-radius: 50%; background: #ff6b35; color: white; font-size: 20px; cursor: pointer;">-</button>
							<span style="padding: 0 18px; font-size: 20px; font-weight: 700;">
								<%=item.getQuantity()%>
							</span>
							<button type="button" onclick="updateCartItem(<%=item.getMenuId()%>, <%=item.getRestaurantId()%>, <%=item.getQuantity() + 1%>)"
								style="width: 40px; height: 40px; border: none; border-radius: 50%; background: #ff6b35; color: white; font-size: 20px; cursor: pointer;">+</button>
						</div>

						<button type="button" onclick="deleteCartItem(<%=item.getMenuId()%>, <%=item.getRestaurantId()%>)"
							style="padding: 12px 24px; border: none; border-radius: 40px; background: #ef4444; color: white; font-weight: 700; cursor: pointer;">
							🗑 Remove</button>
					</div>

				</div>

				<%
				}
				%>

			</div>

			<div class="summary"
				style="background: #171b25; padding: 28px; border-radius: 22px; height: max-content; border: 1px solid rgba(255, 255, 255, .06);">
				<h2 style="margin-bottom: 25px;">Order Summary</h2>
				<div style="display: flex; justify-content: space-between; margin: 15px 0;">
					<span>Items Total</span> <span>₹<%=total%></span>
				</div>
				<div style="display: flex; justify-content: space-between; margin: 15px 0;">
					<span>Delivery Charge</span> <span>₹40</span>
				</div>
				<div style="display: flex; justify-content: space-between; margin: 15px 0;">
					<span>GST</span> <span>₹35</span>
				</div>
				<div style="display: flex; justify-content: space-between; margin: 15px 0;">
					<span>Discount</span> <span style="color: #22c55e;">- ₹0</span>
				</div>
				<hr style="margin: 20px 0; border-color: rgba(255, 255, 255, .08);">
				<div style="display: flex; justify-content: space-between; font-size: 24px; font-weight: 700;">
					<span>Grand Total</span> <span style="color: #22c55e;"> ₹<%=total + 75%></span>
				</div>
				<a href="checkOut.jsp"
					style="display: block; margin-top: 30px; text-align: center; padding: 16px; border-radius: 50px; background: linear-gradient(135deg, #ff6b35, #ec4899); color: white; font-weight: 700; font-size: 18px;">
					Proceed to Checkout → </a>
			</div>

			<%
			}
			%>

		</div>

	</div>

	<%
    StringBuilder initJson = new StringBuilder("[");
    double initTotal = 0;
    int initCount = 0;
    if (cart != null && cart.getItems() != null) {
        boolean f = true;
        for (CartItems ci : cart.getItems().values()) {
            if (!f) initJson.append(",");
            f = false;
            String ciName = (ci.getName() != null && !ci.getName().trim().isEmpty()) ? ci.getName() : "Food Item #" + ci.getMenuId();
            double ciPrice = ci.getPrice();
            int ciQty = ci.getQuantity() > 0 ? ci.getQuantity() : 1;
            double sub = ci.getSubTotal();
            initTotal += sub;
            initCount += ciQty;
            String nameEsc = com.tap.CartServlet.escapeJson(ciName);
            String imgEsc = ci.getImagePath() != null ? com.tap.CartServlet.escapeJson(ci.getImagePath()) : "assets/images/paneertikka.png";
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
		<i class="fa-solid fa-bag-shopping"></i> <span>Side Cart</span> 
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
						<button type="button" onclick="clearCart()"
							style="flex: 1; padding: 12px 18px; border-radius: 50px; border: 1px solid rgba(239, 68, 68, 0.3); background: rgba(239, 68, 68, 0.12); color: #ef4444; font-size: 14px; font-weight: 700; cursor: pointer; transition: 0.2s;"
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
        items: <%= initJson.toString() %>,
        subtotal: <%= initTotal %>,
        totalCount: <%= initCount %>,
        deliveryFee: <%= initDelivery %>,
        gst: <%= initGst %>,
        grandTotal: <%= initGrand %>
    };

    const continueUrlStr = "<%=continueUrl%>";

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
        const titleCount = document.getElementById('sideCartTitleCount');
        const subtotalEl = document.getElementById('sideCartSubtotal');
        const grandTotalEl = document.getElementById('sideCartGrandTotal');
        const footerEl = document.getElementById('sideCartFooter');
        const mainCartLayout = document.getElementById('mainCartLayoutContainer');

        // 1. Render Main Cart Page Grid
        if (mainCartLayout) {
            if (!data || !data.items || data.items.length === 0) {
                mainCartLayout.innerHTML = '<div class="empty-cart" style="grid-column: 1/-1; text-align: center; padding: 80px; background: #171b25; border-radius: 25px;">'
                    + '<div style="font-size: 90px;">🛒</div>'
                    + '<h2 style="margin: 20px 0;">Your Cart is Empty</h2>'
                    + '<p style="color: #bbb; margin-bottom: 30px;">Looks like you haven\'t added anything yet.</p>'
                    + '<a href="' + continueUrlStr + '" class="continue-btn">Browse Restaurants</a>'
                    + '</div>';
            } else {
                let mainItemsHtml = '<div class="cart-items">';
                data.items.forEach(item => {
                    const itemSubtotal = (item.price * item.quantity).toFixed(2);
                    mainItemsHtml += '<div class="cart-card" style="display: grid; grid-template-columns: 170px 1fr 180px; gap: 25px; background: #171b25; padding: 22px; border-radius: 22px; margin-bottom: 22px; border: 1px solid rgba(255, 255, 255, .06);">'
                        + '<img src="' + item.imagePath + '" style="width: 170px; height: 140px; object-fit: cover; border-radius: 18px;" onerror="this.onerror=null; this.src=\'assets/images/paneertikka.png\';">'
                        + '<div class="details">'
                        + '<h2 style="margin-bottom: 10px;">' + item.name + '</h2>'
                        + '<p style="color: #aaa;">Freshly prepared by our restaurant and delivered hot.</p>'
                        + '<div style="margin-top: 15px; font-size: 24px; color: #22c55e; font-weight: 700;">₹' + item.price.toFixed(2) + '</div>'
                        + '<div style="margin-top: 10px; color: #bbb;">Subtotal : ₹' + itemSubtotal + '</div>'
                        + '</div>'
                        + '<div class="actions" style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 18px;">'
                        + '<div style="display: flex; align-items: center; background: #242b39; padding: 8px; border-radius: 40px;">'
                        + '<button type="button" onclick="updateCartItem(' + item.menuId + ', ' + item.restaurantId + ', ' + (item.quantity - 1) + ')" style="width: 40px; height: 40px; border: none; border-radius: 50%; background: #ff6b35; color: white; font-size: 20px; cursor: pointer;">-</button>'
                        + '<span style="padding: 0 18px; font-size: 20px; font-weight: 700;">' + item.quantity + '</span>'
                        + '<button type="button" onclick="updateCartItem(' + item.menuId + ', ' + item.restaurantId + ', ' + (item.quantity + 1) + ')" style="width: 40px; height: 40px; border: none; border-radius: 50%; background: #ff6b35; color: white; font-size: 20px; cursor: pointer;">+</button>'
                        + '</div>'
                        + '<button type="button" onclick="deleteCartItem(' + item.menuId + ', ' + item.restaurantId + ')" style="padding: 12px 24px; border: none; border-radius: 40px; background: #ef4444; color: white; font-weight: 700; cursor: pointer;">🗑 Remove</button>'
                        + '</div>'
                        + '</div>';
                });
                mainItemsHtml += '</div>';

                const summaryHtml = '<div class="summary" style="background: #171b25; padding: 28px; border-radius: 22px; height: max-content; border: 1px solid rgba(255, 255, 255, .06);">'
                    + '<h2 style="margin-bottom: 25px;">Order Summary</h2>'
                    + '<div style="display: flex; justify-content: space-between; margin: 15px 0;">'
                    + '<span>Items Total</span> <span>₹' + data.subtotal.toFixed(2) + '</span>'
                    + '</div>'
                    + '<div style="display: flex; justify-content: space-between; margin: 15px 0;">'
                    + '<span>Delivery Charge</span> <span>₹40.00</span>'
                    + '</div>'
                    + '<div style="display: flex; justify-content: space-between; margin: 15px 0;">'
                    + '<span>GST</span> <span>₹35.00</span>'
                    + '</div>'
                    + '<div style="display: flex; justify-content: space-between; margin: 15px 0;">'
                    + '<span>Discount</span> <span style="color: #22c55e;">- ₹0.00</span>'
                    + '</div>'
                    + '<hr style="margin: 20px 0; border-color: rgba(255, 255, 255, .08);">'
                    + '<div style="display: flex; justify-content: space-between; font-size: 24px; font-weight: 700;">'
                    + '<span>Grand Total</span> <span style="color: #22c55e;"> ₹' + data.grandTotal.toFixed(2) + '</span>'
                    + '</div>'
                    + '<a href="checkOut.jsp" style="display: block; margin-top: 30px; text-align: center; padding: 16px; border-radius: 50px; background: linear-gradient(135deg, #ff6b35, #ec4899); color: white; font-weight: 700; font-size: 18px; text-decoration: none;">'
                    + 'Proceed to Checkout →'
                    + '</a>'
                    + '</div>';
                mainCartLayout.innerHTML = mainItemsHtml + summaryHtml;
            }
        }

        // 2. Render Side Cart Drawer UI
        if (!data || !data.items || data.items.length === 0) {
            if (container) {
                container.innerHTML = '<div class="cart-empty-state">'
                    + '<i class="fa-solid fa-basket-shopping empty-icon"></i>'
                    + '<p>Your cart is empty!</p>'
                    + '<span>Tap "Add to Cart" on any menu item to start ordering tasty food.</span>'
                    + '</div>';
            }
            if (badge) badge.innerText = "0";
            if (titleCount) titleCount.innerText = "(0)";
            if (subtotalEl) subtotalEl.innerText = "₹0.00";
            if (grandTotalEl) grandTotalEl.innerText = "₹0.00";
            if (footerEl) footerEl.style.display = "none";
            return;
        }

        if (badge) badge.innerText = data.totalCount;
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
                + 'Price: <strong style="color: #ff5a36; font-size: 14px;">₹' + item.price.toFixed(2) + '</strong>'
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
    });
	</script>
<script src="app.js"></script>
</body>
</html>

