




DROP TABLE IF EXISTS `menu`;


CREATE TABLE `menu` (
  `menuID` int NOT NULL AUTO_INCREMENT,
  `RestaurantID` int DEFAULT NULL,
  `ItemName` varchar(45) DEFAULT NULL,
  `Description` text,
  `Price` decimal(10,0) DEFAULT NULL,
  `IsAvailable` tinyint DEFAULT NULL,
  `ImagePath` varchar(45) DEFAULT NULL,
  `Rating` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`menuID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `menu` WRITE;

INSERT INTO `menu` VALUES (1,1,'Mini Tiffin','Delicious Mini Tiffin',120,1,'images/menu/mini_tiffin.jpg',4.8),(2,1,'Kambu Dosa','Delicious Kambu Dosa',150,1,'images/menu/kambu_dosa.jpg',4.7),(3,1,'Mutton Chukka','Delicious Mutton Chukka',180,1,'images/menu/mutton_chukka.jpg',4.9),(4,1,'Chicken Curry','Delicious Chicken Curry',200,1,'images/menu/chicken_curry.jpg',4.8),(5,1,'Parotta','Delicious Parotta',220,1,'images/menu/parotta.jpg',4.6),(6,1,'Idiyappam','Delicious Idiyappam',250,1,'images/menu/idiyappam.jpg',4.7),(7,1,'Prawn Masala','Delicious Prawn Masala',280,1,'images/menu/prawn_masala.jpg',4.9),(8,1,'Filter Coffee','Delicious Filter Coffee',300,1,'images/menu/filter_coffee.jpg',4.8),(9,1,'Curd Rice','Delicious Curd Rice',350,1,'images/menu/curd_rice.jpg',4.6),(10,1,'Kesari','Delicious Kesari',400,1,'images/menu/kesari.jpg',4.5),(11,2,'Smoked Tomato Rasam','Delicious Smoked Tomato Rasam',120,1,'images/menu/smoked_tomato_rasam.jpg',4.9),(12,2,'Truffle Dosa','Delicious Truffle Dosa',150,1,'images/menu/truffle_dosa.jpg',4.8),(13,2,'Lobster Curry','Delicious Lobster Curry',180,1,'images/menu/lobster_curry.jpg',5.0),(14,2,'Lamb Pepper Fry','Delicious Lamb Pepper Fry',200,1,'images/menu/lamb_pepper_fry.jpg',4.9),(15,2,'Malabar Fish','Delicious Malabar Fish',220,1,'images/menu/malabar_fish.jpg',4.8),(16,2,'Stuffed Kulcha','Delicious Stuffed Kulcha',250,1,'images/menu/stuffed_kulcha.jpg',4.7),(17,2,'Mushroom Roast','Delicious Mushroom Roast',280,1,'images/menu/mushroom_roast.jpg',4.8),(18,2,'Tender Coconut Payasam','Delicious Tender Coconut Payasam',300,1,'images/menu/tender_coconut_payasam.jpg',4.9),(19,2,'Chocolate Sphere','Delicious Chocolate Sphere',350,1,'images/menu/chocolate_sphere.jpg',4.8),(20,2,'Herbal Tea','Delicious Herbal Tea',400,1,'images/menu/herbal_tea.jpg',4.6),(21,3,'Paneer Butter Masala','Delicious Paneer Butter Masala',120,1,'images/menu/paneer_butter_masala.jpg',4.8),(22,3,'Veg Biryani','Delicious Veg Biryani',150,1,'images/menu/veg_biryani.jpg',4.7),(23,3,'Dal Makhani','Delicious Dal Makhani',180,1,'images/menu/dal_makhani.jpg',4.7),(24,3,'Butter Naan','Delicious Butter Naan',200,1,'images/menu/butter_naan.jpg',4.6),(25,3,'Palak Paneer','Delicious Palak Paneer',220,1,'images/menu/palak_paneer.jpg',4.8),(26,3,'Veg Pulao','Delicious Veg Pulao',250,1,'images/menu/veg_pulao.jpg',4.6),(27,3,'Gobi Manchurian','Delicious Gobi Manchurian',280,1,'images/menu/gobi_manchurian.jpg',4.7),(28,3,'Jeera Rice','Delicious Jeera Rice',300,1,'images/menu/jeera_rice.jpg',4.5),(29,3,'Gulab Jamun','Delicious Gulab Jamun',350,1,'images/menu/gulab_jamun.jpg',4.8),(30,3,'Lassi','Delicious Lassi',400,1,'images/menu/lassi.jpg',4.7),(31,4,'Appam','Delicious Appam',120,1,'images/menu/appam.jpg',4.8),(32,4,'Vegetable Stew','Delicious Vegetable Stew',150,1,'images/menu/vegetable_stew.jpg',4.7),(33,4,'Meen Pollichathu','Delicious Meen Pollichathu',180,1,'images/menu/meen_pollichathu.jpg',4.9),(34,4,'Kerala Parotta','Delicious Kerala Parotta',200,1,'images/menu/kerala_parotta.jpg',4.8),(35,4,'Chicken Roast','Delicious Chicken Roast',220,1,'images/menu/chicken_roast.jpg',4.8),(36,4,'Fish Curry','Delicious Fish Curry',250,1,'images/menu/fish_curry.jpg',4.9),(37,4,'Puttu Kadala','Delicious Puttu Kadala',280,1,'images/menu/puttu_kadala.jpg',4.7),(38,4,'Coconut Payasam','Delicious Coconut Payasam',300,1,'images/menu/coconut_payasam.jpg',4.8),(39,4,'Rasam','Delicious Rasam',350,1,'images/menu/rasam.jpg',4.6),(40,4,'Filter Coffee','Delicious Filter Coffee',400,1,'images/menu/filter_coffee.jpg',4.8),(41,5,'Ghee Roast Dosa','Delicious Ghee Roast Dosa',120,1,'images/menu/ghee_roast_dosa.jpg',4.9),(42,5,'Pongal','Delicious Pongal',150,1,'images/menu/pongal.jpg',4.7),(43,5,'Chettinad Chicken','Delicious Chettinad Chicken',180,1,'images/menu/chettinad_chicken.jpg',4.8),(44,5,'Mutton Biryani','Delicious Mutton Biryani',200,1,'images/menu/mutton_biryani.jpg',4.9),(45,5,'Pepper Chicken','Delicious Pepper Chicken',220,1,'images/menu/pepper_chicken.jpg',4.8),(46,5,'Tomato Rice','Delicious Tomato Rice',250,1,'images/menu/tomato_rice.jpg',4.6),(47,5,'Lemon Rice','Delicious Lemon Rice',280,1,'images/menu/lemon_rice.jpg',4.6),(48,5,'Mysore Pak','Delicious Mysore Pak',300,1,'images/menu/mysore_pak.jpg',4.7),(49,5,'Medu Vada','Delicious Medu Vada',350,1,'images/menu/medu_vada.jpg',4.7),(50,5,'Badam Milk','Delicious Badam Milk',400,1,'images/menu/badam_milk.jpg',4.6),(51,6,'Avocado Toast','Delicious Avocado Toast',120,1,'images/menu/avocado_toast.jpg',4.8),(52,6,'Pancakes','Delicious Pancakes',150,1,'images/menu/pancakes.jpg',4.7),(53,6,'Veg Sandwich','Delicious Veg Sandwich',180,1,'images/menu/veg_sandwich.jpg',4.6),(54,6,'Pasta Alfredo','Delicious Pasta Alfredo',200,1,'images/menu/pasta_alfredo.jpg',4.8),(55,6,'Margherita Pizza','Delicious Margherita Pizza',220,1,'images/menu/margherita_pizza.jpg',4.9),(56,6,'Caesar Salad','Delicious Caesar Salad',250,1,'images/menu/caesar_salad.jpg',4.7),(57,6,'Cold Coffee','Delicious Cold Coffee',280,1,'images/menu/cold_coffee.jpg',4.8),(58,6,'Brownie','Delicious Brownie',300,1,'images/menu/brownie.jpg',4.9),(59,6,'Garlic Bread','Delicious Garlic Bread',350,1,'images/menu/garlic_bread.jpg',4.7),(60,6,'Chocolate Shake','Delicious Chocolate Shake',400,1,'images/menu/chocolate_shake.jpg',4.8),(61,7,'South Indian Meals','Delicious South Indian Meals',120,1,'images/menu/south_indian_meals.jpg',4.9),(62,7,'Sambar Rice','Delicious Sambar Rice',150,1,'images/menu/sambar_rice.jpg',4.7),(63,7,'Lemon Rice','Delicious Lemon Rice',180,1,'images/menu/lemon_rice.jpg',4.6),(64,7,'Coconut Rice','Delicious Coconut Rice',200,1,'images/menu/coconut_rice.jpg',4.7),(65,7,'Vegetable Kurma','Delicious Vegetable Kurma',220,1,'images/menu/vegetable_kurma.jpg',4.8),(66,7,'Chapati','Delicious Chapati',250,1,'images/menu/chapati.jpg',4.5),(67,7,'Vegetable Biryani','Delicious Vegetable Biryani',280,1,'images/menu/vegetable_biryani.jpg',4.8),(68,7,'Curd Rice','Delicious Curd Rice',300,1,'images/menu/curd_rice.jpg',4.6),(69,7,'Payasam','Delicious Payasam',350,1,'images/menu/payasam.jpg',4.8),(70,7,'Masala Buttermilk','Delicious Masala Buttermilk',400,1,'images/menu/masala_buttermilk.jpg',4.7),(71,8,'Chicken 65','Delicious Chicken 65',120,1,'images/menu/chicken_65.jpg',4.9),(72,8,'Hyderabadi Biryani','Delicious Hyderabadi Biryani',150,1,'images/menu/hyderabadi_biryani.jpg',4.9),(73,8,'Egg Fried Rice','Delicious Egg Fried Rice',180,1,'images/menu/egg_fried_rice.jpg',4.7),(74,8,'Chilli Chicken','Delicious Chilli Chicken',200,1,'images/menu/chilli_chicken.jpg',4.8),(75,8,'Paneer Tikka','Delicious Paneer Tikka',220,1,'images/menu/paneer_tikka.jpg',4.8),(76,8,'Butter Chicken','Delicious Butter Chicken',250,1,'images/menu/butter_chicken.jpg',4.9),(77,8,'Garlic Naan','Delicious Garlic Naan',280,1,'images/menu/garlic_naan.jpg',4.6),(78,8,'Tandoori Chicken','Delicious Tandoori Chicken',300,1,'images/menu/tandoori_chicken.jpg',4.8),(79,8,'Falooda','Delicious Falooda',350,1,'images/menu/falooda.jpg',4.7),(80,8,'Fresh Lime Soda','Delicious Fresh Lime Soda',400,1,'images/menu/fresh_lime_soda.jpg',4.6),(81,9,'Chole Bhature','Delicious Chole Bhature',120,1,'images/menu/chole_bhature.jpg',4.8),(82,9,'Rajma Chawal','Delicious Rajma Chawal',150,1,'images/menu/rajma_chawal.jpg',4.7),(83,9,'Paneer Tikka','Delicious Paneer Tikka',180,1,'images/menu/paneer_tikka.jpg',4.8),(84,9,'Dal Fry','Delicious Dal Fry',200,1,'images/menu/dal_fry.jpg',4.6),(85,9,'Butter Naan','Delicious Butter Naan',220,1,'images/menu/butter_naan.jpg',4.7),(86,9,'Veg Kofta','Delicious Veg Kofta',250,1,'images/menu/veg_kofta.jpg',4.8),(87,9,'Jeera Rice','Delicious Jeera Rice',280,1,'images/menu/jeera_rice.jpg',4.5),(88,9,'Kaju Curry','Delicious Kaju Curry',300,1,'images/menu/kaju_curry.jpg',4.8),(89,9,'Jalebi','Delicious Jalebi',350,1,'images/menu/jalebi.jpg',4.9),(90,9,'Mango Lassi','Delicious Mango Lassi',400,1,'images/menu/mango_lassi.jpg',4.8),(91,10,'Cappuccino','Delicious Cappuccino',120,1,'images/menu/cappuccino.jpg',4.8),(92,10,'Latte','Delicious Latte',150,1,'images/menu/latte.jpg',4.7),(93,10,'Mocha','Delicious Mocha',180,1,'images/menu/mocha.jpg',4.7),(94,10,'Club Sandwich','Delicious Club Sandwich',200,1,'images/menu/club_sandwich.jpg',4.8),(95,10,'Veg Burger','Delicious Veg Burger',220,1,'images/menu/veg_burger.jpg',4.7),(96,10,'Chicken Burger','Delicious Chicken Burger',250,1,'images/menu/chicken_burger.jpg',4.8),(97,10,'French Fries','Delicious French Fries',280,1,'images/menu/french_fries.jpg',4.6),(98,10,'Pasta Arrabbiata','Delicious Pasta Arrabbiata',300,1,'images/menu/pasta_arrabbiata.jpg',4.7),(99,10,'Blueberry Cheesecake','Delicious Blueberry Cheesecake',350,1,'images/menu/blueberry_cheesecake.jpg',4.9),(100,10,'Cold Coffee','Delicious Cold Coffee',400,1,'images/menu/cold_coffee.jpg',4.8);

UNLOCK TABLES;




DROP TABLE IF EXISTS `orderitem`;


CREATE TABLE `orderitem` (
  `orderItem_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  `ItemTotal` decimal(10,0) DEFAULT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`orderItem_id`,`order_id`,`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `orderitem` WRITE;

INSERT INTO `orderitem` VALUES (1,6,1,150,92),(2,7,1,250,66),(3,7,1,280,67),(4,8,1,250,66),(5,8,1,280,67),(6,8,1,120,61),(7,9,1,180,73),(8,9,1,200,74),(9,10,1,300,48);

UNLOCK TABLES;




DROP TABLE IF EXISTS `ordertable`;


CREATE TABLE `ordertable` (
  `User_id` int NOT NULL,
  `Order_id` int NOT NULL AUTO_INCREMENT,
  `OrderDate` datetime DEFAULT NULL,
  `TotalAmount` decimal(10,0) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `PaymentMethod` varchar(45) DEFAULT NULL,
  `restaurant_id` int DEFAULT NULL,
  UNIQUE KEY `OrderID_UNIQUE` (`Order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `ordertable` WRITE;

INSERT INTO `ordertable` VALUES (13,4,'2026-08-09 17:54:04',455,'Delivered','COD',3),(13,5,'2026-08-09 17:54:07',255,'Delivered','COD',2),(13,6,'2026-08-09 17:54:11',225,'Delivered','COD',10),(13,8,'2026-08-09 17:49:24',725,'Delivered','COD',7),(13,9,'2026-08-09 17:53:04',455,'Delivered','COD',8),(13,10,'2026-08-09 17:51:42',375,'Pending','COD',5);

UNLOCK TABLES;




DROP TABLE IF EXISTS `restaurant`;


CREATE TABLE `restaurant` (
  `restaurant_id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `CustomerType` varchar(45) DEFAULT NULL,
  `DeliveryTime` varchar(15) DEFAULT NULL,
  `Address` text,
  `Rating` double DEFAULT NULL,
  `IsActive` tinyint DEFAULT NULL,
  `ImagePath` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`restaurant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `restaurant` WRITE;

INSERT INTO `restaurant` VALUES (1,'Paati Veedu','Veg','30-40 mins','T. Nagar, Chennai',4.3,1,'images/restaurants/paati_veedu.png'),(2,'Avartana','Premium','35-45 mins','ITC Grand Chola, Guindy, Chennai',4.7,1,'images/restaurants/avartana.jpg'),(3,'J Hind','Multi Cuisine','30-40 mins','T. Nagar, Chennai',4.5,1,'images/restaurants/j_hind.jpg'),(4,'Dakshin','South Indian','35-45 mins','TTK Road, Alwarpet, Chennai',4.6,1,'images/restaurants/dakshin.jpg'),(5,'Southern Spice','South Indian','30-45 mins','Nungambakkam, Chennai',4.5,1,'images/restaurants/southern_spice.jpg'),(6,'Pumpkin Tales','Cafe','25-35 mins','Alwarpet, Chennai',4.6,1,'images/restaurants/pumpkin.jpg'),(7,'Annalakshmi','Veg','30-40 mins','Spur Tank Road, Chennai',4.5,1,'images/restaurants/annalakshmi.png'),(8,'Madras Spice','Indian','20-30 mins','Egmore, Chennai',4.5,1,'images/restaurants/madras_spice.jpg'),(9,'Pakwan Chennai','North Indian','25-35 mins','T. Nagar, Chennai',4.3,1,'images/restaurants/pakwan_chennai.jpg'),(10,'Broken Bridge Cafe','Cafe','30-40 mins','MRC Nagar, Chennai',4.6,1,'images/restaurants/broken_bridge_cafe.jpg');

UNLOCK TABLES;




DROP TABLE IF EXISTS `user`;


CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(450) DEFAULT NULL,
  `role` enum('Admin','Customer','DeliveryPartner') DEFAULT NULL,
  `createdDate` datetime DEFAULT NULL,
  `lastLogIN` datetime DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`user_id`,`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `user` WRITE;

INSERT INTO `user` VALUES (1,'sakthivel','sakthivel@gmail.com','lucifer','Customer',NULL,NULL,NULL),(9,'alex','alex@gmail.com','$2a$12$jIYFP3VJVY1ZhzRd03YltOAQuMnjTmTei0tWG82ilKMPpLuFuIS0C','Customer','2026-07-09 22:28:08','2026-07-09 22:28:08',NULL),(10,'Banner','banner@gmail.com','$2a$12$Qo08n2NXNFvdkmGpA5G1huaJbAb0JCYyRsCZ8ViskggYl5xNarBAW','Customer','2026-07-09 22:45:22','2026-07-09 22:45:22',NULL),(11,'Robert','tony@gmail.com','$2a$12$3VnG1PqAFodClzPe69vu9OHpC3RpvjcTJlMSkiezicKsjMsOF8.ci','Customer','2026-07-21 13:29:53','2026-07-21 13:29:53','newyork'),(12,'Robert','tony@gmail.com','$2a$12$qQo3/omTOkwZbXDJ4belnuASSgrdiV.6/CKe1wjjNQ878.CzwGJR2','Customer','2026-07-21 13:30:51','2026-07-21 13:30:51','newyork'),(13,'alex','alex@gmail.com','$2a$12$k2fAeJqNdQZ3zP38ZqLt6uBtG/OPhGzt4jqzMzjL4YjuThJtMYX6m','Customer','2026-07-21 13:31:18',NULL,'ariyalur\r\n | Phone: 9874563210'),(14,'steve','steve@gmail.com','$2a$12$zsV2V8hZHBVWfNdHAK/KyeCUMiucG5OY/gsE6M3bTaSNeF266a5Te','Customer','2026-07-21 13:34:38','2026-07-21 13:34:38','btm'),(15,'loki','asgard@gmail.com','$2a$12$BBFJRm.k3linZOiaavvKJe3FEJOJykVSpy3svmgWuu7sQu05wBuUi','Customer','2026-07-21 13:35:52','2026-07-21 13:35:52','btm'),(16,'loki','loki@gmail.com','$2a$12$X9UovD2ORwd4UT.Ig3r73.8JZdctVcYXWg/bJNiCNK.IWiGwxRf3W','Customer','2026-07-21 13:43:49','2026-07-21 13:43:49','tm'),(17,'steve','steve@gmail.com','$2a$12$5ZnIBJYDa0247XaPBaTK6uPmNucpC9Xe5SxTe4SUxJSJkEVVY2uSy','Customer','2026-07-21 13:45:05','2026-07-21 13:45:05','BTM'),(18,'thor','lighting@gmailcom','$2a$12$18CZ2E3sxrFZR81oYj/hAeA51ryjvOrGv8T7gPwjQx2CRlRLcwgUK','Customer','2026-07-21 13:46:42','2026-07-21 13:46:42','Asgard'),(19,'Alex','Alex123@gmail.com','$2a$12$TyM8zEOSFrh7cntORHoEFuL7QDTQyuXry192K/MzkDOUPjnGFzTaO','Customer','2026-07-27 13:30:52','2026-07-27 13:30:52','BTM'),(20,'Admin','admin@123gmail.com','$2a$12$4LLiv1w3GxGluXnVL5fmeeBjYJHDHkWm.PqX2pXqJx.9T5LlryfcW','Admin','2026-07-27 20:16:27','2026-07-27 20:16:27','BTM'),(21,'Admin123','admin@gmail.com','$2a$12$00/5Y2Op4MENQxDI9nGHJumCqvd7YgSJ8crFUojMUwNjERqDDIFxG','Admin','2026-07-28 13:22:59','2026-07-28 13:22:59','BTM'),(23,'partha','partha123@gmail.com','$2a$12$tyHUAe3xN3TgVKcrm3CFUOb6MHMlIvmKVxpSDoVJkwlUqMOaGWM/W','DeliveryPartner','2026-07-28 16:13:38','2026-07-28 16:13:38','BTM');

UNLOCK TABLES;








