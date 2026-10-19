-- 17_order_value_by_payment_method.sql

WITH order_payment_totals AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value
    FROM dbo.payments
    GROUP BY order_id
),
order_item_totals AS (
    SELECT
        order_id,
        SUM(price) AS total_item_value
    FROM dbo.order_items
    GROUP BY order_id
),
order_payment_methods AS (
    SELECT
        order_id,
        CASE
            WHEN COUNT(DISTINCT payment_type) = 1
                THEN MAX(payment_type)
            ELSE 'Multiple Methods'
        END AS payment_method
    FROM dbo.payments
    GROUP BY order_id
)
SELECT
    pm.payment_method,
    COUNT(*) AS total_orders,
    CAST(
        AVG(CAST(pt.total_payment_value AS DECIMAL(18, 2)))
        AS DECIMAL(18, 2)
    ) AS average_payment_per_order,
    CAST(
        AVG(CAST(it.total_item_value AS DECIMAL(18, 2)))
        AS DECIMAL(18, 2)
    ) AS average_item_value_per_order
FROM order_payment_methods AS pm
INNER JOIN order_payment_totals AS pt
    ON pm.order_id = pt.order_id
LEFT JOIN order_item_totals AS it
    ON pm.order_id = it.order_id
GROUP BY pm.payment_method
ORDER BY average_payment_per_order DESC;