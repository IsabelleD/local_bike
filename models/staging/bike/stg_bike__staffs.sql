select
    staff_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    phone,
    active,
    store_id,
    manager_id
from {{ source('bike', 'staffs') }}