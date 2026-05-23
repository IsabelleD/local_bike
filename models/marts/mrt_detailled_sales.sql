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
    p.category_name,
    p.brand_name,

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

from {{ ref('stg_bike__order_items') }}  as oi
left join {{ ref('stg_bike__orders') }}  as o  
    on oi.order_id   = o.order_id
left join {{ ref('int_bike__products') }} as p  
    on oi.product_id = p.product_id
left join {{ ref('int_bike__stores') }}  as s  
    on o.store_id    = s.store_id
left join {{ ref('stg_bike__staffs') }}  as st 
    on o.staff_id    = st.staff_id
