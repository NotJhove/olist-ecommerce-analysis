-- 14_freight_by_category.sql

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    COUNT(*) AS items_sold,
    CAST(
        SUM(oi.freight_value) AS DECIMAL(18, 2)
    ) AS total_freight,
    CAST(
        AVG(oi.freight_value) AS DECIMAL(18, 2)
    ) AS average_freight_per_item
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
ORDER BY total_freight DESC;