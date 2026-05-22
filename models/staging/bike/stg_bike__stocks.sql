select
    store_id,
    product_id,
    quantity
from {{ source('bike', 'stocks') }}