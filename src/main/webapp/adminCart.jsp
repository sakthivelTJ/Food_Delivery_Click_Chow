<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.user, com.tap.model.order_table, com.tap.model.order_item, com.tap.model.Restaurant, com.tap.daoIMP.order_tableDAOIMP, com.tap.daoIMP.orderItemDAOIMP, com.tap.daoIMP.userDAOImp, com.tap.daoIMP.RestaurantDAOImp, java.util.List"%>
<%
    user adminUser = (user) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    order_tableDAOIMP orderDAO = new order_tableDAOIMP();
    orderItemDAOIMP orderItemDAO = new orderItemDAOIMP();
    userDAOImp adminUserDAO = new userDAOImp();
    RestaurantDAOImp adminRestDAO = new RestaurantDAOImp();
    List<order_table> orderList = orderDAO.getAllOrder();

    double totalRevenue = 0;
    int pendingCount = 0;
    int deliveredCount = 0;

    if (orderList != null) {
        for (order_table o : orderList) {
            totalRevenue += o.getTotalAmount();
            if ("Pending".equalsIgnoreCase(o.getStatus()) || "Processing".equalsIgnoreCase(o.getStatus())) {
                pendingCount++;
            } else if ("Delivered".equalsIgnoreCase(o.getStatus())) {
                deliveredCount++;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Admin Cart & Orders</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="admin.css">
</head>
<body>

<!-- Admin Navigation Bar -->
<div class="navbar">
    <div class="logo">
        Click Chow <span class="badge">Admin</span>
    </div>
    <div class="nav-links">
        <a href="adminMenu.jsp">Menu & Restaurants</a>
        <a href="adminCart.jsp" class="active">Orders & Carts</a>
        <a href="adminUsers.jsp">User Management</a>
        <a href="restaurant" target="_blank">View Customer Site ↗</a>
    </div>
    <div class="user-badge">
        <span style="font-weight:600; color: #fff;">👋 <%= adminUser.getUser_name() %></span>
        <a href="AdminLogoutServlet" style="color: var(--primary); font-size:13px; font-weight:700;">Logout</a>
    </div>
</div>

<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
<div class="top-back-bar">
    <a href="adminMenu.jsp" class="btn-back-nav" id="backToAdminMenuBtn">
        <i class="fa-solid fa-arrow-left"></i> <span>Admin Menu</span>
    </a>
</div>


<div class="admin-container">

    <!-- Flash Alerts -->
    <%
        String adminMsg = (String) session.getAttribute("adminMsg");
        String adminError = (String) session.getAttribute("adminError");
        if (adminMsg != null) {
    %>
        <div class="alert-banner alert-success">
            <span>✅ <%= adminMsg %></span>
            <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:18px;">✕</button>
        </div>
    <%
            session.removeAttribute("adminMsg");
        }
        if (adminError != null) {
    %>
        <div class="alert-banner alert-error">
            <span>⚠️ <%= adminError %></span>
            <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:18px;">✕</button>
        </div>
    <%
            session.removeAttribute("adminError");
        }
    %>

    <!-- Header -->
    <div class="page-header">
        <div>
            <h1>Admin Orders & Cart Dashboard</h1>
            <p style="color: var(--text-muted); margin-top: 5px;">Monitor active customer checkout orders, cart transactions, and update delivery statuses</p>
        </div>
        <div class="header-actions">
            <a href="cart.jsp" target="_blank" class="btn-secondary">🛍️ Preview User Cart Page</a>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">📦</div>
            <div class="stat-info">
                <h3><%= orderList != null ? orderList.size() : 0 %></h3>
                <p>Total Placed Orders</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(16,185,129,0.15); color: #34d399;">💰</div>
            <div class="stat-info">
                <h3>₹<%= String.format("%.2f", totalRevenue) %></h3>
                <p>Total Revenue</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(245,158,11,0.15); color: #fbbf24;">⏳</div>
            <div class="stat-info">
                <h3><%= pendingCount %></h3>
                <p>Pending / Processing</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(59,130,246,0.15); color: #60a5fa;">✅</div>
            <div class="stat-info">
                <h3><%= deliveredCount %></h3>
                <p>Completed / Delivered</p>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="glass-panel">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="font-size: 22px;">Recent Customer Orders & Cart Transactions</h2>
        </div>

        <div class="table-responsive">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Details</th>
                        <th>Restaurant</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Payment</th>
                        <th>Current Status</th>
                        <th>Update Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (orderList != null && !orderList.isEmpty()) {
                        for (order_table o : orderList) {
                            String st = o.getStatus() != null ? o.getStatus().trim() : "Pending";
                            String badgeClass = "badge-pending";
                            if ("Delivered".equalsIgnoreCase(st)) badgeClass = "badge-delivered";
                            else if ("Out for Delivery".equalsIgnoreCase(st) || "In Transit".equalsIgnoreCase(st)) badgeClass = "badge-transit";
                            else if ("Cancelled".equalsIgnoreCase(st)) badgeClass = "badge-cancelled";
                            
                            user cUser = adminUserDAO.getUser(o.getUserID());
                            String cName = (cUser != null && cUser.getUser_name() != null) ? cUser.getUser_name() : "User #" + o.getUserID();
                            String cAddress = (cUser != null && cUser.getAddress() != null) ? cUser.getAddress() : "Address N/A";
                            
                            Restaurant rObj = adminRestDAO.getRestaurant(o.getRestaurantID());
                            String rName = (rObj != null && rObj.getName() != null) ? rObj.getName() : "Rest #" + o.getRestaurantID();
                    %>
                    <tr>
                        <td><strong>#ORD-<%= o.getOrderID() %></strong></td>
                        <td>
                            <strong style="color: #fff;"><%= cName %></strong>
                            <div style="font-size: 12px; color: var(--text-muted); max-width: 220px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">📍 <%= cAddress %></div>
                        </td>
                        <td><span class="user-badge" style="padding: 2px 10px;"><%= rName %></span></td>
                        <td style="color: var(--text-muted); font-size: 14px;"><%= o.getOrderDate() %></td>
                        <td><strong style="color: var(--primary); font-size: 17px;">₹<%= String.format("%.2f", o.getTotalAmount()) %></strong></td>
                        <td><span style="background: rgba(255,255,255,0.06); padding: 4px 10px; border-radius: 8px; font-size: 13px;"><%= o.getPaymentMethod() != null ? o.getPaymentMethod() : "Card/UPI" %></span></td>
                        <td><span class="badge-status <%= badgeClass %>"><%= st %></span></td>
                        <td>
                            <form action="AdminCartServlet" method="post" style="display: flex; gap: 8px; align-items: center;">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="<%= o.getOrderID() %>">
                                <select name="status" class="form-control" style="padding: 6px 10px; font-size: 13px; width: 140px;" onchange="this.form.submit()">
                                    <option value="Pending" <%= "Pending".equalsIgnoreCase(st) ? "selected" : "" %>>Pending</option>
                                    <option value="Processing" <%= "Processing".equalsIgnoreCase(st) ? "selected" : "" %>>Processing</option>
                                    <option value="Out for Delivery" <%= "Out for Delivery".equalsIgnoreCase(st) || "In Transit".equalsIgnoreCase(st) ? "selected" : "" %>>Out for Delivery</option>
                                    <option value="Delivered" <%= "Delivered".equalsIgnoreCase(st) ? "selected" : "" %>>Delivered</option>
                                    <option value="Cancelled" <%= "Cancelled".equalsIgnoreCase(st) ? "selected" : "" %>>Cancelled</option>
                                </select>
                            </form>
                        </td>
                        <td>
                            <form action="AdminCartServlet" method="post" style="display:inline;" onsubmit="return confirm('Remove order #<%= o.getOrderID() %>?');">
                                <input type="hidden" name="action" value="deleteOrder">
                                <input type="hidden" name="orderId" value="<%= o.getOrderID() %>">
                                <button type="submit" class="btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%  }
                       } else { 
                    %>
                    <tr>
                        <td colspan="9" style="text-align: center; padding: 40px; color: var(--text-muted);">
                            No orders found in database records.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
