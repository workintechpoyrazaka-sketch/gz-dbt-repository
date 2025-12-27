WITH campaigns_day AS (
    SELECT *
    From {{ ref('int_campaigns_day') }}
),
finance AS (
    SELECT *
    FROM {{ ref('finance_days') }}
)

SELECT
finance.date_date,
finance.operational_margin - campaigns_day.ads_cost AS ads_margin,
finance.average_basket,
finance.operational_margin,
campaigns_day.ads_cost,
campaigns_day.ads_impression,
campaigns_day.ads_clicks,
finance.quantity,
finance.revenue,
finance.purchase_cost,
finance.margin,
finance.shipping_fee,
finance.log_cost,
finance.ship_cost
FROM finance
LEFT JOIN campaigns_day ON finance.date_date = campaigns_day.date_date
ORDER BY finance.date_date DESC