with orders as (
    select * from {{ ref('stg_bike__orders') }}
),

order_items as (
    select * from {{ ref('stg_bike__order_items') }}
),

products as (
    select * from {{ ref('stg_bike__products') }}
),

stores as (
    select * from {{ ref('stg_bike__stores') }}
),

staffs as (
    select * from {{ ref('stg_bike__staffs') }}
),

categories as (
    select * from {{ ref('stg_bike__categories') }}
),

brands as (
    select * from {{ ref('stg_bike__brands') }}
),

final as (
    select
        -- Keys
        oi.order_id,
        oi.item_id,
        oi.product_id,
        o.customer_id,
        o.store_id,
        o.staff_id,

        -- Dates
        o.order_date,
        o.required_date,
        o.shipped_date,
        extract(year  from o.order_date) as order_year,
        extract(month from o.order_date) as order_month,

        -- Status
        o.order_status,
        o.order_status_label,
        o.is_unshipped,

        -- Product
        p.product_name,
        p.model_year,
        p.list_price as product_list_price,

        -- Category & brand
        c.category_name,
        b.brand_name,

        -- Store
        s.store_name,
        s.city  as store_city,
        s.state as store_state,

        -- Staff
        st.full_name as staff_name,

        -- Metrics
        oi.quantity,
        oi.list_price,
        oi.discount,
        oi.revenue

    from order_items        as oi
    left join orders        as o  on oi.order_id   = o.order_id
    left join products      as p  on oi.product_id = p.product_id
    left join stores        as s  on o.store_id    = s.store_id
    left join staffs        as st on o.staff_id    = st.staff_id
    left join categories    as c  on p.category_id = c.category_id
    left join brands        as b  on p.brand_id    = b.brand_id
)

select * from final
