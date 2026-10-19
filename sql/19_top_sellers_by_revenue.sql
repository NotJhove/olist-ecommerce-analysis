-- 19_top_sellers_by_revenue.sql

SELECT TOP 20
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    CAST(
        SUM(oi.price) AS DECIMAL(18, 2)
    ) AS total_sales_revenue,
    CAST(
        AVG(oi.price) AS DECIMAL(18, 2)
    ) AS average_item_price
FROM dbo.sellers AS s
INNER JOIN dbo.order_items AS oi
    ON s.seller_id = oi.seller_id
GROUP BY
    s.seller_id,
    s.seller_state
ORDER BY total_sales_revenue DESC;