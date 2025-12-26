WITH orders_operational AS (
    SELECT *
    FROM {{ ref('int_orders_operational') }}
)

SELECT date_date,
COUNT(orders_id) AS nb_transactions,
SUM(revenue) AS revenue,
ROUND(SUM(revenue) / COUNT(orders_id), 2) AS average_basket,
SUM(margin) AS margin,
SUM(operational_margin) AS operational_margin,
SUM(purchase_cost) AS purchase_cost,
SUM(shipping_fee) AS shipping_fee,
SUM(log_cost) AS log_cost,
SUM(ship_cost) AS ship_cost,
SUM(quantity) AS quantity
FROM orders_operational
GROUP BY date_date
ORDER BY date_date DESC