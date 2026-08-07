with source as (

    select *
    from {{ source('adventure_works', 'production_product') }}

),

renamed as (

    select 
        productid as product_id,
        name as product_name
    from source

)

select *
from renamed