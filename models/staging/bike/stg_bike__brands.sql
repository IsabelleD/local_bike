select
    brand_id,
    brand_name
from {{ source('bike', 'brands') }}