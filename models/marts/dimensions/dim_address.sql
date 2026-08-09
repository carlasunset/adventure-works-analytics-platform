with addresses as (

    select
        address_id,
        city,
        state_province_code,
        state_province_name,
        country_region_code,
        country_region_name
    from {{ ref('int_geography__addresses_enriched') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_key,
        address_id,
        city,
        state_province_code,
        state_province_name,
        country_region_code,
        country_region_name
    from addresses

)

select *
from final