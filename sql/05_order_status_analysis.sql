-- 05_order_status_analysis.sql

SELECT
    order_status,
    COUNT(*) AS total_orders,
    CAST(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM dbo.orders)
        AS DECIMAL(5, 2)
    ) AS percentage_of_orders
FROM dbo.orders
GROUP BY order_status
ORDER BY total_orders DESC;