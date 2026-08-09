with orders as (

    select
        sales_order_id
    from {{ ref('stg_sales__sales_orders') }}

),

order_reasons as (

    select
        sales_order_id,
        sales_reason_id
    from {{ ref('stg_sales__sales_order_reasons') }}

),

sales_reasons as (

    select
        sales_reason_id,
        sales_reason_name,
        sales_reason_type
    from {{ ref('stg_sales__sales_reasons') }}

),

orders_with_reasons as (

    select
        ore.sales_order_id,
        ore.sales_reason_id,
        sr.sales_reason_name,
        sr.sales_reason_type
    from order_reasons as ore

    inner join sales_reasons as sr
        on ore.sales_reason_id = sr.sales_reason_id

),

orders_without_reasons as (

    select
        o.sales_order_id,
        -1 as sales_reason_id,
        'No Sales Reason' as sales_reason_name,
        'No Sales Reason' as sales_reason_type
    from orders as o

    left join order_reasons as ore
        on o.sales_order_id = ore.sales_order_id

    where ore.sales_order_id is null

),

final as (

    select * from orders_with_reasons

    union all

    select * from orders_without_reasons

)

select *
from final