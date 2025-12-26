WITH

sales_data AS (
SELECT *
FROM {{ ref('stg_raw__sales') }}
),

product_data AS (
    SELECT *
    FROM {{ ref('stg_raw__product') }}
)

SELECT
sales_data.date_date,
sales_data.orders_id,
sales_data.products_id,
sales_data.revenue,
sales_data.quantity,
product_data.purchase_price,
quantity * purchase_price AS purchase_cost,
revenue - (quantity * purchase_price) AS margin
FROM sales_data 
LEFT JOIN product_data
ON sales_data.products_id = product_data.products_id