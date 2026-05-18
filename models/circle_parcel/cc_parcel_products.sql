{{
    config(
        materialized = 'table',
        partition_by = {
            "field": "date_purchase",
            "data_type": "date"
        }
    )
}}

with products as (
    select * from {{ ref('stg_cc_parcel_products') }}
),

parcel as (
    select * from {{ ref('cc_parcel') }}
)

select
    pr.parcel_id,
    pr.model_name,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    p.date_purchase,
    p.date_shipping,
    p.date_delivery,
    p.date_cancelled,
    p.month_purchase,
    p.status,
    p.expedition_time,
    p.transport_time,
    p.delivery_time,
    p.delay,
    pr.qty

from products pr
left join parcel p
    on pr.parcel_id = p.parcel_id