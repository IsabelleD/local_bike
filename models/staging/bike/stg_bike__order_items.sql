select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount,
    round(list_price * quantity * (1 - discount), 2) as revenue
from {{ source('bike', 'order_items') }}