-- 07_delivery_performance.sql

SELECT
    COUNT(*) AS total_delivered_orders,
    CAST(
        AVG(DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        ) * 1.0) AS DECIMAL(10, 2)
    ) AS avg_delivery_days,
    MIN(DATEDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    )) AS min_delivery_days,
    MAX(DATEDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    )) AS max_delivery_days
FROM dbo.orders
WHERE order_status = 'delivered'
  AND order_purchase_timestamp IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL;