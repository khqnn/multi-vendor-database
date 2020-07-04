-- phpMyAdmin SQL 
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 18, 2020 at 01:45 PM
-- Server version: 8.0.16
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `multivendor2`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_category` (OUT `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN
INSERT INTO category(name, description) VALUES(name, description);
SELECT category_id INTO id FROM category ORDER BY category_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_comment` (OUT `id` INT, IN `comment` VARCHAR(200), IN `rating_id` INT)  NO SQL
BEGIN 
	INSERT INTO comment(comment, rating_id) VALUES(comment, rating_id);
      SELECT comment_id INTO id FROM comment ORDER BY comment_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_customer` (OUT `id` INT, IN `email` VARCHAR(30), IN `password` VARCHAR(30), IN `address` VARCHAR(100), IN `phone` VARCHAR(15), IN `country` VARCHAR(20), IN `zip` INT, IN `first_name` VARCHAR(20), IN `last_name` VARCHAR(20), IN `city` VARCHAR(20), IN `town` VARCHAR(20))  NO SQL
BEGIN

    SET @type='customer_user';
    SET @status_id='1'; 
    CALL `insert_user`(@user_id, email, password, @type, address, phone, country, zip, @status_id); 
    
    INSERT INTO customer(first_name, last_name, city, town, user_id) VALUES(first_name, last_name, city, town, @user_id); 
    SELECT customer_id INTO id FROM customer ORDER BY customer_id DESC LIMIT 1; 


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_cust_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `customer_id` INT)  NO SQL
BEGIN

    SET @type = 'cust_param';
    CALL `insert_param`(@param_id, param, value, @type); 
    
    INSERT INTO cust_param(param_id, customer_id) VALUES(@param_id, customer_id);
    
    SELECT cust_param_id INTO id FROM cust_param ORDER BY cust_param_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_discount` (IN `name` VARCHAR(30), IN `type_id` INT, IN `unit` FLOAT, IN `valid_until` DATE, IN `min_order_val` INT, IN `max_disc_val` FLOAT, OUT `id` INT)  NO SQL
BEGIN
INSERT INTO discount(name, type_id, unit, valid_until, min_order_val, max_disc_val, date) VALUES(name, type_id, unit, valid_until, min_order_val, max_disc_val, CURRENT_DATE());

SELECT discount_id INTO id FROM discount ORDER BY discount_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_district` (OUT `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN
INSERT INTO district(name, description) VALUES (name, description);

SELECT district_id INTO id FROM district ORDER BY district_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_image` (IN `id` INT, IN `image` INT)  NO SQL
BEGIN
INSERT INTO image(image, date) VALUES(image, CURRENT_DATE());

SELECT image_id INTO id FROM image ORDER BY image_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_log` (OUT `id` INT, IN `type` INT, IN `description` VARCHAR(120), IN `user` INT)  NO SQL
BEGIN
INSERT INTO log(type_id, description, date, user_id) VALUES(type, description, CURRENT_DATE(), user);

SELECT log_id INTO id FROM log ORDER BY log_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_notification` (OUT `id` INT, IN `title` VARCHAR(30), IN `summary` VARCHAR(100), IN `description` VARCHAR(500), IN `link` VARCHAR(120), IN `user` INT, IN `status` INT)  NO SQL
BEGIN
	INSERT INTO notification(title, summary, description, link, date, user_id, status_id) VALUES(title, summary, description, link, CURRENT_TIMESTAMP(), user, status);
    
    SELECT notification_id INTO id FROM notification ORDER BY notification_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_order` (OUT `id` INT, IN `gross` INT, IN `shipping_address` VARCHAR(150), IN `city` VARCHAR(20), IN `state` VARCHAR(20), IN `zip` INT, IN `status_id` INT, IN `customer_id` INT, IN `payment_id` INT, IN `shipment_id` INT, IN `discount_id` INT)  NO SQL
BEGIN
INSERT INTO orders(gross, shipping_address, city, state, zip, status_id, customer_id, payment_id, shipment_id, discount_id, date) VALUES(gross, shipping_address, city, state, zip, status_id, customer_id, payment_id, shipment_id, discount_id, CURRENT_TIMESTAMP());

SELECT order_id INTO id FROM orders ORDER BY order_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_order_det` (OUT `id` INT, IN `quantity` INT, IN `price` INT, IN `product_id` INT, IN `order_id` INT)  NO SQL
BEGIN
	INSERT INTO order_det(quantity, price, product_id, order_id) VALUES(quantity, price, product_id, order_id);
    
    SELECT order_det_id INTO id FROM order_det ORDER BY order_det_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_order_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `order_id` INT)  NO SQL
