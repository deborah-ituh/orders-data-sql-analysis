CREATE DATABASE orders_db;
USE orders_db;
select * FROM orders_details;


-- =========================================
-- Changing data type for order_date
-- =========================================
DESCRIBE orders_details;

ALTER TABLE orders_details
ADD COLUMN order_date_new DATETIME;

UPDATE orders_details
SET order_date_new = STR_TO_DATE(order_date, '%m/%d/%Y %H:%i');

ALTER TABLE orders_details DROP COLUMN order_date;
ALTER TABLE orders_details CHANGE order_date_new order_date DATETIME;
-- =========================================
-- Changing data type for promised_delivery_time 
-- =========================================
ALTER TABLE orders_details ADD COLUMN promised_delivery_time_new DATETIME;

UPDATE orders_details
SET promised_delivery_time_new =
STR_TO_DATE(promised_delivery_time, '%m/%d/%Y %H:%i');

ALTER TABLE orders_details DROP COLUMN promised_delivery_time;

ALTER TABLE orders_details
CHANGE promised_delivery_time_new promised_delivery_time DATETIME;

-- =========================================
-- Changing data type for actual_delivery_time
-- =========================================
ALTER TABLE orders_details ADD COLUMN actual_delivery_time_new DATETIME;

UPDATE orders_details
SET actual_delivery_time_new =
STR_TO_DATE(actual_delivery_time, '%m/%d/%Y %H:%i');

ALTER TABLE orders_details DROP COLUMN actual_delivery_time;

ALTER TABLE orders_details
CHANGE actual_delivery_time_new actual_delivery_time DATETIME;

-- =========================================
-- Changing data type for registration_date
-- =========================================
ALTER TABLE orders_details ADD COLUMN registration_date_new DATE;

UPDATE orders_details
SET registration_date_new =
STR_TO_DATE(registration_date, '%m/%d/%Y');

ALTER TABLE orders_details DROP COLUMN registration_date;

ALTER TABLE orders_details
CHANGE registration_date_new registration_date DATE;

-- =========================================
-- Total Revenue
-- =========================================
select round(SUM(order_total), 2) AS total_revenue 
FROM orders_details;
-- =========================================
-- Orders per day
-- =========================================
SELECT DATE(order_date) AS order_day, COUNT(*) AS orders
FROM orders_details
GROUP BY order_day
ORDER BY order_day;
-- =========================================
-- Average Order Value
-- =========================================
SELECT round(avg(order_total), 2) AS avg_order_value FROM orders_details;
-- =========================================
-- Total Profit
-- =========================================
SELECT round(sum(total_profit), 2) AS total_profit FROM orders_details;
-- =========================================
-- Profit by Area
-- =========================================
SELECT area, round(sum(total_profit),2) AS profit
FROM orders_details
GROUP BY area
ORDER BY profit DESC;
-- =========================================
-- Total Delivery status
-- =========================================
SELECT delivery_status_x, COUNT(*) AS total
FROM orders_details
GROUP BY delivery_status_x;
-- =========================================
-- Average delivery time
-- =========================================
SELECT AVG(delivery_time_minutes) FROM orders_details;
-- =========================================
-- Distance per average delivery time
-- =========================================
SELECT 
    CASE 
        WHEN distance_km < 3 THEN 'Short'
        WHEN distance_km BETWEEN 3 AND 7 THEN 'Medium'
        ELSE 'Long'
    END AS distance_range,
    AVG(delivery_time_minutes) AS avg_time
FROM orders_details
GROUP BY distance_range;
-- =========================================
-- Top 10 customers
-- =========================================
SELECT customer_id, COUNT(*) AS orders
FROM orders_details
GROUP BY customer_id
ORDER BY orders DESC
LIMIT 10;
-- =========================================
-- Revenue per Customer segment
-- =========================================
SELECT customer_segment, round(sum(order_total), 2) AS revenue
FROM orders_details
GROUP BY customer_segment;
-- =========================================
-- Total customers per year of registration
-- =========================================
SELECT 
    YEAR(registration_date) AS reg_year,
    COUNT(DISTINCT customer_id) AS customers
FROM orders_details
GROUP BY reg_year;
-- =========================================
-- Payment method per Revenue
-- =========================================
SELECT payment_method, COUNT(*) AS total_orders,
round(sum(order_total), 2) AS revenue
FROM orders_details
GROUP BY payment_method;
-- =========================================
-- Average rating
-- =========================================
SELECT AVG(rating) FROM orders_details;
-- =========================================
-- Sentiment vs delivery status
-- =========================================
SELECT sentiment, delivery_status_x, COUNT(*) AS total
FROM orders_details
GROUP BY sentiment, delivery_status_x;
-- =========================================
-- Feedback and total issues
-- =========================================
SELECT feedback_category, COUNT(*) AS issues
FROM orders_details
GROUP BY feedback_category
ORDER BY issues DESC;
-- =========================================
-- Pin code per Revenue & orders
-- =========================================
SELECT pincode, COUNT(*) AS orders, round(sum(order_total), 2) AS revenue
FROM orders_details
GROUP BY pincode
ORDER BY revenue DESC;
-- =========================================
-- Delivery status vs avg rating
-- =========================================
SELECT 
    delivery_status_x,
    round(avg(rating), 2) AS avg_rating
FROM orders_details
GROUP BY delivery_status_x;

























