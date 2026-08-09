with source_count as (

    select count(*) as total
    from {{ ref('stg_person__addresses') }}

),

intermediate_count as (

    select count(*) as total
    from {{ ref('int_geography__addresses_enriched') }}

)

select
    source_count.total as source_total,
    intermediate_count.total as intermediate_total
from source_count
cross join intermediate_count
where source_count.total <> intermediate_count.total