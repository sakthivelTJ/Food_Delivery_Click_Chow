<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.user, com.tap.model.order_table, com.tap.model.order_item, com.tap.model.Menu, com.tap.model.Restaurant"%>
<%@ page import="com.tap.daoIMP.order_tableDAOIMP, com.tap.daoIMP.orderItemDAOIMP, com.tap.daoIMP.MenuDAOImp, com.tap.daoIMP.RestaurantDAOImp, com.tap.daoIMP.userDAOImp"%>
<%@ page import="java.util.List, java.util.Set, java.util.HashSet"%>
<%
    user deliveryUser = (user) session.getAttribute("deliveryUser");
    if (deliveryUser == null) {
        deliveryUser = (user) session.getAttribute("loggedInUser");
    }
    if (deliveryUser == null) {
        response.sendRedirect("deliveryLogin.jsp");
        return;
    }

    order_tableDAOIMP orderDAO = new order_tableDAOIMP();
    orderItemDAOIMP orderItemDAO = new orderItemDAOIMP();
    MenuDAOImp menuDAO = new MenuDAOImp();
    RestaurantDAOImp restaurantDAO = new RestaurantDAOImp();
    userDAOImp userDAO = new userDAOImp();

    @SuppressWarnings("unchecked")
    Set<Integer> declinedOrders = (Set<Integer>) session.getAttribute("declinedOrders");
    if (declinedOrders == null) {
        declinedOrders = new HashSet<>();
    }

    List<order_table> allOrders = orderDAO.getAllOrder();
    order_table activeOrder = null;
    int completedCount = 0;
    double totalEarnings = 0;

    // Determine active order and stats
    Integer activeOrderIdAttr = (Integer) session.getAttribute("activeOrderId");
    
    if (allOrders != null) {
        for (order_table o : allOrders) {
            String st = o.getStatus();
            if ("Delivered".equalsIgnoreCase(st)) {
                completedCount++;
                totalEarnings += (o.getTotalAmount() * 0.15); // 15% partner commission
            } else if ("Out for Delivery".equalsIgnoreCase(st) || "In Transit".equalsIgnoreCase(st) || "Accepted".equalsIgnoreCase(st)) {
                if (activeOrderIdAttr != null && o.getOrderID() == activeOrderIdAttr) {
                    activeOrder = o;
                } else if (activeOrder == null) {
                    activeOrder = o;
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Delivery Partner App</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="deliveryApp.css">

    <style>
        .badge-pill {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 800;
            text-transform: uppercase;
        }
        .badge-pending { background: rgba(245, 158, 11, 0.18); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-transit { background: rgba(59, 130, 246, 0.18); color: #60a5fa; border: 1px solid rgba(59, 130, 246, 0.3); }
        .badge-delivered { background: rgba(16, 185, 129, 0.18); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3); }
        
        .customer-phone-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(59, 130, 246, 0.15);
            color: #60a5fa;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 13px;
            margin-top: 6px;
        }
    </style>
</head>
<body>

<!-- Partner App Sticky Header -->
<div class="app-header">
    <div class="brand-title">
        🚴 <span>Click Chow Partner</span>
    </div>
    
    <button id="dutyToggleBtn" onclick="toggleDutyStatus()" class="duty-switch" style="cursor: pointer; background: rgba(16, 185, 129, 0.12); border: 1px solid rgba(16, 185, 129, 0.3); outline: none; transition: 0.3s;">
        <div class="duty-dot" id="dutyDot"></div>
        <span id="dutyLabel" style="font-weight: 800; font-size: 13px; color: #10b981; letter-spacing: 0.5px;">ON DUTY (ONLINE)</span>
    </button>

    <div style="display: flex; align-items: center; gap: 15px;">
        <span style="font-weight: 700; font-size: 14px; color: #fff;">👋 <%= deliveryUser.getUser_name() %></span>
        <a href="AdminLogoutServlet" style="color: var(--primary); font-weight: 800; font-size: 13px; background: rgba(255,90,54,0.15); padding: 6px 14px; border-radius: 20px; border: 1px solid rgba(255,90,54,0.3);">Logout</a>
    </div>
</div>

<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
<div class="top-back-bar">
    <a href="deliveryLogin.jsp" class="btn-back-nav" id="backToDeliveryLoginBtn">
        <i class="fa-solid fa-arrow-left"></i> <span>Delivery Login</span>
    </a>
</div>

<div class="app-container">


    <!-- Flash Alerts -->
    <%
        String deliveryMsg = (String) session.getAttribute("deliveryMsg");
        String deliveryError = (String) session.getAttribute("deliveryError");
        if (deliveryMsg != null) {
    %>
        <div style="background: rgba(16,185,129,0.15); border: 1px solid rgba(16,185,129,0.3); color: #34d399; padding: 16px; border-radius: 16px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; font-weight: 600;">
            <span>✅ <%= deliveryMsg %></span>
            <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:18px;">✕</button>
        </div>
    <%
            session.removeAttribute("deliveryMsg");
        }
        if (deliveryError != null) {
    %>
        <div style="background: rgba(239,68,68,0.15); border: 1px solid rgba(239,68,68,0.3); color: #f87171; padding: 16px; border-radius: 16px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center; font-weight: 600;">
            <span>⚠️ <%= deliveryError %></span>
            <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:18px;">✕</button>
        </div>
    <%
            session.removeAttribute("deliveryError");
        }
    %>

    <!-- Partner Earnings Bar -->
    <div class="agent-stats">
        <div class="stat-box">
            <div class="stat-icon" style="background: rgba(16,185,129,0.15); color: #34d399;">💰</div>
            <div>
                <h3 style="font-size: 24px; font-weight: 800;">₹<%= String.format("%.2f", totalEarnings > 0 ? totalEarnings : 240.00) %></h3>
                <p style="color: var(--text-muted); font-size: 13px; font-weight: 600;">Today's Earnings</p>
            </div>
        </div>
        <div class="stat-box">
            <div class="stat-icon" style="background: rgba(59,130,246,0.15); color: #60a5fa;">📦</div>
            <div>
                <h3 style="font-size: 24px; font-weight: 800;"><%= completedCount %></h3>
                <p style="color: var(--text-muted); font-size: 13px; font-weight: 600;">Completed Deliveries</p>
            </div>
        </div>
        <div class="stat-box">
            <div class="stat-icon" style="background: rgba(245,158,11,0.15); color: #fbbf24;">⚡</div>
            <div>
                <h3 style="font-size: 24px; font-weight: 800;">100%</h3>
                <p style="color: var(--text-muted); font-size: 13px; font-weight: 600;">Acceptance Rate</p>
            </div>
        </div>
    </div>

    <!-- Navigation Tabs -->
    <div class="tab-navigation">
        <button class="tab-btn <%= activeOrder == null ? "active" : "" %>" onclick="switchTab('available')">
            📡 Available Orders 
            <% 
                int availCount = 0;
                if (allOrders != null) {
                    for (order_table o : allOrders) {
                        String st = o.getStatus();
                        if (!declinedOrders.contains(o.getOrderID()) && (st == null || "Pending".equalsIgnoreCase(st) || "Processing".equalsIgnoreCase(st))) {
                            availCount++;
                        }
                    }
                }
            %>
            <span class="tab-badge"><%= availCount %></span>
        </button>

        <button class="tab-btn <%= activeOrder != null ? "active" : "" %>" onclick="switchTab('active')">
            🚴 Active Delivery
            <% if (activeOrder != null) { %>
                <span class="tab-badge" style="background: #10b981; color: white;">1 ACTIVE</span>
            <% } %>
        </button>

        <button class="tab-btn" onclick="switchTab('completed')">
            📋 Completed History
        </button>
    </div>

    <!-- TAB 1: AVAILABLE CUSTOMER ORDERS FEED -->
    <div id="tab-available" style="display: <%= activeOrder == null ? "block" : "none" %>;">
        <div style="margin-bottom: 18px; display: flex; justify-content: space-between; align-items: center;">
            <h2 style="font-size: 20px; font-weight: 800;">Placed Customer Orders</h2>
            <span style="font-size: 13px; color: var(--text-muted);">Real-time Live Orders</span>
        </div>

        <div class="order-card-grid">
            <% 
                boolean foundAvailable = false;
                if (allOrders != null) {
                    for (order_table o : allOrders) {
                        String st = o.getStatus();
                        if (declinedOrders.contains(o.getOrderID())) {
                            continue;
                        }
                        if (st == null || "Pending".equalsIgnoreCase(st) || "Processing".equalsIgnoreCase(st)) {
                            foundAvailable = true;
                            Restaurant rest = restaurantDAO.getRestaurant(o.getRestaurantID());
                            user cust = userDAO.getUser(o.getUserID());
                            String restName = (rest != null) ? rest.getName() : "Restaurant #" + o.getRestaurantID();
                            String restAddress = (rest != null && rest.getAddress() != null) ? rest.getAddress() : "Main Kitchen, Food Street";
                            String custName = (cust != null && cust.getUser_name() != null) ? cust.getUser_name() : "Customer #" + o.getUserID();
                            String rawCustAddress = (cust != null && cust.getAddress() != null) ? cust.getAddress() : "Customer Address";
                            String custEmail = (cust != null && cust.getEmail() != null) ? cust.getEmail() : "";
                            
                            String custPhone = "";
                            String custAddress = rawCustAddress;
                            if (rawCustAddress.contains(" | Phone: ")) {
                                String[] parts = rawCustAddress.split(" \\| Phone: ");
                                custAddress = parts[0];
                                custPhone = parts.length > 1 ? parts[1] : "";
                            } else if (rawCustAddress.contains("Phone:")) {
                                int idx = rawCustAddress.indexOf("Phone:");
                                custAddress = rawCustAddress.substring(0, idx).trim();
                                custPhone = rawCustAddress.substring(idx + 6).trim();
                            }
            %>
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <span class="order-tag" style="background: rgba(16, 185, 129, 0.15); color: #34d399;">PLACED BY USER</span>
                            <h3 style="font-size: 22px; font-weight: 800; margin-top: 4px;">Order #ORD-<%= o.getOrderID() %></h3>
                        </div>
                        <div style="text-align: right;">
                            <span style="font-size: 22px; font-weight: 800; color: #34d399;">₹<%= String.format("%.2f", o.getTotalAmount()) %></span>
                            <p style="font-size: 12px; color: var(--text-muted); margin-top: 2px;">Payment: <strong><%= o.getPaymentMethod() != null ? o.getPaymentMethod() : "Paid Online" %></strong></p>
                        </div>
                    </div>

                    <div class="location-box">
                        <div class="location-row">
                            <div class="location-icon">🏬</div>
                            <div>
                                <div class="location-title" style="color: var(--primary);">PICKUP RESTAURANT</div>
                                <div class="location-name"><%= restName %></div>
                                <div class="location-address"><%= restAddress %></div>
                            </div>
                        </div>

                        <div style="border-top: 1px dashed var(--border);"></div>

                        <div class="location-row">
                            <div class="location-icon">👤</div>
                            <div>
                                <div class="location-title" style="color: #34d399;">CUSTOMER DETAILS (CHECKOUT FORM)</div>
                                <div class="location-name"><%= custName %> <% if (!custEmail.isEmpty()) { %><span style="font-size:12px; color:var(--text-muted); font-weight:normal;">(<%= custEmail %>)</span><% } %></div>
                                <div class="location-address">📍 <strong>Address:</strong> <%= custAddress %></div>
                                <% if (!custPhone.isEmpty()) { %>
                                    <a href="tel:<%= custPhone %>" class="customer-phone-link">📞 <%= custPhone %></a>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <!-- TAKE ORDER BUTTON -->
                    <div class="card-actions" style="grid-template-columns: 1fr;">
                        <form action="DeliveryOrderServlet" method="post" style="width: 100%;">
                            <input type="hidden" name="action" value="take">
                            <input type="hidden" name="orderId" value="<%= o.getOrderID() %>">
                            <button type="submit" class="btn-card-accept" style="width: 100%; font-size: 16px; padding: 16px; background: linear-gradient(135deg, #ff5a36, #ec4899);">
                                🚴 TAKE ORDER & VIEW DETAILS
                            </button>
                        </form>
                    </div>
                </div>
            <% 
                        }
                    }
                }
                if (!foundAvailable) {
            %>
                <div class="tracker-card" style="text-align: center; padding: 50px 20px;">
                    <div style="width: 70px; height: 70px; border-radius: 50%; background: rgba(255,90,54,0.12); border: 2px solid var(--primary); display: flex; align-items: center; justify-content: center; font-size: 30px; margin: 0 auto 18px;">
                        📦
                    </div>
                    <h3 style="font-size: 20px; font-weight: 800;">No Pending Customer Orders</h3>
                    <p style="color: var(--text-muted); margin-top: 8px; font-size: 14px;">
                        Orders placed by customers during checkout will automatically appear here in orderly sequence with a Take Order button.
                    </p>
                </div>
            <% } %>
        </div>
    </div>

    <!-- TAB 2: ACTIVE ACCEPTED DELIVERY DETAILS PAGE -->
    <div id="tab-active" style="display: <%= activeOrder != null ? "block" : "none" %>;">
        <% if (activeOrder != null) { 
            Restaurant rest = restaurantDAO.getRestaurant(activeOrder.getRestaurantID());
            user customer = userDAO.getUser(activeOrder.getUserID());
            String restName = (rest != null) ? rest.getName() : "Restaurant #" + activeOrder.getRestaurantID();
            String restAddress = (rest != null && rest.getAddress() != null) ? rest.getAddress() : "Main Food Hub, Station Road";
            
            String custName = (customer != null && customer.getUser_name() != null) ? customer.getUser_name() : "Customer #" + activeOrder.getUserID();
            String rawCustAddress = (customer != null && customer.getAddress() != null) ? customer.getAddress() : "Customer Address";
            String custEmail = (customer != null && customer.getEmail() != null) ? customer.getEmail() : "N/A";
            
            String custPhone = "";
            String custAddress = rawCustAddress;
            if (rawCustAddress.contains(" | Phone: ")) {
                String[] parts = rawCustAddress.split(" \\| Phone: ");
                custAddress = parts[0];
                custPhone = parts.length > 1 ? parts[1] : "";
            } else if (rawCustAddress.contains("Phone:")) {
                int idx = rawCustAddress.indexOf("Phone:");
                custAddress = rawCustAddress.substring(0, idx).trim();
                custPhone = rawCustAddress.substring(idx + 6).trim();
            }
            
            String status = activeOrder.getStatus() != null ? activeOrder.getStatus() : "Accepted";
            List<order_item> orderItems = orderItemDAO.getOrderItemsByOrderId(activeOrder.getOrderID());
        %>

            <div class="tracker-card">
                <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border); padding-bottom: 18px; margin-bottom: 20px;">
                    <div>
                        <span style="font-size: 12px; color: var(--primary); font-weight: 800; letter-spacing: 1px; text-transform: uppercase;">CURRENT ACCEPTED ORDER</span>
                        <h2 style="font-size: 28px; font-weight: 800; margin-top: 2px;">Order #ORD-<%= activeOrder.getOrderID() %></h2>
                    </div>
                    <span class="badge-pill badge-transit" style="font-size: 14px; padding: 8px 18px;">
                        <%= status %>
                    </span>
                </div>

                <!-- Step Progress Timeline -->
                <div class="progress-steps">
                    <div class="progress-line"></div>
                    <div class="progress-line-active" style="width: <%= "Delivered".equalsIgnoreCase(status) ? "100%" : ("Out for Delivery".equalsIgnoreCase(status) ? "66%" : "33%") %>;"></div>

                    <div class="step-item completed">
                        <div class="step-node">✓</div>
                        <div class="step-label">Accepted</div>
                    </div>

                    <div class="step-item <%= ("Out for Delivery".equalsIgnoreCase(status) || "In Transit".equalsIgnoreCase(status)) ? "active" : "" %>">
                        <div class="step-node">📦</div>
                        <div class="step-label">Picked Up</div>
                    </div>

                    <div class="step-item <%= "Delivered".equalsIgnoreCase(status) ? "completed" : "" %>">
                        <div class="step-node">🏁</div>
                        <div class="step-label">Delivered</div>
                    </div>
                </div>

                <!-- FULL RESTAURANT & CUSTOMER DETAILS -->
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 16px; margin-bottom: 25px;">
                    
                    <!-- Pickup Restaurant Card -->
                    <div style="background: rgba(18,22,32,0.9); border: 1px solid var(--border); border-radius: 18px; padding: 20px;">
                        <div style="display: flex; gap: 12px; align-items: center; margin-bottom: 12px;">
                            <div style="font-size: 26px;">🏬</div>
                            <div>
                                <span style="font-size: 11px; color: var(--primary); font-weight: 800; text-transform: uppercase;">PICKUP FROM</span>
                                <h4 style="font-size: 18px; font-weight: 800; color: #fff;"><%= restName %></h4>
                            </div>
                        </div>
                        <p style="color: var(--text-muted); font-size: 14px;">📍 <%= restAddress %></p>
                    </div>

                    <!-- Customer Delivery Card -->
                    <div style="background: rgba(18,22,32,0.9); border: 1px solid var(--border); border-radius: 18px; padding: 20px;">
                        <div style="display: flex; gap: 12px; align-items: center; margin-bottom: 12px;">
                            <div style="font-size: 26px;">🏡</div>
                            <div>
                                <span style="font-size: 11px; color: #34d399; font-weight: 800; text-transform: uppercase;">DELIVER TO CUSTOMER</span>
                                <h4 style="font-size: 18px; font-weight: 800; color: #fff;"><%= custName %></h4>
                            </div>
                        </div>
                        <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 4px;">📍 <strong>Address:</strong> <%= custAddress %></p>
                        <p style="color: var(--text-muted); font-size: 14px; margin-bottom: 8px;">📧 <strong>Email:</strong> <%= custEmail %></p>
                        <% if (!custPhone.isEmpty()) { %>
                            <a href="tel:<%= custPhone %>" class="customer-phone-link">📞 Call Customer (<%= custPhone %>)</a>
                        <% } %>
                    </div>

                </div>

                <!-- ITEMIZED FOOD ORDER LIST (ITEM DETAILS) -->
                <div class="food-items-card">
                    <div class="food-items-header">
                        <h4 style="font-size: 16px; font-weight: 800; color: #fff;">🍔 Food Items Ordered (<%= orderItems != null ? orderItems.size() : 0 %>)</h4>
                        <span style="font-size: 13px; color: var(--text-muted);">Payment: <strong style="color: #fff;"><%= activeOrder.getPaymentMethod() != null ? activeOrder.getPaymentMethod() : "Prepaid" %></strong></span>
                    </div>

                    <% if (orderItems != null && !orderItems.isEmpty()) {
                        for (order_item item : orderItems) {
                            Menu menuItem = menuDAO.getMenu(item.getMenuID());
                            String itemName = (menuItem != null) ? menuItem.getItemName() : "Item #" + item.getMenuID();
                    %>
                        <div class="food-item-row">
                            <div style="display: flex; align-items: center;">
                                <span class="item-qty-badge"><%= item.getQuantity() %>x</span>
                                <span style="font-weight: 700; color: #fff; font-size: 15px;"><%= itemName %></span>
                            </div>
                            <span style="font-weight: 700; color: var(--text-muted); font-size: 15px;">₹<%= String.format("%.2f", item.getItemTotal()) %></span>
                        </div>
                    <%  }
                       } else { %>
                        <p style="color: var(--text-muted); padding: 10px 0; font-size: 14px;">Order details available on receipt.</p>
                    <% } %>

                    <div style="border-top: 1px solid var(--border); margin-top: 12px; padding-top: 12px; display: flex; justify-content: space-between; align-items: center;">
                        <span style="font-weight: 800; font-size: 16px;">Total Bill Amount</span>
                        <span style="font-weight: 800; font-size: 20px; color: #34d399;">₹<%= String.format("%.2f", activeOrder.getTotalAmount()) %></span>
                    </div>
                </div>

                <!-- FULFILLMENT ACTION BUTTON -->
                <form action="DeliveryOrderServlet" method="post">
                    <input type="hidden" name="orderId" value="<%= activeOrder.getOrderID() %>">
                    
                    <% if (!"Out for Delivery".equalsIgnoreCase(status) && !"In Transit".equalsIgnoreCase(status)) { %>
                        <input type="hidden" name="action" value="pickup">
                        <button type="submit" class="btn-action-orange">📦 Mark as Picked Up Food from Restaurant</button>
                    <% } else { %>
                        <input type="hidden" name="action" value="deliver">
                        <button type="submit" class="btn-action-primary">✅ Mark Order as Delivered to Customer</button>
                    <% } %>
                </form>
            </div>

        <% } else { %>

            <div class="tracker-card" style="text-align: center; padding: 45px 20px;">
                <p style="color: var(--text-muted); font-size: 16px;">No active order currently accepted. Switch to <strong>Available Orders</strong> tab to accept new deliveries!</p>
                <button class="btn-action-orange" style="width: auto; margin: 20px auto 0; padding: 12px 28px;" onclick="switchTab('available')">View Available Orders Feed ↗</button>
            </div>

        <% } %>
    </div>

    <!-- TAB 3: COMPLETED DELIVERIES HISTORY -->
    <div id="tab-completed" style="display: none;">
        <div class="tracker-card">
            <h2 style="font-size: 22px; font-weight: 800; margin-bottom: 20px;">Your Completed Deliveries</h2>

            <table class="past-deliveries-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Restaurant</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Earning</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        boolean hasDelivered = false;
                        if (allOrders != null) {
                            for (order_table o : allOrders) {
                                if ("Delivered".equalsIgnoreCase(o.getStatus())) {
                                    hasDelivered = true;
                                    Restaurant rest = restaurantDAO.getRestaurant(o.getRestaurantID());
                                    String restName = (rest != null) ? rest.getName() : "Rest #" + o.getRestaurantID();
                    %>
                        <tr>
                            <td><strong>#ORD-<%= o.getOrderID() %></strong></td>
                            <td style="color: #fff; font-weight: 700;"><%= restName %></td>
                            <td style="color: var(--text-muted); font-size: 13px;"><%= o.getOrderDate() %></td>
                            <td style="font-weight: 700; color: #fff;">₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                            <td style="color: #34d399; font-weight: 800;">₹<%= String.format("%.2f", o.getTotalAmount() * 0.15) %></td>
                            <td><span class="badge-pill badge-delivered">Delivered ✅</span></td>
                        </tr>
                    <% 
                                }
                            }
                        }
                        if (!hasDelivered) {
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--text-muted); padding: 30px;">
                                No completed deliveries recorded yet for today.
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</div>

<script type="text/javascript">
    let isPartnerOnline = true;
    const hasActiveOrder = <%= activeOrder != null ? "true" : "false" %>;

    function toggleDutyStatus() {
        isPartnerOnline = !isPartnerOnline;
        const btn = document.getElementById('dutyToggleBtn');
        const dot = document.getElementById('dutyDot');
        const label = document.getElementById('dutyLabel');
        const availableTab = document.getElementById('tab-available');

        if (isPartnerOnline) {
            btn.style.background = 'rgba(16, 185, 129, 0.12)';
            btn.style.borderColor = 'rgba(16, 185, 129, 0.3)';
            dot.style.background = '#10b981';
            dot.style.boxShadow = '0 0 10px #10b981';
            label.innerText = 'ON DUTY (ONLINE)';
            label.style.color = '#10b981';
            
            // Poll immediately when going online
            pollLiveOrders();
        } else {
            btn.style.background = 'rgba(239, 68, 68, 0.12)';
            btn.style.borderColor = 'rgba(239, 68, 68, 0.3)';
            dot.style.background = '#ef4444';
            dot.style.boxShadow = 'none';
            label.innerText = 'OFF DUTY (OFFLINE)';
            label.style.color = '#f87171';
        }
    }

    function switchTab(tabName) {
        document.getElementById('tab-available').style.display = 'none';
        document.getElementById('tab-active').style.display = 'none';
        document.getElementById('tab-completed').style.display = 'none';

        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));

        if (tabName === 'available') {
            document.getElementById('tab-available').style.display = 'block';
            if (event) event.currentTarget.classList.add('active');
        } else if (tabName === 'active') {
            document.getElementById('tab-active').style.display = 'block';
            if (event) event.currentTarget.classList.add('active');
        } else if (tabName === 'completed') {
            document.getElementById('tab-completed').style.display = 'block';
            if (event) event.currentTarget.classList.add('active');
        }
    }

    function pollLiveOrders() {
        if (!isPartnerOnline || hasActiveOrder) return;

        fetch('DeliveryOrderServlet?action=fetchNewOrder')
            .then(res => res.json())
            .then(data => {
                if (data && data.hasOrder) {
                    // Check if new order is detected and reload feed if on available tab
                    const currentCards = document.querySelectorAll('.order-card').length;
                    if (currentCards === 0) {
                        location.reload();
                    }
                }
            })
            .catch(err => console.log('Polling check:', err));
    }

    // Auto-poll every 4 seconds when partner is ON DUTY
    setInterval(pollLiveOrders, 4000);
</script>

</body>
</html>
