with staff_count as (
    select
        store_id,
        count(*)                                    as nb_staff,
        count(case when active = 1 then 1 end)      as nb_staff_active
    from {{ ref('stg_bike__staffs') }}
    group by store_id
)

select
    s.store_id,
    s.store_name,
    s.city,
    s.state,
    s.email,
    coalesce(sc.nb_staff, 0)        as nb_staff,
    coalesce(sc.nb_staff_active, 0) as nb_staff_active
from {{ ref('stg_bike__stores') }} as s
left join staff_count as sc on s.store_id = sc.store_id
