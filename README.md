# 🍔 ClickChow — Online Food Delivery Platform

<p align="center">
  <img src="https://img.shields.io/badge/Java-21-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white" />
  <img src="https://img.shields.io/badge/Jakarta_EE-Servlets_&_JSP-0074BD?style=for-the-badge&logo=eclipse&logoColor=white" />
  <img src="https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white" />
  <img src="https://img.shields.io/badge/Tomcat-10.1-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black" />
  <img src="https://img.shields.io/badge/Maven-Build-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white" />
  <img src="https://img.shields.io/badge/Docker-Containerized-2496ED?style=for-the-badge&logo=docker&logoColor=white" />
</p>

<p align="center">
  <b>A full-stack food delivery web application built with Java EE, featuring three role-based portals — Customer, Admin & Delivery Partner — with a modern glassmorphism UI, real-time order tracking, and cloud-ready Docker deployment.</b>
</p>

<p align="center">
  🌐 <a href="https://fooddeliveryclickchow-production.up.railway.app/"><b>Live Demo</b></a> &nbsp;·&nbsp;
  📸 <a href="#screenshots"><b>Screenshots</b></a> &nbsp;·&nbsp;
  🛠️ <a href="#tech-stack"><b>Tech Stack</b></a> &nbsp;·&nbsp;
  🚀 <a href="#getting-started"><b>Getting Started</b></a>
</p>

---

## 📖 About The Project

**ClickChow** is a production-ready, end-to-end online food delivery platform where customers can browse restaurants, search dishes, build carts, and place orders with multiple payment options — all through a sleek, responsive dark-mode interface.

The platform follows the **MVC (Model-View-Controller)** architecture with a clean **DAO (Data Access Object)** pattern, ensuring a well-structured separation between the presentation layer, business logic, and database operations.

### 🎯 What Makes ClickChow Special?

- 🎨 **Stunning UI/UX** — Dark theme with sunset gradients, glassmorphism effects, animated hero carousel with looping background video, micro-animations, and smooth transitions throughout
- 👥 **Three Dedicated Portals** — Separate dashboards for Customers, Admins, and Delivery Partners with role-based access control
- 🔍 **Real-Time Search** — Live autocomplete search across all food items and restaurants with deep-linking to specific menu items
- 🛒 **Smart Cart System** — Slide-out cart drawer with collision detection (prevents mixing items from different restaurants), real-time quantity adjusters, and multi-tab synchronization
- 📱 **Fully Responsive** — Pixel-perfect layouts across Mobile, Tablet, and Desktop devices
- 🐳 **Cloud-Ready** — Dockerized multi-stage build with automatic cloud database detection (Railway, Render, Heroku, etc.)

---

## ✨ Features

### 🛍️ Customer Portal
| Feature | Description |
|---------|-------------|
| **Restaurant Discovery** | Browse featured restaurants with ratings, cuisine tags, and estimated delivery times |
| **Food Search** | Global real-time autocomplete search across all menus with instant results |
| **Menu Browsing** | View restaurant-specific menus with dish images, ratings, prices, and descriptions |
| **Smart Cart** | Slide-out cart drawer with quantity controls, delivery fee & GST breakdown, and restaurant collision prevention |
| **Secure Checkout** | Multiple payment methods — Cash on Delivery, UPI (GPay/PhonePe/Paytm), Credit/Debit Card |
| **Order Tracking** | Full order history with status tracking (Pending → Confirmed → Preparing → Out for Delivery → Delivered) |
| **Reorder** | One-click reorder from order history |
| **Printable Invoices** | Generate and print order receipts directly from the browser |
| **Profile Management** | Edit username, email, delivery address, and password with secure BCrypt re-hashing |
| **Theme Toggle** | Switch between Dark and Light mode with localStorage persistence |

### ⚙️ Admin Dashboard
| Feature | Description |
|---------|-------------|
| **Restaurant Management** | Add, edit, and manage restaurant profiles and availability |
| **Menu Management** | Full CRUD for menu items — add dishes, update prices, toggle in-stock/out-of-stock |
| **User Management** | View all users, assign roles (Customer/Admin/Delivery Partner), create/delete accounts with self-deletion protection |
| **Order Fulfillment** | Monitor all orders platform-wide, update statuses in real-time, view revenue analytics |
| **Financial Dashboard** | Track total platform revenue, order volumes, pending vs. completed orders |

### 🚴 Delivery Partner Portal
| Feature | Description |
|---------|-------------|
| **Duty Toggle** | Go Online/Offline with live pulse indicator |
| **Order Feed** | Auto-polling every 4 seconds for new available orders when on duty |
| **Order Acceptance** | One-click "Take Order" with customer pickup and drop-off details |
| **Delivery Tracking** | 3-stage progress tracker — `Accepted` → `Picked Up` → `Delivered` |
| **Click-to-Call** | Direct phone link to contact the customer |
| **Earnings Dashboard** | Track daily earnings with 15% partner commission on delivered orders |
| **Delivery History** | Complete log of past deliveries with earnings breakdown |

