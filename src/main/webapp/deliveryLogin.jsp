<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Delivery Partner Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="index.css">

    <style>
        .delivery-tag {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            padding: 4px 14px;
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
        <div class="logo">🚴 Click Chow</div>
        <div style="text-align: center;">
            <span class="delivery-tag">Delivery Partner Portal</span>
        </div>
        <h2>Partner Login</h2>
        <p class="subtitle">Sign in to view assigned food orders and deliver</p>

        <% 
            String msg = (String) request.getAttribute("msg");
            if (msg != null && !msg.isEmpty()) { 
        %>
            <div class="error-msg"><%= msg %></div>
        <% } %>

        <form action="DeliveryLoginServlet" method="post">
            <div class="input-group">
                <label for="user_name">Delivery Username</label>
                <input type="text" id="user_name" name="user_name" placeholder="Enter username" required>
            </div>

            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>

            <button type="submit" style="background: linear-gradient(135deg, #10b981, #059669);">Sign In to Delivery Portal</button>
        </form>

        <div class="register-text">
            <a href="login.jsp">← Back to Main Login Page</a>
        </div>
    </div>
</div>

</body>
</html>
