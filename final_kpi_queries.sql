SET search_path TO olist, public;

--Total Revenue
CREATE OR REPLACE VIEW kpi_total_revenue AS
SELECT SUM(price + freight_value) AS total_revenue
FROM order_items;

--Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM orders;

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

--Average delivery time
SELECT
    AVG(order_delivered_customer_date - purchase_timestamp) AS avg_delivery_time
FROM orders
WHERE order_status = 'delivered';

-- Average delay
WITH OrderTotals AS (SELECT
    order_id,
    (order_delivered_customer_date - order_estimated_delivery_date) AS delay_interval
FROM orders
WHERE order_status = 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date)

SELECT AVG(delay_interval) FROM OrderTotals;

--% Delayed Orders
SELECT 
   COUNT(order_id) AS total_orders,
   (100.0 * SUM( CASE WHEN order_delivered_customer_date > order_estimated_delivery_date THEN 1 ELSE 0 END)/ COUNT(*))::DECIMAL(10,2) AS delayed_percent
   FROM orders;

--Top Selling Categories
SELECT category,count( DISTINCT order_id) AS order_count FROM order_items
group by category
ORDER BY order_count DESC;

--Top States by order sales
SELECT customer_state,COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY customer_state
ORDER BY order_count DESC;