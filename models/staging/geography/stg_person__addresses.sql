with source as (

    select *
    from {{ source('adventure_works', 'person_address') }}

),

renamed as (

    select
        addressid as address_id,

        case
            when city = 'SÃ¨vres' then 'Sèvres'
            when city = 'MÃ¼nster' then 'Münster'
            when city = 'MÃ¼hlheim' then 'Mühlheim'
            else city
        end as city,

        stateprovinceid as state_province_id,
        postalcode as postal_code,
        cast(date_format(modifieddate, 'yyyy-MM-dd HH:mm:ss') as timestamp) as modified_at
    from source

)

select *
from renamed