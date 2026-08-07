with source as (

    select *
    from {{ source('adventure_works', 'person_stateprovince') }}

),

corrections as (

    select *
    from {{ ref('state_province_name_corrections') }}

),

renamed as (

    select
        s.stateprovinceid as state_province_id,
        s.stateprovincecode as state_province_code,
        s.countryregioncode as country_region_code,
        coalesce(c.corrected_name, s.name) as state_province_name,
        s.territoryid as territory_id,
        cast(s.modifieddate as timestamp) as modified_at

    from source as s
    left join corrections as c
    on s.countryregioncode = c.country_region_code and s.name = c.original_name

)

select *
from renamed