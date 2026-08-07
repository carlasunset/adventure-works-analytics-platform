with source as (

    select *
    from {{ source('adventure_works', 'person_address') }}

),

renamed as (

    select
        addressid as address_id,
        city,
        stateprovinceid as state_province_id,
        postalcode as postal_code,
        modifieddate as modified_at
    from source
)

select * 
from renamed