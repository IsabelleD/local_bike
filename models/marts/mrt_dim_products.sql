with products as (
    select * from {{ ref('stg_bike__products') }}
),

categories as (
    select * from {{ ref('stg_bike__categories') }}
),

brands as (
    select * from {{ ref('stg_bike__brands') }}
),

stocks_agg as (
    select
        product_id,
        sum(quantity) as total_stock
    from {{ ref('stg_bike__stocks') }}
    group by product_id
),

final as (
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
    from products       as p
    left join categories    as c on p.category_id = c.category_id
    left join brands        as b on p.brand_id    = b.brand_id
    left join stocks_agg    as s on p.product_id  = s.product_id
)

select * from final
