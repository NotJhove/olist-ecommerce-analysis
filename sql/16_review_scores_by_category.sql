-- 16_review_scores_by_category.sql

SELECT
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    ) AS product_category,
    COUNT(DISTINCT r.review_id) AS total_reviews,
    CAST(
        AVG(CAST(r.review_score AS DECIMAL(10, 2)))
        AS DECIMAL(4, 2)
    ) AS average_review_score,
    SUM(
        CASE WHEN r.review_score = 1 THEN 1 ELSE 0 END
    ) AS one_star_reviews,
    CAST(
        SUM(CASE WHEN r.review_score = 1 THEN 100.0 ELSE 0 END)
        / COUNT(*) AS DECIMAL(5, 2)
    ) AS one_star_review_percentage
FROM dbo.reviews AS r
INNER JOIN dbo.orders AS o
    ON r.order_id = o.order_id
INNER JOIN dbo.order_items AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN dbo.category_translation AS ct
    ON p.product_category_name = ct.product_category_name
WHERE r.review_score IS NOT NULL
GROUP BY
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name,
        'unknown'
    )
ORDER BY average_review_score ASC;