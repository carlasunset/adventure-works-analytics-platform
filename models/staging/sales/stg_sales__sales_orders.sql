with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderheader') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        cast(date_format(orderdate, "yyyy-MM-dd") as date) as order_date,
        status,
        customerid as customer_id,
        territoryid as territory_id,
        billtoaddressid as bill_to_address_id,
        shiptoaddressid as ship_to_address_id,
        cast(creditcardid as bigint) as credit_card_id,
        cast(subtotal as decimal(18,4)) as subtotal,
        cast(taxamt as decimal(18,4)) as tax_amount,
        cast(freight as decimal(18,4)) as freight_amount,
        cast(totaldue as decimal(18,4)) as total_due,
        cast(date_format(modifieddate, "yyyy-MM-dd") as date) as order_modified_at
    from source

)

select *
from renamed