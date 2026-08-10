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
        cast(unitprice as decimal(18,4)) as unit_price,
        cast(unitpricediscount as decimal(18,4)) as unit_price_discount,
        cast(date_format(modifieddate, "yyyy-MM-dd") as date) as item_modified_at
    from source

)

select * 
from renamed