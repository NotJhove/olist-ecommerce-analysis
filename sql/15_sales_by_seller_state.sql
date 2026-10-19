-- 15_sales_by_seller_state.sql

SELECT
    s.seller_state,
    COUNT(DISTINCT s.seller_id) AS total_sellers,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    CAST(
        SUM(oi.price) AS DECIMAL(18, 2)
    ) AS total_sales_revenue
FROM dbo.sellers AS s
INNER JOIN dbo.order_items AS oi
    ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY total_sales_revenue DESC;