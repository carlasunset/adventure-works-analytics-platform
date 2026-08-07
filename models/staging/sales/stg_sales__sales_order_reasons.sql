with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        salesreasonid as sales_reason_id,
        cast(date_format(modifieddate, "yyyy-MM-dd") as date) as modified_at
    from source
)

select * 
from renamed