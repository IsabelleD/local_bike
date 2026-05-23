select
    o.order_date,
    s.store_id,
    s.store_name,
    s.city  as store_city,
    s.state as store_state,
    s.nb_staff_active,
    count(distinct o.order_id)                              as nb_orders,
    sum(oi.total_quantity_order)                            as total_quantity,
    round(sum(oi.total_revenue_order), 2)                   as total_revenue,
    round(avg(oi.total_revenue_order), 2)                   as avg_revenue_per_order
from {{ ref('int_bike__orders') }}        as oi
left join {{ ref('stg_bike__orders') }}        as o 
    on oi.order_id = o.order_id
left join {{ ref('int_bike__stores') }}        as s 
    on o.store_id  = s.store_id
group by
    o.order_date,
    s.store_id,
    s.store_name,
    s.city,
    s.state,
    s.nb_staff_active
order by o.order_date, 
         s.store_name
