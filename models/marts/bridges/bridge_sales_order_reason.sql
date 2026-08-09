with order_reasons as (

    select
        sales_order_id,
        sales_reason_id
    from {{ ref('int_sales__order_reasons_enriched') }}

),

sales_reasons as (

    select
        sales_reason_key,
        sales_reason_id
    from {{ ref('dim_sales_reason') }}

),

final as (

    select
        ore.sales_order_id,
        sr.sales_reason_key
    from order_reasons as ore

    inner join sales_reasons as sr
        on ore.sales_reason_id = sr.sales_reason_id

)

select *
from final