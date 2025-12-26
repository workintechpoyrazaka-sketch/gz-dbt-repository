with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(logCost AS FLOAT64) AS log_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost

    from source

)

select * from renamed