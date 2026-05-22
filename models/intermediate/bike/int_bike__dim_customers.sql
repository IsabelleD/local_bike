with tot_by_order as (
    select
        order_id,
        sum(revenue)           as total_revenue_order,
        sum(quantity)          as total_quantity_order,
        count(distinct item_id) as nb_diff_items_order
    from {{ ref('stg_bike__order_items') }}
    group by order_id
),

tot_by_customer as (
    select
        o.customer_id,
        sum(tbo.total_revenue_order)    as total_revenue_customer,
        sum(tbo.total_quantity_order)   as total_quantity_customer,
        sum(tbo.nb_diff_items_order)    as nb_diff_items_customer
    from tot_by_order as tbo
    left join {{ ref('stg_bike__orders') }} as o on tbo.order_id = o.order_id
    group by o.customer_id
)

select
    c.customer_id,
    c.full_name,
    c.street,
    c.city,
    c.state,
    c.zip_code,
    coalesce(tbc.total_revenue_customer, 0)    as total_revenue_customer,
    coalesce(tbc.total_quantity_customer, 0)   as total_quantity_customer,
    coalesce(tbc.nb_diff_items_customer, 0)    as nb_diff_items_customer
from {{ ref('stg_bike__customers') }} as c
left join tot_by_customer as tbc on tbc.customer_id = c.customer_id
