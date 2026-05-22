select
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    phone,
    street,
    city,
    state,
    zip_code
from {{ source('bike', 'customers') }}

