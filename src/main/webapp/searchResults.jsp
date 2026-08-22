<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.tap.model.Menu, com.tap.model.Restaurant, java.util.Map, com.tap.model.user" %>
<%
user loggedInUser = (user) session.getAttribute("loggedInUser");
if (loggedInUser == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!doctype html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results | ClickChow</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="index.css">
    <style>
        body { background: #0b0c10; color: #fff; font-family: 'Outfit', sans-serif; margin: 0; }
        .search-results-header { text-align: center; margin: 40px auto; max-width: 800px; padding: 0 20px; }
        .gradient-text { background: linear-gradient(90deg, #ffffff 0%, #ffffff 45%, #ff5a36 65%, #ec4899 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; font-size: 3rem; font-weight: 800; margin-bottom: 10px; }
        .search-subtitle { color: #aeb8cc; font-size: 1.2rem; margin-bottom: 25px; }
        .search-query-badge { font-weight: 700; color: #ff5a36; background: rgba(255, 90, 54, 0.1); padding: 4px 12px; border-radius: 20px; }
        
        .page-search-box { display: flex; max-width: 600px; margin: 0 auto; background: #181d2b; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 50px; padding: 6px; box-shadow: 0 8px 25px rgba(0,0,0,0.4); }
        .page-search-box input { flex: 1; background: transparent; border: none; color: white; padding: 0 20px; font-size: 1.1rem; outline: none; font-family: 'Outfit', sans-serif; }
        .page-search-box button { background: linear-gradient(90deg, #ff5a36, #ec4899); border: none; color: white; padding: 12px 30px; border-radius: 40px; font-weight: 700; cursor: pointer; transition: 0.3s; font-family: 'Outfit', sans-serif; }
        .page-search-box button:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 90, 54, 0.4); }
        
        .result-count { display: inline-block; background: #181d2b; padding: 8px 20px; border-radius: 20px; font-weight: 600; margin-top: 20px; border: 1px solid rgba(255,255,255,0.05); }
        
        .top-back-bar { padding: 15px 5%; background: rgba(9, 11, 18, 0.85);  }
        .btn-back-nav { color: #aeb8cc; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; transition: 0.3s; }
        .btn-back-nav:hover { color: #ff5a36; }
        
        .food-grid { width: 95%; max-width: 1400px; margin: 40px auto; display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; }
        .menu-card { background: #181d2b; border-radius: 20px; overflow: hidden; border: 1px solid rgba(255, 255, 255, 0.08); transition: 0.3s; display: flex; flex-direction: column; }
        .menu-card:hover { transform: translateY(-8px); box-shadow: 0 15px 35px rgba(0,0,0,0.5); border-color: rgba(255, 90, 54, 0.3); }
        .menu-card img { width: 100%; height: 200px; object-fit: cover; }
        .card-content { padding: 20px; display: flex; flex-direction: column; flex: 1; }
        .restaurant-badge { align-self: flex-start; background: rgba(255, 255, 255, 0.05); padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; color: #aeb8cc; margin-bottom: 10px; display: inline-flex; align-items: center; gap: 6px; }
        .restaurant-badge i { color: #ff5a36; }
        .card-content h2 { margin: 0 0 10px 0; font-size: 1.4rem; color: #fff; }
        .description { color: #8b97ab; font-size: 0.95rem; line-height: 1.5; margin-bottom: 15px; flex: 1; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
        .details { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .rating { color: #ffb703; font-weight: 700; }
        .price { font-size: 1.3rem; font-weight: 800; color: #fff; }
        .btn-view-menu { display: block; text-align: center; background: rgba(255, 90, 54, 0.1); color: #ff5a36; text-decoration: none; padding: 12px; border-radius: 50px; font-weight: 700; transition: 0.3s; border: 1px solid rgba(255, 90, 54, 0.2); }
        .btn-view-menu:hover { background: linear-gradient(90deg, #ff5a36, #ec4899); color: #fff; border-color: transparent; }
        
        .empty-state { text-align: center; padding: 80px 20px; }
        .empty-state i { font-size: 4rem; color: rgba(255, 255, 255, 0.1); margin-bottom: 20px; }
        .empty-state h3 { font-size: 1.8rem; color: #fff; margin-bottom: 10px; }
        .empty-state p { color: #aeb8cc; margin-bottom: 25px; }
        
        [data-theme="light"] body { background: #f8fafc; color: #0f172a; }
        [data-theme="light"] .page-search-box, [data-theme="light"] .menu-card { background: #fff; border-color: #e2e8f0; }
        [data-theme="light"] .menu-card:hover { box-shadow: 0 15px 35px rgba(0,0,0,0.08); }
        [data-theme="light"] .card-content h2, [data-theme="light"] .price, [data-theme="light"] .empty-state h3 { color: #0f172a; }
        [data-theme="light"] .description, [data-theme="light"] .search-subtitle, [data-theme="light"] .empty-state p, [data-theme="light"] .btn-back-nav { color: #64748b; }
        [data-theme="light"] .restaurant-badge { background: #f1f5f9; color: #475569; }
        [data-theme="light"] .top-back-bar { background: #fff; }
        [data-theme="light"] .empty-state i { color: #cbd5e1; }
        [data-theme="light"] .result-count { background: #fff; border-color: #e2e8f0; color: #0f172a; }
        
        /* Card click animation for search results page */
        .menu-card { position: relative; overflow: hidden; }
        .menu-card.card-selected .btn-view-menu {
            background: linear-gradient(90deg, #ff5a36, #ec4899) !important;
            color: #fff !important;
            border-color: transparent !important;
        }
        @keyframes cardFadeUp {
            0% { opacity: 1; transform: translateY(0); }
            100% { opacity: 0; transform: translateY(-20px); }
        }
        
        /* Header CSS from index */
        .header { background: rgba(9, 11, 18, 0.85); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255, 255, 255, 0.08); position: sticky; top: 0; z-index: 100; }
        .header-container { width: 95%; max-width: 1650px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; }
        .logo { color: white; text-decoration: none; font-size: 24px; font-weight: 800; display: flex; align-items: center; gap: 8px; }
        .logo span { background: linear-gradient(90deg, #ff5a36, #ec4899); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .logo-icon { color: #ff5a36; }
        .nav-links { display: flex; gap: 30px; }
        .nav-links a { color: #AEB8CC; text-decoration: none; font-weight: 500; font-size: 16px; transition: 0.3s; }
        .nav-links a:hover, .nav-links a.active { color: white; }
        .header-actions { display: flex; align-items: center; gap: 15px; }
        .login-btn { color: white; text-decoration: none; font-weight: 600; padding: 10px 20px; transition: 0.3s; }
        .login-btn:hover { color: #ff5a36; }
        .register-btn { background: linear-gradient(90deg, #ff5a36, #ec4899); color: white; text-decoration: none; font-weight: 600; padding: 10px 24px; border-radius: 50px; transition: 0.3s; }
        .register-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(255, 90, 54, 0.3); }
        [data-theme="light"] .header { background: rgba(255, 255, 255, 0.9); border-bottom: 1px solid rgba(0,0,0,0.05); }
        [data-theme="light"] .logo { color: #090b12; }
        [data-theme="light"] .nav-links a { color: #4b5563; }
        [data-theme="light"] .nav-links a:hover { color: #090b12; }
        [data-theme="light"] .login-btn { color: #090b12; }
        
        .profile {
            position: relative;
            display: inline-block;
        }
        .profile-btn {
            padding: 12px 22px;
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
            text-align: center;
        }
        .profile-card a:hover {
            background: linear-gradient(135deg, #ff5a36, #ec4899);
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-container">
            <a href="restaurant" class="logo">
                <span class="logo-icon"><i class="fa-solid fa-arrow-pointer"></i></span>
                Click<span>Chow</span>
            </a>
            <nav class="nav-links">
                <a href="accessed">Home</a>
                <a href="restaurant">Restaurants</a>
                <a href="#">About</a>
                <a href="#">Contact</a>
            </nav>
            <div class="header-actions">
                <div class="profile">
                    <button class="profile-btn" onclick="toggleProfile()">
                        👤 <%=loggedInUser.getUser_name()%>
                    </button>
                    <div class="profile-card" id="profileCard">
                        <h3>My Account</h3>
                        <div class="row">
                            <span>Username</span> <span><%=loggedInUser.getUser_name()%></span>
                        </div>
                        <div class="row">
                            <span>Email</span> <span><%=loggedInUser.getEmail()%></span>
                        </div>
                        <div class="row">
                            <span>Phone</span> <span><%=loggedInUser.getPhoneNumber() != null ? loggedInUser.getPhoneNumber() : "N/A"%></span>
                        </div>
                        <div class="row">
                            <span>Role</span> <span><%=loggedInUser.getRole()%></span>
                        </div>
                        <a href="orderHistory"><i class="fa-solid fa-clock-rotate-left"></i> Order History</a>
                        <a href="editProfile.jsp"><i class="fa-solid fa-pen"></i> Edit Profile</a>
                        <a href="LogoutServlet"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="top-back-bar">
        <a href="restaurant" class="btn-back-nav">
            <i class="fa-solid fa-arrow-left"></i> Back
        </a>
    </div>

    <% 
        String q = (String) request.getAttribute("searchQuery");
        if (q == null) q = "";
        List<Menu> results = (List<Menu>) request.getAttribute("searchResults");
        Map<Integer, Restaurant> restaurantMap = (Map<Integer, Restaurant>) request.getAttribute("restaurantMap");
    %>

    <div class="search-results-header">
        <h1 class="gradient-text">Search Results</h1>
        <p class="search-subtitle">Showing results for <span class="search-query-badge">"<%= q.replace("\"", "&quot;") %>"</span></p>
        
        <form action="searchFood" method="get" class="page-search-box">
            <input type="text" name="q" value="<%= q.replace("\"", "&quot;") %>" placeholder="Search for food, restaurants, etc..." id="page-search-input" required>
            <button type="submit">Search</button>
        </form>
        
        <% if (results != null && !results.isEmpty()) { %>
            <div class="result-count">Found <%= results.size() %> items</div>
        <% } %>
    </div>

    <div class="food-grid">
        <%! 
        public String getUniqueDishImage(com.tap.model.Menu menu) {
            if (menu == null) return "assets/images/biryani.png";
            String name = menu.getItemName() != null ? menu.getItemName().toLowerCase() : "";
            String customPath = menu.getImagePath();
            if (customPath != null && !customPath.trim().isEmpty() && !customPath.startsWith("images/menu/") && !customPath.contains("biryani.png")) {
                return customPath;
            }
            if (name.contains("biryani") || name.contains("rice") || name.contains("pulao") || name.contains("thali") || name.contains("tiffin") || name.contains("dosa") || name.contains("idli")) {
                return "assets/images/biryani.png";
            }
            if (name.contains("burger") || name.contains("sandwich") || name.contains("wrap") || name.contains("roll")) {
                return "assets/images/burger.png";
            }
            if (name.contains("pizza") || name.contains("naan") || name.contains("roti") || name.contains("bread") || name.contains("pasta") || name.contains("kulcha")) {
                return "assets/images/pizza.png";
            }
            if (name.contains("paneer") || name.contains("tikka") || name.contains("tandoori") || name.contains("kebab") || name.contains("chicken") || name.contains("mutton") || name.contains("lamb") || name.contains("starter") || name.contains("curry") || name.contains("masala") || name.contains("fry") || name.contains("rasam") || name.contains("chukka") || name.contains("roast")) {
                return "assets/images/paneertikka.png";
            }
            if (name.contains("sushi") || name.contains("noodle") || name.contains("ramen") || name.contains("fish") || name.contains("seafood") || name.contains("asian") || name.contains("prawn") || name.contains("lobster")) {
                return "assets/images/sushi.png";
            }
            if (name.contains("dessert") || name.contains("cake") || name.contains("ice cream") || name.contains("sweet") || name.contains("shake") || name.contains("coffee") || name.contains("tea") || name.contains("drink") || name.contains("lassi") || name.contains("payasam") || name.contains("kesari") || name.contains("jamun") || name.contains("chocolate")) {
                return "assets/images/dessert.png";
            }
            String[] localFoodPhotos = {"assets/images/burger.png", "assets/images/pizza.png", "assets/images/paneertikka.png", "assets/images/sushi.png", "assets/images/dessert.png", "assets/images/biryani.png"};
            int idx = Math.abs(menu.getMenuID()) % localFoodPhotos.length;
            return localFoodPhotos[idx];
        }
        %>
        
        <% if (results != null && !results.isEmpty()) { 
            for (Menu menu : results) { 
                Restaurant r = restaurantMap.get(menu.getRestaurantID());
                String rName = (r != null) ? r.getName() : "ClickChow Restaurant";
        %>
            <div class="menu-card" id="menu-item-<%= menu.getMenuID() %>">
                <img src="<%= getUniqueDishImage(menu) %>" alt="<%= menu.getItemName() %>" onerror="this.onerror=null; this.src='assets/images/paneertikka.png';">
                <div class="card-content">
                    <div class="restaurant-badge"><i class="fa-solid fa-store"></i> <%= rName %></div>
                    <h2><%= menu.getItemName() %></h2>
                    <p class="description"><%= menu.getDescription() != null ? menu.getDescription() : "" %></p>
                    <div class="details">
                        <span class="rating">⭐ <%= menu.getRating() != null ? menu.getRating() : 4.5 %></span>
                        <span class="price">₹<%= menu.getPrice() %></span>
                    </div>
                    <a href="menu?restaurantId=<%= menu.getRestaurantID() %>#menu-item-<%= menu.getMenuID() %>" class="btn-view-menu">
                        <i class="fa-solid fa-arrow-right-to-bracket"></i> View in Menu
                    </a>
                </div>
            </div>
        <%  }
           } %>
    </div>

    <% if (results == null || results.isEmpty()) { %>
    <div class="empty-state">
        <i class="fa-solid fa-magnifying-glass"></i>
        <h3>No Results Found</h3>
        <p>We couldn't find any food items matching your search. Try different keywords!</p>
    </div>
    <% } %>

    <script src="app.js"></script>
    <script>
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
        document.addEventListener('DOMContentLoaded', function() {
            const query = "<%= q.replace("\"", "\\\"") %>";
            const topSearch = document.getElementById('top-food-search');
            if (topSearch && query) {
                topSearch.value = query;
            }
        });
    </script>
</body>
</html>
