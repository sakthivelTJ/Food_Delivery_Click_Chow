-- ClickChow Database Schema & Initial Seed Data

-- 1. Create User Table
CREATE TABLE IF NOT EXISTS user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'Customer',
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastLogIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    address TEXT,
    phoneNumber VARCHAR(20) DEFAULT NULL
);

-- 2. Create Restaurant Table
CREATE TABLE IF NOT EXISTS restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    CustomerType VARCHAR(100),
    deliveryTime VARCHAR(50),
    address TEXT,
    rating DOUBLE DEFAULT 4.5,
    isActive BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255)
);

-- 3. Create Menu Table
CREATE TABLE IF NOT EXISTS menu (
    menuID INT AUTO_INCREMENT PRIMARY KEY,
    restaurantID INT NOT NULL,
    itemName VARCHAR(150) NOT NULL,
    description TEXT,
    price DOUBLE NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(255),
    Rating DOUBLE DEFAULT 4.8,
    FOREIGN KEY (restaurantID) REFERENCES restaurant(restaurant_id) ON DELETE CASCADE
);

-- 4. Create Order Table
CREATE TABLE IF NOT EXISTS ordertable (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalAmount DOUBLE NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    paymentMethod VARCHAR(50) DEFAULT 'Card',
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(restaurant_id) ON DELETE CASCADE
);

-- 5. Create Order Item Table
CREATE TABLE IF NOT EXISTS orderitem (
    orderItem_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    itemTotal DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES ordertable(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(menuID) ON DELETE CASCADE
);

-- SEED INITIAL DATA FOR RESTAURANTS
INSERT INTO restaurant (restaurant_id, name, CustomerType, deliveryTime, address, rating, isActive, imagePath) VALUES
(1, 'Annalakshmi Restaurant', 'South Indian, Veg', '20-30 mins', 'Cathedral Road, Chennai', 4.8, true, 'images/restaurants/annalakshmi.png'),
(2, 'Avartana - ITC Grand Chola', 'Luxury South Indian', '30-40 mins', 'Guindy, Chennai', 4.9, true, 'images/restaurants/avartana.jpg'),
(3, 'Paati Veedu', 'Traditional Tamil', '25-35 mins', 'T. Nagar, Chennai', 4.7, true, 'images/restaurants/paati_veedu.png'),
(4, 'Southern Spice', 'South & Chettinad', '25-35 mins', 'Nungambakkam, Chennai', 4.8, true, 'images/restaurants/southern_spice.jpg'),
(5, 'Pakwan Chennai', 'North Indian, Mughlai', '30-40 mins', 'T. Nagar, Chennai', 4.6, true, 'images/restaurants/pakwan_chennai.jpg')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- SEED INITIAL DATA FOR MENU ITEMS
INSERT INTO menu (menuID, restaurantID, itemName, description, price, isAvailable, imagePath, Rating) VALUES
(1, 1, 'Hyderabadi Dum Biryani', 'Fragrant basmati rice cooked with authentic spices and succulent paneer/veggies.', 299.0, true, 'assets/images/biryani.png', 4.9),
(2, 1, 'Gourmet Cheese Burger', 'Juicy grilled patty topped with melted cheddar, lettuce & house special sauce.', 199.0, true, 'assets/images/burger.png', 4.8),
(3, 1, 'Supreme Pepperoni Pizza', 'Hand-tossed crust with rich tomato sauce, mozzarella & spicy toppings.', 349.0, true, 'assets/images/pizza.png', 4.9),
(4, 2, 'Paneer Tikka Masala', 'Char-grilled cottage cheese cubes simmered in rich spiced cream gravy.', 240.0, true, 'assets/images/paneertikka.png', 4.7),
(5, 2, 'Dragon Salmon Roll', 'Fresh sushi rolled with avocado, cucumber & Japanese spicy mayo.', 450.0, true, 'assets/images/sushi.png', 4.9),
(6, 3, 'Belgian Choco Lava Cake', 'Warm chocolate cake filled with molten dark chocolate center.', 150.0, true, 'assets/images/dessert.png', 4.9)
ON DUPLICATE KEY UPDATE itemName=VALUES(itemName);

-- SEED INITIAL DEMO ACCOUNTS
INSERT INTO user (user_id, user_name, email, password, role, address) VALUES
(1, 'admin', 'admin@clickchow.com', 'admin123', 'Admin', 'ClickChow HQ, Chennai'),
(2, 'delivery', 'delivery@clickchow.com', 'delivery123', 'Delivery Partner', 'Central Hub, Chennai'),
(3, 'customer', 'customer@clickchow.com', 'customer123', 'Customer', 'T. Nagar, Chennai')
ON DUPLICATE KEY UPDATE user_name=VALUES(user_name);
