with source as (

    select *
    from {{ source('adventure_works', 'sales_salesterritory') }}

),

renamed as (

    select
        territoryid as territory_id,
        name as territory_name,
        countryregioncode as country_region_code,
        group as territory_group,
        modifieddate as modified_at
    from source
)

select * 
from renamed