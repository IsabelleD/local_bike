select
    product_id,
    list_price
from {{ ref('stg_bike__products') }}
where list_price < 0