-- 18_reviews_by_delivery_performance.sql

SELECT
    CASE
        WHEN o.order_delivered_customer_date
             <= o.order_estimated_delivery_date
            THEN 'On Time or Early'
        ELSE 'Delivered Late'
    END AS delivery_performance,
    COUNT(*) AS total_reviews,
    CAST(
        AVG(CAST(r.review_score AS DECIMAL(10, 2)))
        AS DECIMAL(4, 2)
    ) AS average_review_score,
    SUM(
        CASE
            WHEN r.review_score = 1 THEN 1
            ELSE 0
        END
    ) AS one_star_reviews,
    CAST(
        SUM(
            CASE
                WHEN r.review_score = 1 THEN 100.0
                ELSE 0
            END
        ) / COUNT(*) AS DECIMAL(5, 2)
    ) AS one_star_review_percentage
FROM dbo.orders AS o
INNER JOIN dbo.reviews AS r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND r.review_score IS NOT NULL
GROUP BY
    CASE
        WHEN o.order_delivered_customer_date
             <= o.order_estimated_delivery_date
            THEN 'On Time or Early'
        ELSE 'Delivered Late'
    END
ORDER BY delivery_performance;