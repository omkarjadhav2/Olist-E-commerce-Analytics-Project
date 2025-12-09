SET search_path TO olist, public;

SELECT * FROM orders
WHERE order_delivered_customer_date IS NULL;


ALTER TABLE payment 
ADD COLUMN is_installment BOOLEAN;

UPDATE payment
SET is_installment = CASE WHEN payment_installments> 1 THEN TRUE ELSE FALSE END

SELECT order_id,SUM(price + freight_value) AS revenue
FROM order_items
GROUP BY order_id;

select is_installment,count(order_id) as total_orders from  payment
group by 1;
