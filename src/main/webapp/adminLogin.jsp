<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Admin Portal Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="index.css">
    <style>
        .admin-tag {
            background: linear-gradient(135deg, #ff5a36, #ec4899);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 1px;
            display: inline-block;
            margin-bottom: 15px;
            text-transform: uppercase;
        }
        .error-msg {
            background: rgba(239, 68, 68, 0.18);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
            padding: 12px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<!-- TOP CORNER BACK NAVIGATION BUTTON BELOW HEADER SECTION -->
<div class="top-back-bar">
    <a href="restaurant" class="btn-back-nav" id="backToRestaurantsBtn">
        <i class="fa-solid fa-arrow-left"></i> <span>Restaurants</span>
    </a>
</div>

<div class="container">

    <div class="glass-card">
        <div class="logo">Click Chow</div>
        <div style="text-align: center;">
            <span class="admin-tag">Admin Control Center</span>
        </div>
        <h2>Admin Authentication</h2>
        <p class="subtitle">Please sign in with administrator credentials</p>

        <% 
            String msg = (String) request.getAttribute("msg");
            if (msg != null && !msg.isEmpty()) { 
        %>
            <div class="error-msg"><%= msg %></div>
        <% } %>

        <form action="AdminLoginServlet" method="post">
            <div class="input-group">
                <label for="user_name">Admin Username</label>
                <input type="text" id="user_name" name="user_name" placeholder="Enter admin username" required>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>

            <button type="submit">Sign In to Dashboard</button>
        </form>

        <div class="register-text">
            <a href="index.jsp">← Back to Main Customer Portal</a>
        </div>
    </div>
</div>

</body>
</html>
