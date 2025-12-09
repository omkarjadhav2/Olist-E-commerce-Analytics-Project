SET search_path TO olist, public;

--Top 10 states by number of customers
select customer_state,count(customer_id) as customer_count
from customers
group by customer_state
order by customer_count desc limit 10;

--Monthly order trends
SELECT 
    EXTRACT(YEAR FROM purchase_timestamp) AS year,
    EXTRACT(MONTH FROM purchase_timestamp) AS month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY year, month
ORDER BY year, month;

--Average delivery time
SELECT
    AVG(order_delivered_customer_date - purchase_timestamp) AS avg_delivery_time
FROM orders
WHERE order_status = 'delivered';

--Delayed deliveries count

SELECT
    order_id,
    (order_delivered_customer_date - order_estimated_delivery_date) AS delay_interval
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date;

-- Orders by status
SELECT order_status,COUNT(order_id) AS order_count FROM orders
GROUP BY order_status;

--Total revenue per month
SELECT 
    TO_CHAR(o.purchase_timestamp, 'YYYY-MM') AS month,
    SUM(i.price) AS product_revenue,
    SUM(i.freight_value) AS shipping_revenue,
    SUM(i.price + i.freight_value) AS total_gross_revenue
FROM orders AS o
JOIN order_items AS i 
    ON o.order_id = i.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;

-- Total orders by category
SELECT category,count( DISTINCT order_id) AS order_count FROM order_items
group by category
ORDER BY order_count DESC;

--Category-wise revenue
CREATE OR REPLACE VIEW Category_Revenue AS 
SELECT category,SUM(price) AS product_revenue,
SUM(freight_value) AS shipping_revenue,
SUM(price + freight_value) AS total_gross_revenue FROM order_items
group by category
ORDER BY total_gross_revenue DESC LIMIT 10;

-- Average order value
-- Calculate the total value of each individual order
WITH OrderTotals AS (
   
    SELECT 
        order_id,
        SUM(price + freight_value) AS order_total_value
    FROM order_items
    GROUP BY order_id
)
-- Average
SELECT 
    AVG(order_total_value)::DECIMAL(10,2) AS average_order_value
FROM OrderTotals;


--Freight % contribution to revenue
WITH TotalRevenue AS (
SELECT SUM(price) AS total_price,SUM(freight_value) AS freight_total, 
SUM(price+freight_value) AS total
FROM order_items)
SELECT 
   (freight_total * 100.0 / total)::DECIMAL(10,2)
   FROM TotalRevenue;


--Payment type usage
SELECT 
    payment_type,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM payment
GROUP BY payment_type
ORDER BY number_of_orders DESC;

--EMI vs no-EMI orders

SELECT COUNT( DISTINCT order_id),is_installment FROM payment
GROUP BY is_installment;

--Total review score
SELECT review_score,COUNT(order_id) FROM order_reviews
GROUP BY review_score
ORDER BY review_score;

--% of 1-star and 5-star reviews
SELECT 
    (100.0 * SUM(CASE WHEN review_score = 1 THEN 1 ELSE 0 END) / COUNT(*))::DECIMAL(10,2) AS one_star,
    (100.0 * SUM(CASE WHEN review_score = 5 THEN 1 ELSE 0 END) / COUNT(*))::DECIMAL(10,2) AS five_star
FROM order_reviews;

--Top 15 sellers by total sales
SELECT seller_id,COUNT(DISTINCT order_id) AS order_count FROM order_items
GROUP BY seller_id
ORDER BY order_count DESC LIMIT 15;


--Top 15 sellers by total REVENUE

SELECT 
    seller_id,
    SUM(price + freight_value) AS total_revenue, 
    RANK() OVER (ORDER BY SUM(price + freight_value) DESC) AS rank_value
FROM order_items
GROUP BY seller_id LIMIT 15;

-- ORDER T
CREATE OR REPLACE VIEW view_order_totals AS
SELECT 
    order_id,
    SUM(price + freight_value) AS order_total_value
FROM order_items
GROUP BY order_id;





