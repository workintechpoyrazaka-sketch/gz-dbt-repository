with parcel as (
    select * from {{ ref('stg_cc_parcel') }}
),

parcel_products as (
    select * from {{ ref('stg_cc_parcel_products') }}
),

nb_products_parcel as (
    select
        parcel_id,
        sum(qty) as qty,
        count(distinct model_name) as nb_model
    from parcel_products
    group by parcel_id
)

select
    p.parcel_id,
    p.parcel_tracking,
    p.transporter,
    p.priority,
    parse_date('%B %e, %Y', p.date_purchase)  as date_purchase,
    parse_date('%B %e, %Y', p.date_shipping)  as date_shipping,
    parse_date('%B %e, %Y', p.date_delivery)  as date_delivery,
    parse_date('%B %e, %Y', p.date_cancelled) as date_cancelled,
    extract(month from parse_date('%B %e, %Y', p.date_purchase)) as month_purchase,
    case
        when p.date_cancelled is not null then 'Cancelled'
        when p.date_shipping  is null     then 'In Progress'
        when p.date_delivery  is null     then 'In Transit'
        when p.date_delivery  is not null then 'Delivered'
        else null
    end as status,
    date_diff(
        parse_date('%B %e, %Y', p.date_shipping),
        parse_date('%B %e, %Y', p.date_purchase), day
    ) as expedition_time,
    date_diff(
        parse_date('%B %e, %Y', p.date_delivery),
        parse_date('%B %e, %Y', p.date_shipping), day
    ) as transport_time,
    date_diff(
        parse_date('%B %e, %Y', p.date_delivery),
        parse_date('%B %e, %Y', p.date_purchase), day
    ) as delivery_time,
    if(
        p.date_delivery is null, null,
        if(date_diff(
            parse_date('%B %e, %Y', p.date_delivery),
            parse_date('%B %e, %Y', p.date_purchase), day
        ) > 5, 1, 0)
    ) as delay,
    npp.qty,
    npp.nb_model

from parcel p
left join nb_products_parcel npp
    on p.parcel_id = npp.parcel_id