<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Click Chow | Login</title>
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>


    <div class="container">
        <div class="glass-card">
            <div class="logo">🍔 Click Chow</div>
            
            <!-- 3 Category Tabs (Customer | Admin | Delivery) -->
            <div class="role-tabs">
                <button type="button" class="role-tab active" id="customerTab" onclick="setRole('customer')">
                    🛒 Customer
                </button>
                <button type="button" class="role-tab" id="adminTab" onclick="setRole('admin')">
                    ⚙️ Admin
                </button>
                <button type="button" class="role-tab" id="deliveryTab" onclick="setRole('delivery')">
                    🚴 Delivery
                </button>
            </div>

            <h2 id="loginHeading">Welcome Back</h2>
            <p class="subtitle" id="loginSubtitle">Login to continue ordering your favourite food</p>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null && !msg.isEmpty()) {
            %>
                <div style="background: rgba(239,68,68,0.18); border: 1px solid rgba(239,68,68,0.3); color: #f87171; padding: 12px; border-radius: 12px; text-align: center; margin-bottom: 20px; font-size: 14px;">
                    <%= msg %>
                </div>
            <%
                }
            %>

            <form action="LoginServlet" method="post">
                <!-- Hidden parameter to pass selected role -->
                <input type="hidden" name="login_role" id="loginRoleInput" value="customer">

                <div class="input-group">
                    <label for="user_name">Username</label>
                    <input type="text" id="user_name" name="user_name" placeholder="Enter your username" required>
                </div>

                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <div class="options">
                    <label class="remember">
                        <input type="checkbox" id="remember" name="remember"> Remember Me
                    </label>
                    <a href="#">Forgot Password?</a>
                </div>

                <button type="submit" id="loginBtn" name="loginBtn">Login as Customer</button>

                <p class="register-text" id="registerText">
                    Don't have an account? <a href="register.html">Register</a>
                </p>

                <p class="register-text" style="margin-top: 15px; font-size: 13px;">
                    Dedicated login page: <a href="deliveryLogin.jsp" style="color: #10b981;">🚴 Delivery Portal ↗</a>
                </p>
            </form>
        </div>
    </div>

    <script>
        function setRole(role) {
            var roleInput = document.getElementById('loginRoleInput');
            var custTab = document.getElementById('customerTab');
            var adminTab = document.getElementById('adminTab');
            var deliveryTab = document.getElementById('deliveryTab');
            var heading = document.getElementById('loginHeading');
            var subtitle = document.getElementById('loginSubtitle');
            var loginBtn = document.getElementById('loginBtn');
            var registerText = document.getElementById('registerText');

            roleInput.value = role;

            custTab.classList.remove('active');
            adminTab.classList.remove('active');
            deliveryTab.classList.remove('active');

            if (role === 'admin') {
                adminTab.classList.add('active');
                heading.innerText = 'Admin Portal';
                subtitle.innerText = 'Sign in to access management control center';
                loginBtn.innerText = 'Login as Admin';
                registerText.style.display = 'none';
            } else if (role === 'delivery') {
                deliveryTab.classList.add('active');
                heading.innerText = 'Delivery Partner Portal';
                subtitle.innerText = 'Sign in to view assigned food orders and deliver';
                loginBtn.innerText = 'Login as Delivery Partner';
                registerText.style.display = 'none';
            } else {
                custTab.classList.add('active');
                heading.innerText = 'Welcome Back';
                subtitle.innerText = 'Login to continue ordering your favourite food';
                loginBtn.innerText = 'Login as Customer';
                registerText.style.display = 'block';
            }
        }
    </script>

</body>
</html>