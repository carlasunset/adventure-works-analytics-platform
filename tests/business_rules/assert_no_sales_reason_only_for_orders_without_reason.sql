with orders_with_source_reason as (

    select distinct
        sales_order_id
    from {{ ref('stg_sales__sales_order_reasons') }}

),

invalid_orders as (

    select
        i.sales_order_id
    from {{ ref('int_sales__order_reasons_enriched') }} as i

    inner join orders_with_source_reason as s
        on i.sales_order_id = s.sales_order_id

    where i.sales_reason_id = -1

)

select *
from invalid_orders