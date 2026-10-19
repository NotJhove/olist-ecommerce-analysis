-- 04_average_order_value.sql

SELECT
    COUNT(*) AS total_orders,
    CAST(AVG(order_value) AS DECIMAL(18, 2))
        AS average_order_value,
    CAST(SUM(order_value) AS DECIMAL(18, 2))
        AS total_sales_revenue
FROM (
    SELECT
        order_id,
        SUM(price) AS order_value
    FROM dbo.order_items
    GROUP BY order_id
) AS order_totals;