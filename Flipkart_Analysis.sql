CREATE DATABASE IF NOT EXISTS flipkart;

USE flipkart;

-- 1. What is the total revenue generated from all orders?

CREATE VIEW total_revenue AS
SELECT ROUND(SUM(quantity*price), 2) AS total_revenue
FROM orderitems;

SELECT * FROM total_revenue;

-- 2. Which are the top 5 best-selling products based on quantity sold?

CREATE VIEW top_5_best_selling_products AS
SELECT p.product_id,
	   p.product_name,
       p.product_category,
       SUM(oi.quantity) AS quantity_sold
FROM orderitems oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY quantity_sold DESC
LIMIT 5;

SELECT * FROM top_5_best_selling_products;

-- 3. Who are the top 5 customers by total spending?

CREATE VIEW top_5_customers AS
SELECT c.customer_name,
	   ROUND(SUM(oi.quantity * oi.price), 2) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN orderitems oi
ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 5;

SELECT * FROM top_5_customers;

-- 4. How much sales revenue was generated each month?

CREATE OR REPLACE VIEW total_sales_revenue_by_month AS
SELECT DATE_FORMAT(o.order_date, "%Y-%m") AS year_months,
	   ROUND(SUM(oi.quantity * oi.price), 2) AS total_sales_revenue
FROM orderitems oi
JOIN orders o
ON oi.order_id = o.order_id
GROUP BY year_months
ORDER BY total_sales_revenue DESC;

SELECT * FROM total_sales_revenue_by_month;

-- 5. What are the most commonly used payment methods?

CREATE VIEW mostly_used_payment_method AS
SELECT payment_method,
	   COUNT(*) AS num_payments
FROM payments
GROUP BY payment_method
ORDER BY num_payments DESC;

SELECT * FROM mostly_used_payment_method;

-- 6. What is the average order value per order?

CREATE VIEW average_order_value_per_order AS
SELECT ROUND(AVG(order_total), 2) AS average_order_value
FROM
(SELECT o.order_id,
	   SUM(oi.quantity*oi.price) AS order_total
FROM orderitems oi
JOIN orders o
ON oi.order_id = o.order_id
GROUP BY o.order_id
) subq;

SELECT * FROM average_order_value_per_order;

-- 7(A). Which Top 5 customers placed the highest number of orders?

CREATE VIEW high_value_customers AS
SELECT c.customer_name,
	   COUNT(o.order_id) AS total_order
FROM customers c 
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_order DESC
LIMIT 5;

SELECT * FROM high_value_customers;

-- 7(B). Which Top 5 customers spend the most money?

SELECT c.customer_name,
	   ROUND(SUM(o.order_amount), 2) AS total_spend
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spend DESC
LIMIT 5;

-- 8. Which states generate the highest number of orders?

CREATE VIEW highest_orders_by_state AS
SELECT c.state ,
	   COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY total_orders DESC;

SELECT * FROM highest_orders_by_state;

-- 9. Which Top 5 product categories contribute the most to total revenue?

CREATE VIEW top_5_product_category_by_total_revenue AS
SELECT p.product_category,
	   ROUND(SUM(oi.quantity*oi.price), 2) AS total_revenue
FROM orderitems oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_revenue DESC
LIMIT 5;

SELECT * FROM top_5_product_category_by_total_revenue;

-- 10. What is the average number of items per order?

CREATE VIEW average_items_per_order AS
SELECT CEILING(ROUND(AVG(total_items), 2)) AS avg_items_per_order
FROM ( SELECT o.order_id,
			   SUM(oi.quantity) AS total_items
		FROM orderitems oi
		JOIN orders o
		ON oi.order_id = o.order_id
		GROUP BY o.order_id
	  ) subquery;

SELECT * FROM average_items_per_order;

-- CREATED VIEWS

-- 1. What is the total revenue generated from all orders?

SELECT * FROM total_revenue;

-- 2. Which are the top 5 best-selling products based on quantity sold?

SELECT * FROM top_5_best_selling_products;

-- 3. Who are the top 5 customers by total spending?

SELECT * FROM top_5_customers;

-- 4. How much sales revenue was generated each month?

SELECT * FROM total_sales_revenue_by_month;

-- 5. What are the most commonly used payment methods?

SELECT * FROM mostly_used_payment_method;

-- 6. What is the average order value per order?

SELECT * FROM average_order_value_per_order;

-- 7(A). Which Top 5 customers placed the highest number of orders?

SELECT * FROM high_value_customers;

-- 8. Which states generate the highest number of orders?

SELECT * FROM highest_orders_by_state;

-- 9. Which Top 5 product categories contribute the most to total revenue?

SELECT * FROM top_5_product_category_by_total_revenue;

-- 10. What is the average number of items per order?

SELECT * FROM average_items_per_order;

