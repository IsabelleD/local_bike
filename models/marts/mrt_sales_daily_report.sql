with order_items as (
    select * from {{ ref('stg_bike__order_items') }}
),

orders as (
    select * from {{ ref('stg_bike__orders') }}
),

stores as (
    select * from {{ ref('stg_bike__stores') }}
),

daily_sales as (
    select
        o.order_date,
        s.store_id,
        s.store_name,
        s.city  as store_city,
        s.state as store_state,
        count(distinct o.order_id)                              as nb_orders,
        sum(oi.quantity)                                        as total_quantity,
        round(sum(oi.revenue), 2)                               as total_revenue,
        round(avg(oi.revenue), 2)                               as avg_revenue_per_item,
        round(sum(oi.discount * oi.list_price * oi.quantity), 2) as total_discount_amount
    from order_items        as oi
    left join orders        as o on oi.order_id = o.order_id
    left join stores        as s on o.store_id  = s.store_id
    group by
        o.order_date,
        s.store_id,
        s.store_name,
        s.city,
        s.state
)

select * from daily_sales
order by order_date, store_name
