with source as (

    select *
    from {{ source('adventure_works', 'sales_store') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        name as store_name,
        salespersonid as sales_person_id,
        cast(modifieddate as timestamp) as modified_at
    from source
)

select *
from renamed