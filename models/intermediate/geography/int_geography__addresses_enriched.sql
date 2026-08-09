with addresses as (

    select
       *
    from {{ ref('stg_person__addresses') }}

),

state_provinces as (

    select
        state_province_id,
        state_province_code,
        country_region_code,
        state_province_name
    from {{ ref('stg_person__state_provinces') }}

),

country_regions as (

    select
        country_region_code,
        country_region_name
    from {{ ref('stg_person__country_regions') }}

),

addresses_enriched as (

    select
        a.address_id,
        a.city,
        a.postal_code,
        a.state_province_id,
        sp.state_province_code,
        sp.state_province_name,
        sp.country_region_code,
        cr.country_region_name,
        a.modified_at
    from addresses as a

    left join state_provinces as sp
        on a.state_province_id = sp.state_province_id

    left join country_regions as cr
        on sp.country_region_code = cr.country_region_code

)

select *
from addresses_enriched