select
    order_id,
    round(sum(revenue), 2)          as total_revenue_order,
    sum(quantity)                    as total_quantity_order,
    count(distinct item_id)          as nb_diff_items_order
from {{ ref('stg_bike__order_items') }}
group by order_id
