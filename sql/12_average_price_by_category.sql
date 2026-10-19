-- 12_average_price_by_category.sql

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    COUNT(*) AS items_sold,
    CAST(
        AVG(oi.price) AS DECIMAL(18, 2)
    ) AS average_item_price,
    CAST(
        SUM(oi.price) AS DECIMAL(18, 2)
    ) AS total_sales_revenue
FROM dbo.order_items AS oi
INNER JOIN dbo.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN dbo.category_translation AS ct
    ON p.product_category_name = ct.product_category_name
GROUP BY
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )
ORDER BY average_item_price DESC;