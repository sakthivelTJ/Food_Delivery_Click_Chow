<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.user, com.tap.daoIMP.userDAOImp, java.util.List"%>
<%
    user adminUser = (user) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    userDAOImp userDAO = new userDAOImp();
    List<user> userList = userDAO.getAllUser();

    int totalUsers = userList != null ? userList.size() : 0;
    int adminCount = 0;
    int deliveryCount = 0;
    int customerCount = 0;

    if (userList != null) {
        for (user u : userList) {
            String role = u.getRole();
            if (role != null) {
                String r = role.toLowerCase().replace("_", "").replace(" ", "");
                if (r.equals("admin") || r.equals("administrator")) {
                    adminCount++;
                } else if (r.equals("delivery") || r.equals("deliverypartner")) {
                    deliveryCount++;
                } else {
                    customerCount++;
                }
            } else {
                customerCount++;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Admin User Management</title>
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
        <a href="adminCart.jsp">Orders & Carts</a>
        <a href="adminUsers.jsp" class="active">User Management</a>
        <a href="restaurant" target="_blank">View Customer Site ↗</a>
    </div>
    <div class="user-badge">
        <span style="font-weight:600; color: #fff;">👋 <%= adminUser.getUser_name() %></span>
        <a href="AdminLogoutServlet" style="color: var(--primary); font-size:13px; font-weight:700;">Logout</a>
    </div>
</div>



<div class="admin-container">

    <!-- Flash Notifications -->
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
            <h1>User Accounts & Access Control</h1>
            <p style="color: var(--text-muted); margin-top: 5px;">Manage registered accounts, grant administrator or delivery partner privileges, and delete users</p>
        </div>
        <div class="header-actions">
            <button class="btn-primary" onclick="openModal('addUserModal')">+ Add New User</button>
        </div>
    </div>

    <!-- Quick Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-info">
                <h3><%= totalUsers %></h3>
                <p>Total Registered Users</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(236,72,153,0.15); color: var(--secondary);">👑</div>
            <div class="stat-info">
                <h3><%= adminCount %></h3>
                <p>Administrators</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(16,185,129,0.15); color: #34d399;">🚴</div>
            <div class="stat-info">
                <h3><%= deliveryCount %></h3>
                <p>Delivery Partners</p>
            </div>
        </div>
        <div class="stat-card">
            <div class="stat-icon" style="background: rgba(59,130,246,0.15); color: #60a5fa;">🛍️</div>
            <div class="stat-info">
                <h3><%= customerCount %></h3>
                <p>Customers</p>
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="glass-panel">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="font-size: 22px;">Registered User Directory</h2>
        </div>

        <div class="table-responsive">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Created Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (userList != null && !userList.isEmpty()) {
                        for (user u : userList) {
                            String roleStr = u.getRole() != null ? u.getRole() : "Customer";
                            String cleanRole = roleStr.toLowerCase().replace("_", "").replace(" ", "");
                            boolean isAdmin = cleanRole.equals("admin") || cleanRole.equals("administrator");
                            boolean isDelivery = cleanRole.equals("delivery") || cleanRole.equals("deliverypartner");
                    %>
                    <tr>
                        <td><strong>#<%= u.getUser_id() %></strong></td>
                        <td>
                            <strong style="color: #fff; font-size: 16px;"><%= u.getUser_name() %></strong>
                            <% if (u.getUser_id() == adminUser.getUser_id()) { %>
                                <span style="font-size: 11px; background: rgba(255,90,54,0.2); color: var(--primary); padding: 2px 6px; border-radius: 6px; margin-left: 6px;">(You)</span>
                            <% } %>
                        </td>
                        <td style="color: var(--text-muted);"><%= u.getEmail() %></td>
                        <td>
                            <% if (isAdmin) { %>
                                <span class="badge-status badge-available">👑 Admin</span>
                            <% } else if (isDelivery) { %>
                                <span class="badge-status badge-available" style="background: rgba(16,185,129,0.18); color: #34d399; border-color: rgba(16,185,129,0.3);">🚴 Delivery Partner</span>
                            <% } else { %>
                                <span class="badge-status badge-pending">👤 Customer</span>
                            <% } %>
                        </td>
                        <td style="color: var(--text-muted); font-size: 14px;">
                            <%= u.getPhoneNumber() != null ? u.getPhoneNumber() : "N/A" %>
                        </td>
                        <td style="max-width: 200px; color: var(--text-muted); font-size: 14px;">
                            <%= u.getAddress() != null && !u.getAddress().isEmpty() ? u.getAddress() : "Not specified" %>
                        </td>
                        <td style="color: var(--text-muted); font-size: 13px;">
                            <%= u.getCreatedDate() != null ? u.getCreatedDate() : "N/A" %>
                        </td>
                        <td>
                            <div style="display: flex; gap: 8px;">
                                <button class="btn-edit" onclick="editUser(
                                    '<%= u.getUser_id() %>',
                                    '<%= u.getUser_name().replace("'", "\\'") %>',
                                    '<%= u.getEmail() != null ? u.getEmail().replace("'", "\\'") : "" %>',
                                    '<%= roleStr.replace("'", "\\'") %>',
                                    '<%= u.getAddress() != null ? u.getAddress().replace("'", "\\'") : "" %>',
                                    '<%= u.getPhoneNumber() != null ? u.getPhoneNumber().replace("'", "\\'") : "" %>'
                                )">Edit</button>
                                
                                <% if (u.getUser_id() != adminUser.getUser_id()) { %>
                                    <form action="AdminUserServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete user <%= u.getUser_name().replace("'", "\\'") %> (ID: <%= u.getUser_id() %>)?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="<%= u.getUser_id() %>">
                                        <button type="submit" class="btn-danger">Delete</button>
                                    </form>
                                <% } else { %>
                                    <button class="btn-danger" style="opacity: 0.4; cursor: not-allowed;" disabled title="Cannot delete active session user">Delete</button>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <%  }
                       } else { 
                    %>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 40px; color: var(--text-muted);">
                            No registered users found. Click <strong>+ Add New User</strong> to create an account.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal: Edit User -->
<div id="editUserModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="editUserTitle">Edit User Account</h2>
            <button class="close-modal" onclick="closeModal('editUserModal')">✕</button>
        </div>
        <form action="AdminUserServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" id="editUserId" value="0">

            <div class="form-grid">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="user_name" id="editUsername" class="form-control" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" id="editEmail" class="form-control" required>
                </div>

                <div class="form-group">
                    <label>Account Role</label>
                    <select name="role" id="editRole" class="form-control" required>
                        <option value="Customer">Customer</option>
                        <option value="DeliveryPartner">Delivery Partner</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>New Password (Leave blank to keep current)</label>
                    <input type="password" name="password" id="editPassword" class="form-control" placeholder="••••••••">
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Phone Number</label>
                    <input type="tel" name="phoneNumber" id="editPhoneNumber" class="form-control" placeholder="Phone number...">
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Delivery Address</label>
                    <input type="text" name="address" id="editAddress" class="form-control" placeholder="Full address...">
                </div>
            </div>

            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px;">
                <button type="button" class="btn-secondary" onclick="closeModal('editUserModal')">Cancel</button>
                <button type="submit" class="btn-primary">Save User Changes</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal: Add New User -->
<div id="addUserModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Add New User Account</h2>
            <button class="close-modal" onclick="closeModal('addUserModal')">✕</button>
        </div>
        <form action="AdminUserServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-grid">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="user_name" class="form-control" placeholder="e.g. john_doe" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" placeholder="Enter password" required>
                </div>

                <div class="form-group">
                    <label>Role</label>
                    <select name="role" class="form-control" required>
                        <option value="Customer">Customer</option>
                        <option value="DeliveryPartner">Delivery Partner</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Phone Number</label>
                    <input type="tel" name="phoneNumber" class="form-control" placeholder="User phone number...">
                </div>

                <div class="form-group" style="grid-column: 1 / -1;">
                    <label>Address</label>
                    <input type="text" name="address" class="form-control" placeholder="User delivery address...">
                </div>
            </div>

            <div style="display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px;">
                <button type="button" class="btn-secondary" onclick="closeModal('addUserModal')">Cancel</button>
                <button type="submit" class="btn-primary">Create User Account</button>
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

    function editUser(id, username, email, role, address, phoneNumber) {
        document.getElementById('editUserTitle').innerText = 'Edit User #' + id;
        document.getElementById('editUserId').value = id;
        document.getElementById('editUsername').value = username;
        document.getElementById('editEmail').value = email;
        var r = role ? role.toLowerCase().replace('_', '').replace(' ', '') : 'customer';
        if (r === 'delivery' || r === 'deliverypartner') {
            document.getElementById('editRole').value = 'DeliveryPartner';
        } else if (r === 'admin' || r === 'administrator') {
            document.getElementById('editRole').value = 'Admin';
        } else {
            document.getElementById('editRole').value = 'Customer';
        }
        document.getElementById('editAddress').value = address;
        document.getElementById('editPhoneNumber').value = phoneNumber;
        document.getElementById('editPassword').value = '';
        openModal('editUserModal');
    }
</script>

</body>
</html>
