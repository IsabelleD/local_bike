select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount,
    {{ calculate_revenue('list_price', 'quantity', 'discount') }} as revenue
from {{ source('bike', 'order_items') }}