-- 08_delivery_estimate_analysis.sql

SELECT
    CASE
        WHEN order_delivered_customer_date
             < order_estimated_delivery_date
            THEN 'Delivered Early'
        WHEN order_delivered_customer_date
             = order_estimated_delivery_date
            THEN 'Delivered On Estimated Date'
        ELSE 'Delivered Late'
    END AS delivery_performance,
    COUNT(*) AS total_orders,
    CAST(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER ()
        AS DECIMAL(5, 2)
    ) AS percentage_of_orders
FROM dbo.orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY
    CASE
        WHEN order_delivered_customer_date
             < order_estimated_delivery_date
            THEN 'Delivered Early'
        WHEN order_delivered_customer_date
             = order_estimated_delivery_date
            THEN 'Delivered On Estimated Date'
        ELSE 'Delivered Late'
    END
ORDER BY total_orders DESC;