BEGIN

    SET @type = 'order_param';
    CALL `insert_param`(@param_id, param, value, @type); 
    
    INSERT INTO order_param(param_id, order_id) VALUES(@param_id, order_id);
    
    SELECT order_param_id INTO id FROM order_param ORDER BY order_param_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `type` VARCHAR(20))  NO SQL
BEGIN 
	INSERT INTO param(param, value, type) VALUES(param, value, type);
    SELECT param_id INTO id FROM param ORDER BY param_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_payment` (OUT `id` INT, IN `method` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN 
	INSERT INTO payment(method, description) VALUES(method, description);
      SELECT payment_id INTO id FROM payment ORDER BY payment_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_product` (OUT `id` INT, IN `title` VARCHAR(30), IN `description` VARCHAR(1000), IN `summary` VARCHAR(500), IN `regular_price` INT, IN `sales_price` INT, IN `sku` VARCHAR(6), IN `stock` INT, IN `min_prod_img` INT, IN `max_prod_img` INT, IN `image_id` INT, IN `discount_id` INT, IN `status_id` INT, IN `vendor_id` INT)  NO SQL
BEGIN
INSERT INTO product(title, description, summary, regular_price, sales_price, sku, stock, min_prod_img, max_prod_img, discount_id, status_id, vendor_id, date, image_id) VALUES(title, description, summary, regular_price, sales_price, sku, stock, min_prod_img, max_prod_img, discount_id, status_id, vendor_id, CURRENT_TIMESTAMP(), image_id);

SELECT product_id INTO id FROM product ORDER BY product_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prod_cat` (OUT `id` INT, IN `product_id` INT, IN `category_id` INT)  NO SQL
BEGIN
	INSERT INTO prod_cat(product_id, category_id) VALUES(product_id, category_id);
    
    SELECT prod_cat_id INTO id FROM prod_cat ORDER BY prod_cat_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prod_img` (OUT `id` INT, IN `image_id` INT, IN `product_id` INT)  NO SQL
BEGIN
	INSERT INTO prod_img(image_id, product_id) VALUES(image_id, product_id);
    SELECT prod_img_id INTO id FROM prod_img ORDER BY prod_img_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prod_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `product_id` INT)  NO SQL
BEGIN

    SET @type = 'prod_param';
    CALL `insert_param`(@param_id, param, value, @type); 
    
    INSERT INTO prod_param(param_id, product_id) VALUES(@param_id, product_id);
    
    SELECT prod_param_id INTO id FROM prod_param ORDER BY prod_param_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prod_rating` (OUT `id` INT, IN `rating` INT, IN `product_id` INT, IN `customer_id` INT)  NO SQL
BEGIN  
    SET @approved=0; 
    SET @type='product_rating';
    CALL `insert_rating`(@rating_id, rating, @approved, @type, customer_id); 
    

	INSERT INTO prod_rating(rating_id, product_id) VALUES(@rating_id, vendor_id);
      SELECT prod_rating_id INTO id FROM prod_rating ORDER BY prod_rating_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_prod_size` (OUT `id` INT, IN `product_id` INT, IN `size_id` INT)  NO SQL
BEGIN
	INSERT INTO prod_size(product_id, size_id) VALUES(product_id, size_id);
    
    SELECT prod_size_id INTO id FROM prod_size ORDER BY prod_size_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_rating` (OUT `id` INT, IN `ratingg` INT, IN `approved` INT, IN `type` VARCHAR(20), IN `customer_id` INT)  NO SQL
BEGIN 
	INSERT INTO rating(rating, approved, type, customer_id) VALUES(ratingg, approved, type, customer_id);
    SELECT rating_id INTO id FROM rating ORDER BY rating_id DESC LIMIT 1;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_role` (OUT `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN 
INSERT INTO role(name, description) VALUES(name, description);

SELECT role_id INTO id FROM role ORDER BY role_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_shipment` (OUT `id` INT, IN `method` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN 
	INSERT INTO shipment(method, description) VALUES(method, description);
      SELECT shipment_id INTO id FROM shipment ORDER BY shipment_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_size` (OUT `id` INT, IN `name` VARCHAR(20), IN `description` VARCHAR(100))  NO SQL
BEGIN
INSERT INTO size(name, description) VALUES(name, description);

SELECT size_id INTO id FROM size ORDER BY size_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_status` (OUT `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN 
	INSERT INTO status (name, description) VALUES(name, description); 
    SELECT status_id INTO id FROM status ORDER BY status_id DESC LIMIT 1; END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_type` (OUT `id` INT, IN `name` VARCHAR(30), IN `description` VARCHAR(100))  NO SQL
BEGIN 
	INSERT INTO TYPE (name, description) VALUES(name, description); 
    SELECT type_id INTO id FROM type ORDER BY type_id DESC LIMIT 1; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_user` (OUT `id` INT, IN `email` VARCHAR(30), IN `password` VARCHAR(30), IN `type` VARCHAR(20), IN `address` VARCHAR(100), IN `phone` VARCHAR(15), IN `country` VARCHAR(20), IN `zip` INT, IN `status` INT)  NO SQL
BEGIN
	INSERT INTO common_user(email, password, type, date, address, phone, country, zip, status_id) VALUES (email, PASSWORD, type, CURRENT_DATE(), address, phone, country, zip, status); 
    SELECT user_id INTO id FROM common_user ORDER BY user_id DESC LIMIT 1; 
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vendor` (OUT `id` INT, IN `email` VARCHAR(30), IN `password` VARCHAR(30), IN `address` VARCHAR(100), IN `phone` VARCHAR(15), IN `country` VARCHAR(20), IN `zip` INT, IN `full_name` VARCHAR(40), IN `slug` VARCHAR(50), IN `profile` VARCHAR(1000), IN `cnic` VARCHAR(15), IN `image` INT, IN `district` INT)  NO SQL
BEGIN 
	
    SET @type='vendor_user';
    SET @status_id='1'; 
    CALL `insert_user`(@user_id, email, password, @type, address, phone, country, zip, @status_id); 
    
    
    SET @vendor_id = 0;
    SELECT vendor_id INTO @vendor_id FROM vendor ORDER BY vendor_id DESC LIMIT 1;
    SET @vendor_id= @vendor_id +1;
    SET @role_id=1;
   INSERT INTO vendor(vendor_id, full_name, slug, profile, cnic, role_id, user_id, image_id, district_id, admin_id) VALUES(@vendor_id, full_name, slug, profile, cnic, @role_id, @user_id, image, district, @vendor_id);
    
    SELECT vendor_id INTO id FROM vendor ORDER BY vendor_id DESC LIMIT 1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vend_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `vendor_id` INT)  NO SQL
BEGIN

    SET @type = 'vend_param';
    CALL `insert_param`(@param_id, param, value, @type); 
    
    INSERT INTO vend_param(param_id, vendor_id) VALUES(@param_id, vendor_id);
    
    SELECT vend_param_id INTO id FROM vend_param ORDER BY vend_param_id DESC LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vend_rating` (OUT `id` INT, IN `rating` INT, IN `vendor_id` INT, IN `customer_id` INT)  NO SQL
BEGIN  
    SET @approved=0; 
    SET @type='vendor_rating';
    CALL `insert_rating`(@rating_id, rating, @approved, @type, customer_id); 
    

	INSERT INTO vend_rating(rating_id, vendor_id) VALUES(@rating_id, vendor_id);
      SELECT vend_rating_id INTO id FROM vend_rating ORDER BY vend_rating_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_vend_skill` (OUT `id` INT, IN `vendor_id` INT, IN `category_id` INT)  NO SQL
BEGIN
	INSERT INTO vend_skill(vendor_id, category_id) VALUES(vendor_id, category_id);
    
    SELECT vend_skill_id INTO id FROM vend_skill ORDER BY vend_skill_id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `order_param` (OUT `id` INT, IN `param` VARCHAR(30), IN `value` VARCHAR(120), IN `order_id` INT)  NO SQL
BEGIN

    SELECT type_id INTO @type_id FROM type WHERE name = 'order_param';
    CALL `insert_param`(@param_id, param, value, @type_id); 
    
    INSERT INTO order_param(param_id, order_id) VALUES(@param_id, order_id);
    
    SELECT order_param_id INTO id FROM order_param ORDER BY order_param_id DESC LIMIT 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `comment_id` int(11) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `rating_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `common_user`
--

CREATE TABLE `common_user` (
  `user_id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `town` varchar(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cust_param`
--

CREATE TABLE `cust_param` (
  `cust_param_id` int(11) NOT NULL,
  `param_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discount`
--

CREATE TABLE `discount` (
  `discount_id` int(11) NOT NULL,
  `unit` float DEFAULT NULL,
  `date` int(11) NOT NULL,
  `valid_until` date DEFAULT NULL,
  `min_order_val` int(11) DEFAULT NULL,
  `max_disc_val` float DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `district`
--

CREATE TABLE `district` (
  `district_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `district`
--

INSERT INTO `district` (`district_id`, `name`, `description`) VALUES
(1, 'Bahawalpur', 'Noor Mahal is located in Bahawalpur.');

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `image` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image_id`, `image`, `date`) VALUES
(1, 0, '2020-01-18');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `description` varchar(120) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `summary` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `link` varchar(120) DEFAULT NULL,
  `date` date NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `gross` int(11) DEFAULT NULL,
  `shipping_address` varchar(150) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `shipment_id` int(11) DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_det`
--

CREATE TABLE `order_det` (
  `quantity` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `order_det_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order_param`
--

CREATE TABLE `order_param` (
  `order_param_id` int(11) NOT NULL,
  `param_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `param`
--

CREATE TABLE `param` (
  `param_id` int(11) NOT NULL,
  `param` varchar(30) NOT NULL,
  `value` varchar(120) DEFAULT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `method` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `method`, `description`) VALUES
(1, 'cash by hand', 'Payment will be handle by hand on hand.');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `regular_price` int(11) DEFAULT NULL,
  `sales_price` int(11) DEFAULT NULL,
  `sku` varchar(6) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `min_prod_img` int(11) DEFAULT NULL,
  `max_prod_img` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prod_cat`
--

CREATE TABLE `prod_cat` (
  `prod_cat_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prod_img`
--

CREATE TABLE `prod_img` (
  `prod_img_id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prod_param`
--

CREATE TABLE `prod_param` (
  `prod_param_id` int(11) NOT NULL,
  `param_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prod_rating`
--

CREATE TABLE `prod_rating` (
  `prod_rating_id` int(11) NOT NULL,
  `rating_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prod_size`
--

CREATE TABLE `prod_size` (
  `prod_size_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `size_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

CREATE TABLE `rating` (
  `rating_id` int(11) NOT NULL,
  `approved` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `customer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `name`, `description`) VALUES
(1, 'pending_vendor', 'vendor is waiting for admin for approval.'),
(2, 'vendor_admin', 'vendor is approved by the admin and can take care of their products.'),
(3, 'vendor_manager', 'vendor is added by vendor and can look after only products related to admin.');

-- --------------------------------------------------------

--
-- Table structure for table `shipment`
--

CREATE TABLE `shipment` (
  `shipment_id` int(11) NOT NULL,
  `method` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `shipment`
--

INSERT INTO `shipment` (`shipment_id`, `method`, `description`) VALUES
(1, 'TCS Shipping', 'A third party shipping service is provided. ');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `size_id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`size_id`, `name`, `description`) VALUES
(1, 'small', 'small level size.'),
(2, 'medium', 'medium level size.'),
(3, 'large', 'large level size.');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `name`, `description`) VALUES
(1, 'user_active', 'currently active user.'),
(2, 'order_pending', 'order have been placed by the user and waiting for admin to see. '),
(5, 'order_processing', 'order have been seen by the admin and now in processing.'),
(9, 'order_delayed', 'order is delayed due to some reason. '),
(14, 'order_cancled', 'order is cancled due to some reason.');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `type_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`type_id`, `name`, `description`) VALUES
(1, 'disc_percentage', 'discount will be given on a ration to calculated bill.'),
(2, 'disc_fixed', 'a fixed amount will given as discount.'),
(3, 'add_product', 'a new product is added by a the user.'),
(7, 'remove_product', 'a product is removed by a user.'),
(12, 'update_product', 'a product is updated by a user.'),
(13, 'add_vendor_manager', 'a new vendor manager is added by a user.');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `vendor_id` int(11) NOT NULL,
  `full_name` varchar(40) NOT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `profile` varchar(1000) DEFAULT NULL,
  `cnic` varchar(15) NOT NULL,
  `user_id` int(11) NOT NULL,
  `district_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vend_param`
--

CREATE TABLE `vend_param` (
  `vend_param_id` int(11) NOT NULL,
  `param_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vend_rating`
--

CREATE TABLE `vend_rating` (
  `vend_rating_id` int(11) NOT NULL,
  `rating_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vend_skill`
--

CREATE TABLE `vend_skill` (
  `vend_skill_id` int(11) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`comment_id`),
  ADD KEY `rating_id` (`rating_id`);

--
-- Indexes for table `common_user`
--
ALTER TABLE `common_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cust_param`
--
ALTER TABLE `cust_param`
  ADD PRIMARY KEY (`cust_param_id`),
  ADD KEY `param_id` (`param_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`discount_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `district`
--
ALTER TABLE `district`
  ADD PRIMARY KEY (`district_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`),
  ADD UNIQUE KEY `image` (`image`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `shipment_id` (`shipment_id`),
  ADD KEY `discount_id` (`discount_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `order_det`
--
ALTER TABLE `order_det`
  ADD PRIMARY KEY (`order_det_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `order_param`
--
ALTER TABLE `order_param`
  ADD PRIMARY KEY (`order_param_id`),
  ADD KEY `param_id` (`param_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `param`
--
ALTER TABLE `param`
  ADD PRIMARY KEY (`param_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `method` (`method`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `sku` (`sku`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `discount_id` (`discount_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `prod_cat`
--
ALTER TABLE `prod_cat`
  ADD PRIMARY KEY (`prod_cat_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `prod_img`
--
ALTER TABLE `prod_img`
  ADD PRIMARY KEY (`prod_img_id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `prod_param`
--
ALTER TABLE `prod_param`
  ADD PRIMARY KEY (`prod_param_id`),
  ADD KEY `param_id` (`param_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `prod_rating`
--
ALTER TABLE `prod_rating`
  ADD PRIMARY KEY (`prod_rating_id`),
  ADD KEY `rating_id` (`rating_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `prod_size`
--
ALTER TABLE `prod_size`
  ADD PRIMARY KEY (`prod_size_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `size_id` (`size_id`);

--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `shipment`
--
ALTER TABLE `shipment`
  ADD PRIMARY KEY (`shipment_id`),
  ADD UNIQUE KEY `method` (`method`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`size_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`vendor_id`),
  ADD UNIQUE KEY `full_name` (`full_name`),
  ADD UNIQUE KEY `cnic` (`cnic`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `district_id` (`district_id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `vend_param`
--
ALTER TABLE `vend_param`
  ADD PRIMARY KEY (`vend_param_id`),
  ADD KEY `param_id` (`param_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `vend_rating`
--
ALTER TABLE `vend_rating`
  ADD PRIMARY KEY (`vend_rating_id`),
  ADD KEY `rating_id` (`rating_id`),
  ADD KEY `vendor_id` (`vendor_id`);

--
-- Indexes for table `vend_skill`
--
ALTER TABLE `vend_skill`
  ADD PRIMARY KEY (`vend_skill_id`),
  ADD KEY `vendor_id` (`vendor_id`),
  ADD KEY `category_id` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `common_user`
--
ALTER TABLE `common_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cust_param`
--
ALTER TABLE `cust_param`
  MODIFY `cust_param_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount`
--
ALTER TABLE `discount`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `district`
--
ALTER TABLE `district`
  MODIFY `district_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_det`
--
ALTER TABLE `order_det`
  MODIFY `order_det_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_param`
--
ALTER TABLE `order_param`
  MODIFY `order_param_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `param`
--
ALTER TABLE `param`
  MODIFY `param_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_cat`
--
ALTER TABLE `prod_cat`
  MODIFY `prod_cat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_img`
--
ALTER TABLE `prod_img`
  MODIFY `prod_img_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_param`
--
ALTER TABLE `prod_param`
  MODIFY `prod_param_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_rating`
--
ALTER TABLE `prod_rating`
  MODIFY `prod_rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prod_size`
--
ALTER TABLE `prod_size`
  MODIFY `prod_size_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rating`
--
ALTER TABLE `rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `shipment`
--
ALTER TABLE `shipment`
  MODIFY `shipment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `size_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `vendor_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vend_param`
--
ALTER TABLE `vend_param`
  MODIFY `vend_param_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vend_rating`
--
ALTER TABLE `vend_rating`
  MODIFY `vend_rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vend_skill`
--
ALTER TABLE `vend_skill`
  MODIFY `vend_skill_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`);

--
-- Constraints for table `common_user`
--
ALTER TABLE `common_user`
  ADD CONSTRAINT `common_user_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`user_id`);

--
-- Constraints for table `cust_param`
--
ALTER TABLE `cust_param`
  ADD CONSTRAINT `cust_param_ibfk_1` FOREIGN KEY (`param_id`) REFERENCES `param` (`param_id`),
  ADD CONSTRAINT `cust_param_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `discount`
--
ALTER TABLE `discount`
  ADD CONSTRAINT `discount_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`);

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`user_id`),
  ADD CONSTRAINT `log_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`user_id`),
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`shipment_id`) REFERENCES `shipment` (`shipment_id`),
  ADD CONSTRAINT `orders_ibfk_4` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`discount_id`),
  ADD CONSTRAINT `orders_ibfk_5` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `order_det`
--
ALTER TABLE `order_det`
  ADD CONSTRAINT `order_det_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `order_det_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `order_param`
--
ALTER TABLE `order_param`
  ADD CONSTRAINT `order_param_ibfk_1` FOREIGN KEY (`param_id`) REFERENCES `param` (`param_id`),
  ADD CONSTRAINT `order_param_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`discount_id`),
  ADD CONSTRAINT `product_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `product_ibfk_4` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `prod_cat`
--
ALTER TABLE `prod_cat`
  ADD CONSTRAINT `prod_cat_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `prod_cat_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `prod_img`
--
ALTER TABLE `prod_img`
  ADD CONSTRAINT `prod_img_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `prod_img_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `prod_param`
--
ALTER TABLE `prod_param`
  ADD CONSTRAINT `prod_param_ibfk_1` FOREIGN KEY (`param_id`) REFERENCES `param` (`param_id`),
  ADD CONSTRAINT `prod_param_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `prod_rating`
--
ALTER TABLE `prod_rating`
  ADD CONSTRAINT `prod_rating_ibfk_1` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`),
  ADD CONSTRAINT `prod_rating_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `prod_size`
--
ALTER TABLE `prod_size`
  ADD CONSTRAINT `prod_size_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `prod_size_ibfk_2` FOREIGN KEY (`size_id`) REFERENCES `size` (`size_id`);

--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`);

--
-- Constraints for table `vendor`
--
ALTER TABLE `vendor`
  ADD CONSTRAINT `vendor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `common_user` (`user_id`),
  ADD CONSTRAINT `vendor_ibfk_2` FOREIGN KEY (`district_id`) REFERENCES `district` (`district_id`),
  ADD CONSTRAINT `vendor_ibfk_3` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `vendor_ibfk_4` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `vendor_ibfk_5` FOREIGN KEY (`admin_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `vend_param`
--
ALTER TABLE `vend_param`
  ADD CONSTRAINT `vend_param_ibfk_1` FOREIGN KEY (`param_id`) REFERENCES `param` (`param_id`),
  ADD CONSTRAINT `vend_param_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `vend_rating`
--
ALTER TABLE `vend_rating`
  ADD CONSTRAINT `vend_rating_ibfk_1` FOREIGN KEY (`rating_id`) REFERENCES `rating` (`rating_id`),
  ADD CONSTRAINT `vend_rating_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `vend_skill`
--
ALTER TABLE `vend_skill`
  ADD CONSTRAINT `vend_skill_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  ADD CONSTRAINT `vend_skill_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
