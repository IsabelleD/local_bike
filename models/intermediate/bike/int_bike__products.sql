with stocks_agg as (
    select
        product_id,
        sum(quantity) as total_stock
    from {{ ref('stg_bike__stocks') }}
    group by product_id
)

select
    p.product_id,
    p.product_name,
    p.model_year,
    p.list_price,
    c.category_id,
    c.category_name,
    b.brand_id,
    b.brand_name,
    coalesce(s.total_stock, 0) as total_stock
from {{ ref('stg_bike__products') }} as p
left join {{ ref('stg_bike__categories') }} as c 
    on p.category_id = c.category_id
left join {{ ref('stg_bike__brands') }}     as b 
    on p.brand_id    = b.brand_id
left join stocks_agg                        as s 
    on p.product_id  = s.product_id
