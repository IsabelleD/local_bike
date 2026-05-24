select
    order_id,
    customer_id,
    order_status,
    cast(order_date as date)        as order_date,
    cast(required_date as date)     as required_date,
    safe_cast(shipped_date as date) as shipped_date,
    store_id,
    staff_id,
    case
        when order_status = 1 then 'Pending'
        when order_status = 2 then 'Processing'
        when order_status = 3 then 'Rejected'
        when order_status = 4 then 'Completed'
    end as order_status_label,
    case
        when safe_cast(shipped_date as date) is null then true
        else false
    end as is_unshipped
from {{ source('bike', 'orders') }}