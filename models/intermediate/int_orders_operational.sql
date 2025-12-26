WITH ship_data AS (
    SELECT *
    FROM {{ ref('stg_raw__ship') }}
),

orders_margin_data AS (
    SELECT *
    FROM {{ ref('int_orders_margin') }}
)

SELECT orders_margin_data.orders_id,
orders_margin_data.date_date,
margin + shipping_fee - log_cost - ship_cost AS operational_margin
FROM orders_margin_data
LEFT JOIN ship_data ON orders_margin_data.orders_id = ship_data.orders_id