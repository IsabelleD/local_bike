select
    store_id,
    store_name,
    city,
    state,
    email,
    nb_staff,
    nb_staff_active
from {{ ref('int_bike__stores') }}
