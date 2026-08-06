with source as (

    select *
    from {{ source('adventure_works', 'sales_salesorderdetail') }}

),

renamed as (

    select
        salesorderdetailid as sales_order_detail_id,
        salesorderid as sales_order_id,
        productid as product_id,
        orderqty as order_quantity,
        unitprice as unit_price,
        unitpricediscount as unit_price_discount,
        modifieddate as modified_at
    from source

)

select * 
from renamed