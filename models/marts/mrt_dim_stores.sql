with stores as (
    select * from {{ ref('stg_bike__stores') }}
),

staffs as (
    select * from {{ ref('stg_bike__staffs') }}
),

staff_count as (
    select
        store_id,
        count(*)                                as nb_staff,
        count(case when active = 1 then 1 end)  as nb_staff_active
    from staffs
    group by store_id
),

final as (
    select
        s.store_id,
        s.store_name,
        s.city,
        s.state,
        s.email,
        coalesce(sc.nb_staff, 0)        as nb_staff,
        coalesce(sc.nb_staff_active, 0) as nb_staff_active
    from stores         as s
    left join staff_count as sc on s.store_id = sc.store_id
)

select * from final
