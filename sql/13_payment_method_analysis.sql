-- 13_payment_method_analysis.sql

SELECT
    payment_type,
    COUNT(*) AS total_payment_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    CAST(
        SUM(payment_value) AS DECIMAL(18, 2)
    ) AS total_payment_value,
    CAST(
        AVG(payment_value) AS DECIMAL(18, 2)
    ) AS average_payment_value
FROM dbo.payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;