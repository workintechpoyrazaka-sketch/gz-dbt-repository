WITH source AS (
    SELECT *
    FROM {{ source('raw', 'adwords') }}
)

SELECT 
date_date,
paid_source,
campaign_key,
camPGN_name AS campaign_name,
CAST(ads_cost AS FLOAT64) AS ads_cost,
CAST(impression AS FLOAT64) AS ads_impression,
CAST(click AS FLOAT64) AS ads_clicks
FROM source