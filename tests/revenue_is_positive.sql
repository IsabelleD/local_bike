select
    order_id,
    revenue
from {{ ref('stg_bike__order_items') }}
where revenue < 0