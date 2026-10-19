--02_monthly_sales_revenue.sql

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    CAST(SUM(oi.price) AS DECIMAL(18, 2)) AS total_sales_revenue
FROM dbo.orders AS o
INNER JOIN dbo.order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp IS NOT NULL
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)
ORDER BY
    order_year,
    order_month;