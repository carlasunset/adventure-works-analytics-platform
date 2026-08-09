with source_count as (

    select count(*) as total
    from {{ ref('stg_sales__customers') }}

),

intermediate_count as (

    select count(*) as total
    from {{ ref('int_customers__enriched') }}

)

select *
from source_count
cross join intermediate_count
where source_count.total <> intermediate_count.total