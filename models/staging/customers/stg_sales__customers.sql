with source as (

    select * 
    from {{ source('adventure_works', 'sales_customer') }}

),

renamed as (

    select
        customerid as customer_id,
        cast(personid as int) as person_id,
        cast(storeid as int) as store_id,
        territoryid as territory_id,
        cast(modifieddate as timestamp) as modified_at
    from source

)

select * 
from renamed