### 🔐 Security
- **BCrypt Password Hashing** — All passwords are securely hashed using jBCrypt
- **Session-Based Authentication** — Server-side session management with role validation
- **Role-Based Access Control (RBAC)** — Protected routes for Admin, Customer, and Delivery Partner
- **SQL Injection Protection** — Parameterized prepared statements across all DAO operations
- **XSS Prevention** — JSON and HTML escaping on dynamic content
- **Cookie-Based "Remember Me"** — Persistent login functionality

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| **Language** | Java 21 |
| **Backend Framework** | Jakarta Servlet 6.0 + Jakarta JSP 3.1 |
| **Server** | Apache Tomcat 10.1 |
| **Database** | MySQL 8.0+ with MySQL Connector/J 9.2.0 |
| **Security** | jBCrypt 0.4 for password hashing |
| **Frontend** | HTML5, CSS3 (Grid/Flexbox), Vanilla ES6 JavaScript |
| **UI Libraries** | FontAwesome 6, Google Fonts (Outfit) |
| **Build Tool** | Apache Maven |
| **Containerization** | Docker (Multi-stage build) |
| **Architecture** | MVC + DAO Pattern |

---

## 🏗️ Project Architecture

```
ClickChow/
├── src/main/java/com/tap/
│   ├── model/                    # POJOs — User, Restaurant, Menu, Order, Cart
│   ├── dao/                      # DAO Interfaces
│   ├── daoIMP/                   # DAO Implementations (JDBC)
│   ├── utility/                  # DB Connection Manager (Cloud + Local)
│   ├── *Servlet.java             # Controllers — Login, Cart, Checkout, Search, Admin, Delivery
│
├── src/main/webapp/
│   ├── index.jsp                 # Landing Page (Hero video, carousel, featured restaurants)
│   ├── menu.jsp                  # Restaurant Menu with side-cart drawer
│   ├── cart.jsp                  # Full Cart Management Page
│   ├── checkOut.jsp              # Checkout & Payment Selection
│   ├── orderConfirmed.jsp        # Order Confirmation with animation
│   ├── orderHistory.jsp          # Order History & Tracking
│   ├── searchResults.jsp         # Search Results Display
│   ├── login.jsp                 # Multi-role Login (Customer/Admin/Delivery)
│   ├── register.html             # User Registration
│   ├── editProfile.jsp           # Profile Management
│   ├── adminMenu.jsp             # Admin — Menu & Restaurant Management
│   ├── adminUsers.jsp            # Admin — User & Role Management
│   ├── adminCart.jsp              # Admin — Order & Revenue Dashboard
│   ├── deliveryApp.jsp           # Delivery Partner Dashboard
│   ├── app.js                    # Core JS — Search, Carousel, Theme, Animations
│   ├── index.css                 # Main Stylesheet (74KB+ of custom CSS)
│   └── assets/images/            # Food & Restaurant Images
│
├── schema.sql                    # Database Schema + Seed Data
├── Dockerfile                    # Multi-stage Docker Build
└── pom.xml                       # Maven Build Configuration
```

---

## 🚀 Getting Started

### Prerequisites
- **Java 21** or higher
- **Apache Maven** 3.9+
- **MySQL** 8.0+
- **Apache Tomcat** 10.1+ (or use Docker)

### Local Setup

```bash
# 1. Clone the repository
git clone https://github.com/sakthivelTJ/Food_Delivery_Click_Chow.git
cd Food_Delivery_Click_Chow

# 2. Create the database and seed data
mysql -u root -p < schema.sql

# 3. Update DB credentials in src/main/java/com/tap/utility/DBconnection.java
#    (or set environment variables: MYSQLHOST, MYSQLPORT, MYSQLDATABASE, MYSQLUSER, MYSQLPASSWORD)

# 4. Build with Maven
mvn clean package

# 5. Deploy ROOT.war to Tomcat's webapps/ directory
cp target/ROOT.war $TOMCAT_HOME/webapps/

# 6. Start Tomcat and visit
#    http://localhost:8080
```

### Docker Setup

```bash
# Build and run with Docker
docker build -t clickchow .
docker run -p 8080:8080 \
  -e MYSQLHOST=your-db-host \
  -e MYSQLPORT=3306 \
  -e MYSQLDATABASE=your-db-name \
  -e MYSQLUSER=your-user \
  -e MYSQLPASSWORD=your-password \
  clickchow
```

### Demo Accounts

| Role | Email | Password |
|------|-------|----------|
| Admin | `admin@clickchow.com` | `admin123` |
| Delivery Partner | `delivery@clickchow.com` | `delivery123` |
| Customer | `customer@clickchow.com` | `customer123` |

---

## 🔄 How It Works — User Flow

```
Customer Journey:
┌──────────┐    ┌───────────┐    ┌──────────┐    ┌──────────┐    ┌───────────┐
│  Browse   │───▶│  Select   │───▶│  Add to  │───▶│ Checkout │───▶│  Order    │
│  Home     │    │Restaurant │    │   Cart   │    │ & Pay    │    │ Confirmed │
└──────────┘    └───────────┘    └──────────┘    └──────────┘    └───────────┘
                                                                       │
Admin Updates Status ◀────────────────────────────────────────────────┘
       │
       ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│   Pending    │───▶│  Preparing   │───▶│  Out for     │───▶ ✅ Delivered
│              │    │              │    │  Delivery    │
└──────────────┘    └──────────────┘    └──────────────┘
                                              │
                          Delivery Partner ◀──┘
                          Picks Up & Delivers
```

---

## 👨‍💻 Author

**Sakthivel TJ**
- GitHub: [@sakthivelTJ](https://github.com/sakthivelTJ)

---

## 📄 License

This project is open source and available for learning and reference purposes.

---

<p align="center">
  ⭐ <b>If you found this project useful, please give it a star!</b> ⭐
</p>
