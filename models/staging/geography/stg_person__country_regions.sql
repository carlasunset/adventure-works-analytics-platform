with source as (

    select *
    from {{ source('adventure_works', 'person_countryregion') }}

),

renamed as (

    select
        countryregioncode as country_region_code,
        name as country_region_name,
        modifieddate as modified_at
    from source
)

select * 
from renamed