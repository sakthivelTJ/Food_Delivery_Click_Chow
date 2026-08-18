# 🍔 ClickChow

### A Modern Full-Stack Food Delivery Platform Built with Java EE

<p align="center">
  <strong>Discover • Order • Track • Deliver</strong>
</p>

<p align="center">
  A production-ready food delivery platform with role-based portals, smart search, intelligent cart management, order tracking, secure authentication, and Docker-ready cloud deployment.
</p>

<p align="center">

[![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge\&logo=openjdk)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-Servlet%206.0-blue?style=for-the-badge)](https://jakarta.ee/)
[![Tomcat](https://img.shields.io/badge/Tomcat-10.1-F8DC75?style=for-the-badge\&logo=apachetomcat\&logoColor=black)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-4479A1?style=for-the-badge\&logo=mysql\&logoColor=white)](https://www.mysql.com/)
[![Maven](https://img.shields.io/badge/Maven-3.9+-C71A36?style=for-the-badge\&logo=apachemaven\&logoColor=white)](https://maven.apache.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge\&logo=docker\&logoColor=white)](https://www.docker.com/)

</p>

<p align="center">

**[🌐 Live Demo]([#-live-demo](https://fooddeliveryclickchow-production.up.railway.app/))** •
**[📸 Screenshots](#-screenshots)** •
**[🛠️ Tech Stack](#️-technology-stack)** •
**[🚀 Getting Started](#-getting-started)**

</p>

---

## ✨ Overview

**ClickChow** is a full-stack online food delivery platform developed using **Java EE, JSP, Servlets, JDBC, MySQL, HTML, CSS, and JavaScript**.

The application provides a complete food ordering ecosystem connecting:

* 🛍️ Customers
* ⚙️ Administrators
* 🚴 Delivery Partners
* 🍽️ Restaurants
* 📦 Orders
* 💳 Payments

The platform follows a clean **MVC + DAO architecture**, providing separation between presentation, controller logic, data access, and database operations.

Designed with a modern **dark-mode glassmorphism interface**, ClickChow combines a polished frontend experience with a structured Java backend and cloud-ready Docker deployment.

---

# 🌟 Why ClickChow?

| Capability               | What ClickChow Provides                           |
| ------------------------ | ------------------------------------------------- |
| 🎨 Modern UI             | Dark mode, glassmorphism, gradients & animations  |
| 👥 Multi-Role System     | Customer, Admin & Delivery Partner portals        |
| 🔍 Smart Search          | Real-time food & restaurant search                |
| 🛒 Intelligent Cart      | Restaurant collision prevention & live updates    |
| 📦 Order Tracking        | Complete order lifecycle tracking                 |
| 🔐 Secure Authentication | BCrypt + sessions + RBAC                          |
| 📊 Admin Analytics       | Revenue & order monitoring                        |
| 🚴 Delivery System       | Order assignment & delivery workflow              |
| 📱 Responsive Design     | Mobile, tablet & desktop support                  |
| 🐳 Docker Ready          | Multi-stage containerized deployment              |
| ☁️ Cloud Ready           | Supports environment-based database configuration |

---

# 🎯 Core Features

## 🛍️ Customer Portal

### 🍽️ Restaurant Discovery

* Browse available restaurants
* Restaurant ratings
* Cuisine information
* Estimated delivery time
* Restaurant availability
* Featured restaurant section

### 🔍 Smart Food Search

* Global food search
* Restaurant search
* Live autocomplete
* Search suggestions
* Instant search results
* Direct navigation to restaurants/menu items

### 🍔 Menu Browsing

* Restaurant-specific menus
* Food images
* Food descriptions
* Item ratings
* Dynamic pricing
* Availability status
* In-stock / out-of-stock handling

### 🛒 Smart Cart

* Slide-out cart drawer
* Add/remove items
* Increase/decrease quantity
* Real-time cart updates
* Delivery fee calculation
* GST calculation
* Grand total calculation
* Restaurant collision prevention
* Multi-tab synchronization

> 💡 ClickChow prevents customers from accidentally mixing items from different restaurants inside the same cart.

### 💳 Checkout & Payments

Supported payment options:

* 💵 Cash on Delivery
* 📱 UPI

  * Google Pay
  * PhonePe
  * Paytm
* 💳 Credit Card
* 💳 Debit Card

### 📦 Order Tracking

Track the complete order lifecycle:

```text
Pending
   ↓
Confirmed
   ↓
Preparing
   ↓
Out for Delivery
   ↓
Delivered
```

### 🔄 Reorder

Customers can quickly reorder previously purchased items directly from their order history.

### 🧾 Printable Invoices

Generate and print browser-based order receipts containing:

* Order details
* Customer information
* Restaurant information
* Ordered items
* Quantity
* Pricing
* Taxes
* Delivery charges
* Final amount

### 👤 Profile Management

Customers can manage:

* Username
* Email
* Delivery address
* Password

Passwords are securely re-hashed using BCrypt when changed.

### 🌙 Theme System

* Dark mode
* Light mode
* LocalStorage persistence
* Smooth theme transitions

---

# ⚙️ Admin Portal

The Admin Dashboard provides centralized control over the entire platform.

### 🍽️ Restaurant Management

* Add restaurants
* Edit restaurant details
* Manage availability
* Update restaurant information

### 🍔 Menu Management

Complete CRUD operations:

* Add menu items
* Edit menu items
* Update prices
* Update descriptions
* Manage images
* Toggle stock availability
* Delete menu items

### 👥 User Management

Administrators can:

* View users
* Create users
* Delete accounts
* Assign roles
* Manage Customer accounts
* Manage Admin accounts
* Manage Delivery Partner accounts

Self-deletion protection prevents administrators from accidentally deleting their own active account.

### 📦 Order Fulfillment

Admins can:

* View platform-wide orders
* Monitor order statuses
* Update order status
* Track pending orders
* Track completed orders
* Monitor delivery progress

### 📊 Financial Dashboard

Track:

* Total revenue
* Total orders
* Pending orders
* Completed orders
* Platform order volume
* Revenue performance

---

# 🚴 Delivery Partner Portal

ClickChow includes a dedicated delivery management system.

### 🟢 Duty Management

Delivery partners can switch between:

```text
🟢 ONLINE
🔴 OFFLINE
```

The dashboard provides a live availability indicator.

### 📡 Live Order Feed

When online, the application automatically polls for available delivery orders.

**Polling interval:** 4 seconds

### 📦 Order Acceptance

Delivery partners can:

* View available orders
* Accept orders
* View restaurant pickup information
* View customer delivery information
* Access customer contact information

### 🚚 Delivery Tracking

Three-stage delivery workflow:

```text
Accepted
   ↓
Picked Up
   ↓
Delivered
```

### 📞 Click-to-Call

Customer phone numbers can be accessed through a direct phone link.

### 💰 Earnings Dashboard

Delivery partners can view:

* Daily earnings
* Completed deliveries
* Delivery history
* Commission breakdown

The platform calculates a **15% delivery partner commission** on delivered orders.

---

# 🔐 Security

Security is implemented throughout the application.

### 🔒 BCrypt Password Hashing

Passwords are never stored as plain text.

The application uses **jBCrypt** for secure password hashing.

### 🔑 Session Authentication

Server-side session management is used for authenticated users.

### 👮 Role-Based Access Control

Protected functionality is separated by role:

```text
CUSTOMER
   │
   ├── Browse
   ├── Search
   ├── Cart
   ├── Checkout
   └── Orders


ADMIN
   │
   ├── Restaurants
   ├── Menus
   ├── Users
   ├── Orders
   └── Analytics


DELIVERY PARTNER
   │
   ├── Duty Status
   ├── Available Orders
   ├── Delivery Tracking
   └── Earnings
```

### 🛡️ SQL Injection Protection

DAO operations use parameterized `PreparedStatement` queries.

### 🧹 XSS Protection

Dynamic content is protected through JSON and HTML escaping where required.

### 🍪 Remember Me

Cookie-based persistent login functionality allows users to remain authenticated across sessions.

---

# 🏗️ Architecture

ClickChow follows the **MVC + DAO architecture**.

```text
                    ┌──────────────────────┐
                    │      Browser         │
                    │ HTML / CSS / JS / JSP│
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │      Servlets        │
                    │     Controllers      │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │     DAO Layer        │
                    │ Database Operations  │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │       JDBC           │
                    │ Connection Manager   │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │       MySQL          │
                    │ Database + Seed Data │
                    └──────────────────────┘
```

### 📁 Project Structure

```text
ClickChow/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/tap/
│       │       ├── model/
│       │       │   ├── User.java
│       │       │   ├── Restaurant.java
│       │       │   ├── Menu.java
│       │       │   ├── Order.java
│       │       │   └── Cart.java
│       │       │
│       │       ├── dao/
│       │       │   └── DAO Interfaces
│       │       │
│       │       ├── daoIMP/
│       │       │   └── DAO Implementations
│       │       │
│       │       ├── utility/
│       │       │   └── DBconnection.java
│       │       │
│       │       └── *Servlet.java
│       │
│       └── webapp/
│           ├── index.jsp
│           ├── menu.jsp
│           ├── cart.jsp
│           ├── checkOut.jsp
│           ├── orderConfirmed.jsp
│           ├── orderHistory.jsp
│           ├── searchResults.jsp
│           ├── login.jsp
│           ├── register.html
│           ├── editProfile.jsp
│           ├── adminMenu.jsp
│           ├── adminUsers.jsp
│           ├── adminCart.jsp
│           ├── deliveryApp.jsp
│           ├── app.js
│           ├── index.css
│           └── assets/
│               └── images/
│
├── schema.sql
├── Dockerfile
├── pom.xml
└── README.md
```

---

# 🛠️ Technology Stack

| Layer              | Technology                         |
| ------------------ | ---------------------------------- |
| 💻 Language        | Java 21                            |
| 🏛️ Backend        | Jakarta Servlet 6.0                |
| 🖥️ View           | Jakarta JSP 3.1                    |
| 🌐 Server          | Apache Tomcat 10.1                 |
| 🗄️ Database       | MySQL 8.0+                         |
| 🔌 Database Driver | MySQL Connector/J 9.2.0            |
| 🔐 Security        | jBCrypt 0.4                        |
| 🎨 Frontend        | HTML5, CSS3                        |
| ⚡ Client Logic     | Vanilla JavaScript ES6             |
| 🎨 Icons           | Font Awesome 6                     |
| 🔤 Typography      | Google Fonts — Outfit              |
| 🏗️ Architecture   | MVC + DAO                          |
| 📦 Build           | Apache Maven                       |
| 🐳 Deployment      | Docker                             |
| ☁️ Cloud           | Environment-based DB Configuration |

---

# 📸 Screenshots

> Add your actual screenshots below to make the repository visually impressive.

### 🏠 Landing Page

![ClickChow Home](screenshots/home.png)

### 🍽️ Restaurant Menu

![Restaurant Menu](screenshots/menu.png)

### 🛒 Smart Cart

![Shopping Cart](screenshots/cart.png)

### 💳 Checkout

![Checkout](screenshots/checkout.png)

### ⚙️ Admin Dashboard

![Admin Dashboard](screenshots/admin-dashboard.png)

### 🚴 Delivery Dashboard

![Delivery Dashboard](screenshots/delivery-dashboard.png)

---

# 🎬 UI Highlights

ClickChow focuses heavily on user experience.

### Visual Design

* 🌑 Dark-first interface
* 🌅 Sunset gradient accents
* 🪟 Glassmorphism cards
* 🎞️ Animated hero background video
* 🎠 Hero carousel
* ✨ Micro animations
* 🔄 Smooth transitions
* 🧊 Modern translucent components
* 📱 Responsive layouts

### Responsive Design

The interface is designed for:

```text
📱 Mobile
   ↓
📲 Tablet
   ↓
💻 Desktop
   ↓
🖥️ Large Screens
```

---

# 🔄 Complete Customer Workflow

```text
┌─────────────┐
│   Browse    │
│    Home     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Search /   │
│ Restaurant  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    View     │
│    Menu     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│ Add Items   │
│ to Cart     │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Checkout   │
│  & Payment  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│    Order    │
│  Confirmed  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│   Admin     │
│   Updates   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Delivery   │
│   Partner   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Delivered  │
│     ✅      │
└─────────────┘
```

---

# 🚀 Getting Started

## Prerequisites

Install the following:

* Java 21+
* Apache Maven 3.9+
* MySQL 8.0+
* Apache Tomcat 10.1+

Or use Docker.

---

## 💻 Local Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/sakthivelTJ/Food_Delivery_Click_Chow.git

cd Food_Delivery_Click_Chow
```

### 2️⃣ Create Database

```bash
mysql -u root -p < schema.sql
```

### 3️⃣ Configure Database

Update:

```text
src/main/java/com/tap/utility/DBconnection.java
```

Alternatively, configure environment variables:

```text
MYSQLHOST
MYSQLPORT
MYSQLDATABASE
MYSQLUSER
MYSQLPASSWORD
```

### 4️⃣ Build Project

```bash
mvn clean package
```

### 5️⃣ Deploy to Tomcat

Copy the generated WAR file:

```bash
cp target/ROOT.war $TOMCAT_HOME/webapps/
```

### 6️⃣ Start Tomcat

Open:

```text
http://localhost:8080
```

---

# 🐳 Docker Deployment

Build the Docker image:

```bash
docker build -t clickchow .
```

Run the application:

```bash
docker run -p 8080:8080 \
  -e MYSQLHOST=your-db-host \
  -e MYSQLPORT=3306 \
  -e MYSQLDATABASE=your-db-name \
  -e MYSQLUSER=your-user \
  -e MYSQLPASSWORD=your-password \
  clickchow
```

The application will be available at:

```text
http://localhost:8080
```

---

# ☁️ Cloud Deployment

ClickChow is designed for cloud deployment using environment-based database configuration.

The application can be configured for managed MySQL services such as:

* Railway
* Render
* Heroku-compatible environments
* Other MySQL cloud providers

Database credentials should be supplied through environment variables rather than hardcoded production credentials.

---

# 🔑 Demo Accounts

| Role                | Email                    | Password      |
| ------------------- | ------------------------ | ------------- |
| 👑 Admin            | `admin@clickchow.com`    | `admin123`    |
| 🚴 Delivery Partner | `delivery@clickchow.com` | `delivery123` |
| 🛍️ Customer        | `customer@clickchow.com` | `customer123` |

> ⚠️ Demo credentials are provided only for local/testing environments. Do not use these credentials in production.

---

# 📊 Application Modules

```text
                    CLICKCHOW
                        │
       ┌────────────────┼────────────────┐
       │                │                │
       ▼                ▼                ▼
   CUSTOMER           ADMIN         DELIVERY
       │                │                │
       ├─ Search        ├─ Users       ├─ Duty
       ├─ Restaurants   ├─ Restaurants ├─ Orders
       ├─ Menu          ├─ Menus       ├─ Pickup
       ├─ Cart          ├─ Orders      ├─ Delivery
       ├─ Checkout      ├─ Revenue     └─ Earnings
       ├─ Orders        └─ Analytics
       └─ Profile
```

---

# 💡 Key Technical Highlights

Some of the most important engineering concepts implemented in ClickChow:

### Backend

* Java 21
* Jakarta Servlet
* JSP
* JDBC
* DAO pattern
* MVC architecture
* Session management
* Role-based authorization
* Prepared statements
* Environment-based configuration

### Frontend

* Responsive CSS
* CSS Grid
* Flexbox
* Vanilla ES6 JavaScript
* LocalStorage
* AJAX-style asynchronous requests
* Dynamic DOM updates
* Search autocomplete
* UI animations

### Database

* MySQL
* Relational data modeling
* Foreign key relationships
* CRUD operations
* Prepared statements
* Transaction-oriented order processing

### Deployment

* Maven packaging
* WAR deployment
* Docker multi-stage build
* Environment variables
* Cloud database compatibility

---

# 🧠 What I Learned Building ClickChow

Building ClickChow involved practical implementation of:

* Full-stack Java EE development
* MVC architecture
* DAO design pattern
* JDBC database integration
* Authentication & authorization
* Secure password handling
* Role-based access control
* REST-style asynchronous interactions
* Dynamic frontend development
* Shopping cart architecture
* Order lifecycle management
* Database-driven UI
* Docker containerization
* Cloud deployment configuration
* Responsive UI engineering
* Debugging production-style backend issues

---

# 🗺️ Future Improvements

Potential future enhancements include:

* 📍 GPS-based delivery tracking
* 🗺️ Google Maps integration
* 🔔 Push notifications
* 💳 Real payment gateway integration
* 📧 Email order notifications
* 📱 Progressive Web App support
* ⭐ Restaurant reviews & ratings
* 🎁 Coupon and discount system
* 🤖 AI-powered food recommendations
* 📈 Advanced analytics dashboard
* 🔄 WebSocket-based real-time order updates
* 🧾 Advanced PDF invoice generation

---

# 👨‍💻 Author

## Sakthivel TJ

**Java Full Stack Developer | Java | JSP | Servlets | JDBC | MySQL | JavaScript**

I'm passionate about building practical full-stack applications and continuously improving my skills in Java backend development, databases, frontend engineering, and cloud deployment.

### 🔗 Connect With Me

**GitHub:** [@sakthivelTJ](https://github.com/sakthivelTJ)

**Project Repository:**
https://github.com/sakthivelTJ/Food_Delivery_Click_Chow

---

# ⭐ Support

If you found **ClickChow** useful or interesting:

⭐ Give the repository a star
🍴 Fork the project
🐛 Report issues
💡 Suggest improvements
🤝 Contribute to the project

---

# 📄 License

This project is open source and available for **learning, experimentation, and reference purposes**.

---

<p align="center">

### 🍔 ClickChow

**From craving to doorstep — simplified.**

⭐ **Built with Java • Designed with passion • Deployed with Docker** ⭐

</p>
