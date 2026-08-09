with source_orders as (

    select
        count(distinct sales_order_id) as total_orders
    from {{ ref('stg_sales__sales_orders') }}

),

intermediate_orders as (

    select
        count(distinct sales_order_id) as total_orders
    from {{ ref('int_sales__order_reasons_enriched') }}

)

select
    source_orders.total_orders as source_total_orders,
    intermediate_orders.total_orders as intermediate_total_orders
from source_orders
cross join intermediate_orders
where source_orders.total_orders <> intermediate_orders.total_orders