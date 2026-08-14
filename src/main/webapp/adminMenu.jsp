<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.user, com.tap.model.Menu, com.tap.model.Restaurant, com.tap.daoIMP.MenuDAOImp, com.tap.daoIMP.RestaurantDAOImp, java.util.List"%>
<%
    user adminUser = (user) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    RestaurantDAOImp restaurantDAO = new RestaurantDAOImp();
    MenuDAOImp menuDAO = new MenuDAOImp();

    List<Restaurant> restaurantList = restaurantDAO.getAllRestaurant();
    
    String reqRestId = request.getParameter("restaurantID");
    List<Menu> menuList;
    int selectedRestId = 0;
    if (reqRestId != null && !reqRestId.isEmpty()) {
        try {
            selectedRestId = Integer.parseInt(reqRestId);
            menuList = menuDAO.getMenuByRestaurant(selectedRestId);
        } catch (NumberFormatException e) {
            menuList = menuDAO.getAllMenu();
        }
    } else {
        menuList = menuDAO.getAllMenu();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Admin Menu Management</title>
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
        <a href="adminMenu.jsp" class="active">Menu & Restaurants</a>
        <a href="adminCart.jsp">Orders & Carts</a>
        <a href="adminUsers.jsp">User Management</a>
        <a href="index.jsp" target="_blank">View Customer Site ↗</a>
    </div>
    <div class="user-badge">
        <span style="font-weight:600; color: #fff;">👋 <%= adminUser.getUser_name() %></span>
        <a href="AdminLogoutServlet" style="color: var(--primary); font-size:13px; font-weight:700;">Logout</a>
    </div>
</div>



<div class="admin-container">

    <!-- Flash Messages -->
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

    <!-- Header Section -->
    <div class="page-header">
        <div>
            <h1>Restaurant & Menu Control Center</h1>
            <p style="color: var(--text-muted); margin-top: 5px;">Manage menu listings, pricing, availability, and restaurants</p>
        </div>
        <div class="header-actions">
            <button class="btn-secondary" onclick="openModal('restaurantModal')">+ Add New Restaurant</button>
            <button class="btn-primary" onclick="openModal('menuModal')">+ Add Menu Item</button>
        </div>
    </div>

    <!-- Quick Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">🏪</div>
            <div class="stat-info">
                <h3><%= restaurantList != null ? restaurantList.size() : 0 %></h3>
                <p>Total Restaurants</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(236,72,153,0.15); color: var(--secondary);">🍕</div>
            <div class="stat-info">
                <h3><%= menuList != null ? menuList.size() : 0 %></h3>
                <p>Total Menu Items <%= selectedRestId > 0 ? "(Filtered)" : "" %></p>
            </div>
        </div>
    </div>

    <!-- Filter Control -->
    <div class="glass-panel" style="padding: 20px 28px; margin-bottom: 25px;">
        <form method="get" action="adminMenu.jsp" style="display: flex; gap: 15px; align-items: center; flex-wrap: wrap;">
            <label style="font-weight: 600; min-width: 150px;">Filter by Restaurant:</label>
            <select name="restaurantID" class="form-control" style="max-width: 320px;" onchange="this.form.submit()">
                <option value="">-- All Restaurants --</option>
                <% if (restaurantList != null) { 
                    for (Restaurant r : restaurantList) { 
                %>
                    <option value="<%= r.getRestaurant_id() %>" <%= selectedRestId == r.getRestaurant_id() ? "selected" : "" %>>
                        <%= r.getName() %> (ID: <%= r.getRestaurant_id() %>)
                    </option>
                <%  } 
                   } 
                %>
            </select>
            <% if (selectedRestId > 0) { %>
                <a href="adminMenu.jsp" class="btn-secondary" style="padding: 10px 20px; font-size: 14px;">Reset Filter</a>
            <% } %>
        </form>
    </div>

    <!-- Menu Items Table -->
    <div class="glass-panel">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="font-size: 22px;">Menu Listings</h2>
        </div>
        
        <div class="table-responsive">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>ID</th>
                        <th>Item Name</th>
                        <th>Rest ID</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Rating</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (menuList != null && !menuList.isEmpty()) {
                        for (Menu m : menuList) {
                    %>
                    <tr>
                        <td>
                            <img src="<%= (m.getImagePath() != null && !m.getImagePath().isEmpty()) ? m.getImagePath() : "images/default-food.jpg" %>" 
                                 alt="<%= m.getItemName() %>" class="item-img" 
                                 onerror="this.src='https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=100&q=80'">
                        </td>
                        <td><strong>#<%= m.getMenuID() %></strong></td>
                        <td><strong style="color: #fff;"><%= m.getItemName() %></strong></td>
                        <td><span class="user-badge" style="padding: 2px 10px;"><%= m.getRestaurantID() %></span></td>
                        <td style="max-width: 250px; color: var(--text-muted); font-size: 14px;">
                            <%= m.getDescription() != null ? m.getDescription() : "No description provided." %>
                        </td>
                        <td><strong style="color: var(--primary); font-size: 17px;">₹<%= String.format("%.2f", m.getPrice()) %></strong></td>
                        <td>⭐ <%= m.getRating() %></td>
                        <td>
                            <% if (m.isAvailable()) { %>
                                <span class="badge-status badge-available">Available</span>
                            <% } else { %>
                                <span class="badge-status badge-unavailable">Out of Stock</span>
                            <% } %>
                        </td>
                        <td>
                            <div style="display: flex; gap: 8px;">
                                <button class="btn-edit" onclick="editMenuItem(
                                    '<%= m.getMenuID() %>',
                                    '<%= m.getRestaurantID() %>',
                                    '<%= m.getItemName().replace("'", "\\'") %>',
                                    '<%= m.getDescription() != null ? m.getDescription().replace("'", "\\'") : "" %>',
                                    '<%= m.getPrice() %>',
                                    '<%= m.isAvailable() %>',
                                    '<%= m.getImagePath() != null ? m.getImagePath().replace("'", "\\'") : "" %>',
                                    '<%= m.getRating() %>'
                                )">Edit</button>
                                <form action="AdminMenuServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete <%= m.getItemName().replace("'", "\\'") %>?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="menuID" value="<%= m.getMenuID() %>">
                                    <input type="hidden" name="filterRestaurantID" value="<%= selectedRestId %>">
                                    <button type="submit" class="btn-danger">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <%  } 
                       } else { 
                    %>
                    <tr>
                        <td colspan="9" style="text-align: center; padding: 40px; color: var(--text-muted);">
                            No menu items found. Click <strong>+ Add Menu Item</strong> to create one!
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal: Add/Edit Menu Item -->
<div id="menuModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="menuModalTitle">Add New Menu Item</h2>
            <button class="close-modal" onclick="closeModal('menuModal')">✕</button>
        </div>
        <form action="AdminMenuServlet" method="post">
            <input type="hidden" name="action" id="menuAction" value="add">
            <input type="hidden" name="menuID" id="menuID" value="0">
            <input type="hidden" name="filterRestaurantID" value="<%= selectedRestId %>">

            <div class="form-grid">
                <div class="form-group">
                    <label>Restaurant ID</label>
                    <select name="restaurantID" id="menuRestID" class="form-control" required>
                        <% if (restaurantList != null) { 
                            for (Restaurant r : restaurantList) { 
                        %>
                            <option value="<%= r.getRestaurant_id() %>" <%= selectedRestId == r.getRestaurant_id() ? "selected" : "" %>>
                                <%= r.getName() %> (ID: <%= r.getRestaurant_id() %>)
                            </option>
                        <%  } 
                           } 
                        %>
                    </select>
                </div>

                <div class="form-group">
                    <label>Item Name</label>
                    <input type="text" name="itemName" id="menuItemName" class="form-control" placeholder="e.g. Butter Chicken" required>
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Description</label>
                    <textarea name="description" id="menuDescription" class="form-control" rows="3" placeholder="Brief details about the dish..."></textarea>
                </div>

                <div class="form-group">
                    <label>Price (₹)</label>
                    <input type="number" step="0.01" name="price" id="menuPrice" class="form-control" placeholder="299.00" required>
                </div>

                <div class="form-group">
                    <label>Rating (0.0 to 5.0)</label>
                    <input type="number" step="0.1" name="rating" id="menuRating" class="form-control" value="4.5" required>
                </div>

                <div class="form-group">
                    <label>Image URL / Path</label>
                    <input type="text" name="imagePath" id="menuImagePath" class="form-control" placeholder="images/butter_chicken.jpg">
                </div>

                <div class="form-group">
                    <label>Availability</label>
                    <select name="isAvailable" id="menuIsAvailable" class="form-control" required>
                        <option value="true">Available (In Stock)</option>
                        <option value="false">Out of Stock</option>
                    </select>
                </div>
            </div>

            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px;">
                <button type="button" class="btn-secondary" onclick="closeModal('menuModal')">Cancel</button>
                <button type="submit" class="btn-primary" id="menuSubmitBtn">Save Menu Item</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: Add Restaurant -->
<div id="restaurantModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Add New Restaurant</h2>
            <button class="close-modal" onclick="closeModal('restaurantModal')">✕</button>
        </div>
        <form action="AdminRestaurantServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-grid">
                <div class="form-group">
                    <label>Restaurant Name</label>
                    <input type="text" name="name" class="form-control" placeholder="e.g. Spice Garden" required>
                </div>

                <div class="form-group">
                    <label>Cuisine / Customer Type</label>
                    <input type="text" name="customerType" class="form-control" placeholder="e.g. North Indian, Chinese" required>
                </div>

                <div class="form-group">
                    <label>Delivery Time</label>
                    <input type="text" name="deliveryTime" class="form-control" placeholder="e.g. 30-40 mins" required>
                </div>

                <div class="form-group">
                    <label>Rating</label>
                    <input type="number" step="0.1" name="rating" class="form-control" value="4.5" required>
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Address</label>
                    <input type="text" name="address" class="form-control" placeholder="Restaurant full address..." required>
                </div>

                <div class="form-group">
                    <label>Image URL / Path</label>
                    <input type="text" name="imagePath" class="form-control" placeholder="images/restaurant.jpg">
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="isActive" class="form-control" required>
                        <option value="true">Active</option>
                        <option value="false">Inactive</option>
                    </select>
                </div>
            </div>

            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px;">
                <button type="button" class="btn-secondary" onclick="closeModal('restaurantModal')">Cancel</button>
                <button type="submit" class="btn-primary">Add Restaurant</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openModal(id) {
        document.getElementById(id).classList.add('active');
    }
    function closeModal(id) {
        document.getElementById(id).classList.remove('active');
    }

    function editMenuItem(id, restId, name, desc, price, available, img, rating) {
        document.getElementById('menuModalTitle').innerText = 'Edit Menu Item #' + id;
        document.getElementById('menuAction').value = 'update';
        document.getElementById('menuID').value = id;
        document.getElementById('menuRestID').value = restId;
        document.getElementById('menuItemName').value = name;
        document.getElementById('menuDescription').value = desc;
        document.getElementById('menuPrice').value = price;
        document.getElementById('menuIsAvailable').value = available;
        document.getElementById('menuImagePath').value = img;
        document.getElementById('menuRating').value = rating;
        document.getElementById('menuSubmitBtn').innerText = 'Update Menu Item';
        openModal('menuModal');
    }
</script>

</body>
</html>
