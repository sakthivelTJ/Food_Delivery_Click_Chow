<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.user"%>
<%
    user user = (user) session.getAttribute("loggedInUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Edit Profile</title>
    <!-- Web Favicon -->
    <link rel="icon" href="assets/images/icon.png">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="index.css">

    <style>
        body {
            background-color: #090b12;
            color: #ffffff;
            font-family: 'Outfit', sans-serif;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            padding-top: 110px; /* Prevents fixed header from overlapping content */
        }

        .edit-profile-container {
            max-width: 750px;
            margin: 30px auto 60px auto;
            padding: 0 20px;
            width: 100%;
            position: relative;
            z-index: 1;
        }

        .edit-profile-card {
            background: rgba(24, 29, 43, 0.85);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 28px;
            padding: 40px;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5), inset 0 0 0 1px rgba(255, 255, 255, 0.05);
            position: relative;
            overflow: hidden;
        }

        .edit-profile-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(135deg, #ff5a36, #ec4899);
        }

        .profile-header-section {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .avatar-circle {
            width: 85px;
            height: 85px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ff5a36, #ec4899);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 38px;
            color: #ffffff;
            box-shadow: 0 10px 25px rgba(255, 90, 54, 0.35);
            flex-shrink: 0;
        }

        .profile-header-info h2 {
            font-size: 28px;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .profile-header-info p {
            color: #9ea8bc;
            font-size: 15px;
        }

        .role-badge {
            display: inline-block;
            margin-top: 8px;
            padding: 4px 14px;
            border-radius: 20px;
            background: rgba(236, 72, 153, 0.15);
            border: 1px solid rgba(236, 72, 153, 0.3);
            color: #ec4899;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px;
        }

        @media (max-width: 650px) {
            body {
                padding-top: 100px;
            }
            .form-grid {
                grid-template-columns: 1fr;
            }
            .edit-profile-card {
                padding: 25px;
            }
            .profile-header-section {
                flex-direction: column;
                text-align: center;
            }
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            font-size: 14px;
            font-weight: 600;
            color: #d1d5db;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label i {
            color: #ff5a36;
        }

        .form-control {
            width: 100%;
            padding: 14px 18px;
            background: #111522;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 14px;
            color: #ffffff;
            font-size: 15px;
            font-family: inherit;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #ff5a36;
            box-shadow: 0 0 18px rgba(255, 90, 54, 0.25);
            background: #151a2a;
        }

        .form-control::placeholder {
            color: #6c757d;
        }

        .form-actions {
            margin-top: 35px;
            display: flex;
            gap: 16px;
            justify-content: flex-end;
        }

        .btn-save {
            padding: 14px 32px;
            border: none;
            border-radius: 50px;
            background: linear-gradient(135deg, #ff5a36, #ec4899);
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(255, 90, 54, 0.35);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 35px rgba(255, 90, 54, 0.5);
            background: linear-gradient(135deg, #ff6838, #ff3d87);
        }

        .btn-cancel {
            padding: 14px 28px;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #d1d5db;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-cancel:hover {
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
        }

        .alert-box {
            padding: 14px 20px;
            border-radius: 14px;
            margin-bottom: 25px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #34d399;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
        }

        /* Simple top-right username badge styling */
        .user-name-badge {
            padding: 10px 20px;
            border-radius: 50px;
            background: linear-gradient(135deg, #ff5a36, #ec4899);
            color: #ffffff;
            font-size: 15px;
            font-weight: 600;
            box-shadow: 0 8px 20px rgba(255, 90, 54, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            cursor: default;
        }
    </style>
</head>
<body>

    <!-- Header Navigation -->
    <header class="header">
        <div class="header-container">
            <a href="accessed" class="logo"> 
                <span class="logo-icon"><i class="fa-solid fa-arrow-pointer"></i></span> Click<span>Chow</span>
            </a>

            <nav class="nav-links">
                <a href="restaurant">Home</a>
                <a href="restaurant#restaurants-section">Restaurants</a>
                <a href="orderHistory">Order History</a>
            </nav>

            <div class="header-actions">
                <!-- Username button only (No dropdown card) -->
                <div class="user-name-badge">
                    <i class="fa-solid fa-user"></i> <%= user.getUser_name() %>
                </div>

                <a href="LogoutServlet" class="btn-secondary login-btn" style="padding: 10px 20px; text-decoration: none;">Logout</a>
            </div>
        </div>
    </header>

   

    <div class="edit-profile-container">

        
        <%
            String profileSuccess = (String) session.getAttribute("profileSuccess");
            String profileError = (String) session.getAttribute("profileError");
            if (profileSuccess != null) {
        %>
            <div class="alert-box alert-success">
                <span><i class="fa-solid fa-circle-check"></i> <%= profileSuccess %></span>
                <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:16px;">✕</button>
            </div>
        <%
                session.removeAttribute("profileSuccess");
            }
            if (profileError != null) {
        %>
            <div class="alert-box alert-error">
                <span><i class="fa-solid fa-triangle-exclamation"></i> <%= profileError %></span>
                <button onclick="this.parentElement.style.display='none'" style="background:none; border:none; color:currentColor; cursor:pointer; font-size:16px;">✕</button>
            </div>
        <%
                session.removeAttribute("profileError");
            }
        %>

        <div class="edit-profile-card">
            
            <div class="profile-header-section">
                <div class="avatar-circle">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="profile-header-info">
                    <h2><%=user.getUser_name() %></h2>
                    <p><i class="fa-regular fa-envelope"></i> <%= user.getEmail() %></p>
                    <span class="role-badge"><i class="fa-solid fa-shield"></i> <%= user.getRole() %> Account</span>
                </div>
            </div>

            <form action="updateProfile" method="post">
                <div class="form-grid">
                    
                    <div class="form-group">
                        <label for="username"><i class="fa-solid fa-user-pen"></i> Username</label>
                        <input type="text" id="username" name="username" class="form-control" value="<%= user.getUser_name() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fa-solid fa-envelope"></i> Email Address</label>
                        <input type="email" id="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
                    </div>

                    <div class="form-group full-width">
                        <label for="phoneNumber"><i class="fa-solid fa-phone"></i> Phone Number</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control" value="<%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "" %>" placeholder="Enter your phone number">
                    </div>

                    <div class="form-group full-width">
                        <label for="address"><i class="fa-solid fa-location-dot"></i> Delivery Address</label>
                        <input type="text" id="address" name="address" class="form-control" value="<%= user.getAddress() != null ? user.getAddress() : "" %>" placeholder="Enter your full address">
                    </div>

                    <div class="form-group full-width">
                        <label for="new_password"><i class="fa-solid fa-lock"></i> New Password (Leave blank to keep unchanged)</label>
                        <input type="password" id="new_password" name="new_password" class="form-control" placeholder="Enter new password if you want to update it">
                    </div>

                </div>

                <div class="form-actions">
                    <a href="myindex.jsp" class="btn-cancel"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
                    <button type="submit" class="btn-save"><i class="fa-solid fa-floppy-disk"></i> Save Profile Changes</button>
                </div>
            </form>

        </div>

    </div>

    <script src="app.js"></script>
</body>
</html>
