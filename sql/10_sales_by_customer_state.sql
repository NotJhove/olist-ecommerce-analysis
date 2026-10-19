-- 10_sales_by_customer_state.sql

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    CAST(SUM(oi.price) AS DECIMAL(18, 2)) AS total_sales_revenue,
    CAST(
        SUM(oi.price) / COUNT(DISTINCT o.order_id)
        AS DECIMAL(18, 2)
    ) AS average_item_value_per_order
FROM dbo.orders AS o
INNER JOIN dbo.customers AS c
    ON o.customer_id = c.customer_id
INNER JOIN dbo.order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_sales_revenue DESC;