with source as (

    select *
    from {{ source('adventure_works', 'person_person') }}

),

renamed as (

    select
        businessentityid as business_entity_id,
        persontype as person_type,
        firstname as first_name,
        middlename as middle_name,
        lastname as last_name,
        trim(concat_ws(' ', firstname, middlename, lastname)) as full_name,
        cast(modifieddate as timestamp) as modified_at
    from source
)

select * 
from renamed