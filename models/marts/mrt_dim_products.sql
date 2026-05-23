select
    product_id,
    product_name,
    model_year,
    list_price,
    category_id,
    category_name,
    brand_id,
    brand_name,
    total_stock
from {{ ref('int_bike__products') }}

