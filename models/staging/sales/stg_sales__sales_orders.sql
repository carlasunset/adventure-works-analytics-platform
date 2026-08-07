with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderheader') }}

),

renamed as (

    select
        salesorderid as sales_order_id,
        orderdate as order_date,
        status,
        customerid as customer_id,
        territoryid as territory_id,
        billtoaddressid as bill_to_address_id,
        shiptoaddressid as ship_to_address_id,
        creditcardid as credit_card_id,
        subtotal,
        taxamt as tax_amount,
        freight as freight_amount,
        totaldue as total_due,
        modifieddate as order_modified_at
    from source

)

select *
from renamed