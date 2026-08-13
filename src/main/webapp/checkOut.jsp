<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page
	import="com.tap.model.user,com.tap.model.Carts,com.tap.model.CartItems , com.tap.model.Menu,java.util.List"%>
	
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Checkout | Click Chow</title>
<!-- Web Favicon -->
<link rel="icon" href="assets/images/icon.png">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;0,800;1,600&display=swap" rel="stylesheet" />
<!-- FontAwesome for Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="index.css" />


<style>
    /*=================================================
                GLOBAL STYLES & HEADER REUSE
    ==================================================*/
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Outfit', sans-serif;
    }

    body {
        background: #090b12; /* Dark theme background */
        color: #fff;
    }

    .gradient-text {
        background: linear-gradient(135deg, #ff5a36, #ec4899);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    /* Header matching your project style */
    .header {
        background: rgba(26, 31, 44, .96);
        backdrop-filter: blur(18px);
        border-bottom: 1px solid rgba(255, 255, 255, .08);
        padding: 20px 5%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .logo {
        color: #fff;
        font-size: 24px;
        font-weight: 800;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .logo span {
        color: #ff5a36;
    }

    /*=================================================
                CHECKOUT SECTION STYLES
    ==================================================*/
    .checkout-wrapper {
        max-width: 1200px;
        margin: 50px auto;
        padding: 0 20px;
    }

    .checkout-title {
        font-size: 36px;
        margin-bottom: 30px;
        font-weight: 800;
        letter-spacing: -.5px;
    }

    .checkout-grid {
        display: grid;
        grid-template-columns: 1.5fr 1fr;
        gap: 30px;
    }

    /*================ CARDS =================*/
    .checkout-card {
        background: #181d2b;
        border: 1px solid rgba(255, 255, 255, .08);
        border-radius: 24px;
        padding: 30px;
        box-shadow: 0 15px 40px rgba(0, 0, 0, .35);
    }

    .checkout-card h3 {
        font-size: 24px;
        margin-bottom: 25px;
        padding-bottom: 15px;
        border-bottom: 1px solid rgba(255, 255, 255, .08);
    }

    /*================ FORM ELEMENTS =================*/
    .form-row {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }

    .form-group {
        flex: 1;
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #b3b9c7;
        font-size: 15px;
        font-weight: 500;
    }

    .form-control {
        width: 100%;
        padding: 15px 18px;
        background: #232938;
        border: 1px solid rgba(255, 255, 255, .1);
        border-radius: 12px;
        color: #fff;
        font-size: 16px;
        outline: none;
        transition: .3s ease;
    }

    .form-control:focus {
        border-color: #ff5a36;
        box-shadow: 0 0 15px rgba(255, 90, 54, .15);
    }

    textarea.form-control {
        resize: vertical;
        min-height: 100px;
    }

    /*================ PAYMENT METHODS =================*/
    .payment-methods {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .payment-option {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 18px;
        background: #232938;
        border: 1px solid rgba(255, 255, 255, .1);
        border-radius: 12px;
        cursor: pointer;
        transition: .3s;
    }

    .payment-option:hover {
        border-color: #ec4899;
    }

    .payment-option input[type="radio"] {
        accent-color: #ff5a36;
        width: 18px;
        height: 18px;
        cursor: pointer;
    }

    .payment-option label {
        color: #fff;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .payment-option label i {
        color: #ff5a36;
        font-size: 20px;
    }

    /*================ ORDER SUMMARY =================*/
    .order-items-list {
        margin-bottom: 25px;
    }

    .order-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 0;
        border-bottom: 1px solid rgba(255, 255, 255, .08);
    }

    .order-item-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .order-item-img {
        width: 60px;
        height: 60px;
        border-radius: 12px;
        background: #232938;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px;
        color: #ff5a36;
    }

    .order-item-details h4 {
        font-size: 16px;
        color: #fff;
        margin-bottom: 4px;
    }

    .order-item-details p {
        font-size: 14px;
        color: #9ea8bc;
    }

    .order-item-price {
        font-weight: 700;
        color: #fff;
        font-size: 16px;
    }

    /*================ TOTALS =================*/
    .order-totals {
        margin-bottom: 25px;
    }

    .total-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 15px;
        color: #b3b9c7;
        font-size: 15px;
    }

    .total-row.grand-total {
        color: #fff;
        font-size: 22px;
        font-weight: 800;
        border-top: 1px solid rgba(255, 255, 255, .08);
        padding-top: 20px;
        margin-top: 10px;
    }

    .total-row.grand-total span:last-child {
        color: #ff5a36;
    }

    /*================ BUTTON =================*/
    .place-order-btn {
        width: 100%;
        padding: 18px;
        border-radius: 50px;
        background: linear-gradient(135deg, #ff5a36, #ec4899);
        color: #fff;
        font-size: 18px;
        font-weight: 700;
        border: none;
        cursor: pointer;
        transition: .35s;
        box-shadow: 0 10px 25px rgba(255, 90, 54, .30);
    }

    .place-order-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 30px rgba(255, 90, 54, .45);
        background: linear-gradient(135deg, #ff6838, #ff3d87);
    }

    /*================ RESPONSIVE =================*/
    @media (max-width: 992px) {
        .checkout-grid {
            grid-template-columns: 1fr;
        }
    }
    @media (max-width: 650px) {
        .form-row {
            flex-direction: column;
            gap: 0;
        }
    }
</style>
</head>
<body>

    <!-- Header -->
    <header class="header">
        <a href="logoLogout" onclick="localStorage.clear(); sessionStorage.clear();" class="logo">
            <span class="logo-icon"><i class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
        </a>
        <div style="color: #fff; font-weight: 600;">
            <i class="fa-solid fa-lock" style="color: #ff5a36; margin-right: 5px;"></i> Secure Checkout
        </div>
    </header>

    <!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
    <div class="top-back-bar">
        <a href="cart.jsp" class="btn-back-nav" id="backToCartBtn">
            <i class="fa-solid fa-arrow-left"></i> <span>Cart</span>
        </a>
    </div>

    <!-- Main Checkout Content -->

    <div class="checkout-wrapper">
        <h1 class="checkout-title">Complete Your <span class="gradient-text">Order</span></h1>

        <form action="checkoutServlet" method="POST">
            <div class="checkout-grid">
                
                <!-- LEFT COLUMN: Delivery & Payment Details -->
                <div class="checkout-left">
                    
                    <!-- Billing & Delivery Form -->
                    <div class="checkout-card" style="margin-bottom: 30px;">
                        <h3><i class="fa-solid fa-location-dot" style="color: #ff5a36; margin-right: 10px;"></i> Delivery Details</h3>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="fullName">Full Name</label>
                                <input type="text" id="fullName" name="fullName" class="form-control" placeholder="Enter your full name" required>
                            </div>
                            <div class="form-group">
                                <label for="phone">Phone Number</label>
                                <input type="tel" id="phone" name="phone" class="form-control" placeholder="+91 00000 00000" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="your@email.com" required>
                        </div>

                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="address">Full Delivery Address</label>
                            <textarea id="address" name="address" class="form-control" placeholder="House/Flat No, Street, Landmark, City, Pincode" required></textarea>
                        </div>
                    </div>

                    <!-- Payment Method Selection -->
                    <div class="checkout-card">
                        <h3><i class="fa-solid fa-wallet" style="color: #ff5a36; margin-right: 10px;"></i> Payment Method</h3>
                        
                        <div class="payment-methods">
                            <div class="payment-option">
                                <input type="radio" id="cod" name="paymentMethod" value="COD" checked>
                                <label for="cod">Cash on Delivery <i class="fa-solid fa-money-bill-wave"></i></label>
                            </div>
                            <div class="payment-option">
                                <input type="radio" id="upi" name="paymentMethod" value="UPI">
                                <label for="upi">UPI (GPay, PhonePe, Paytm) <i class="fa-brands fa-google-pay"></i></label>
                            </div>
                            <div class="payment-option">
                                <input type="radio" id="card" name="paymentMethod" value="CARD">
                                <label for="card">Credit / Debit Card <i class="fa-solid fa-credit-card"></i></label>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- RIGHT COLUMN: Order Summary -->
                <div class="checkout-right">
                    <div class="checkout-card" style="position: sticky; top: 100px;">
                        <h3><i class="fa-solid fa-bag-shopping" style="color: #ff5a36; margin-right: 10px;"></i> Order Summary</h3>
                        <div class="order-items-list">
                        
                        <%
                        	Carts cart = (Carts)session.getAttribute("cart");
                        	double total =0;
                        	double gst = 35;
                        	double deliveryChr = 40;
                        	if(cart != null && !cart.getItems().isEmpty()){
                        		for(CartItems item : cart.getItems().values()){
                        			double subtotal = item.getPrice() * item.getQuantity();
                					total += subtotal;
                					
                					
                        %>
                        <!-- List of Purchased Food Items -->
                            <!-- Item 1 -->
                        	
                            <div class="order-item">
                                <div class="order-item-info">
                                    <div class="order-item-img">
                                        <i class="fa-solid fa-burger"></i>
                                    </div>
                                    <div class="order-item-details">
                                        <h4><%=item.getName() %></h4>
                                        <p>Price : <%=item.getPrice() %> | Qty: <%=item.getQuantity() %></p>
                                    </div>
                                </div>
                                <div class="order-item-price">₹<%=item.getPrice() * item.getQuantity() %></div>
                            </div>
                            
                       <%
                        		}
                        	}
                        	else{
                        		 total =0;
                        	}
                        	
                        	double grandTotal = total+gst+deliveryChr;
                        	session.setAttribute("grandTotal", grandTotal);
                        %>
                        
                        
                        
                        

                          

                        <!-- Price Totals -->
                        <div class="order-totals">
                            <div class="total-row">
                                <span>Subtotal</span>
                                <span>₹<%=total %></span>
                            </div>
                            <div class="total-row">
                                <span>Delivery Fee</span>
                                <span style="color: #ff5a36;">₹<%=deliveryChr %></span>
                            </div>
                            <div class="total-row">
                                <span>Taxes & Charges</span>
                                <span>₹<%=gst %></span>
                            </div>
                            <div class="total-row grand-total">
                                <span>Grand Total</span>
                                <span>₹<%=grandTotal  %></span>
                            </div>
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="place-order-btn">
                            Place Order Securely <i class="fa-solid fa-arrow-right" style="margin-left: 8px;"></i>
                        </button>
                    </div>
                </div>

            </div>
        </form>
    </div>

</body>
</html>