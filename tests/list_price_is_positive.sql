select
    product_id,
    list_price
from {{ ref('stg_bike__products') }}
having list_price < 0