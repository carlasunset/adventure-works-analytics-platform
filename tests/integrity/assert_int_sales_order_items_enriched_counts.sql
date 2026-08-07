with validation as (

    select
        count(*) as total_rows,
        count(distinct sales_order_detail_id) as total_order_items,
        count(distinct sales_order_id) as total_orders
    from {{ ref('int_sales__order_items_enriched') }}

)

select *
from validation
where
    total_rows != 121317
    or total_order_items != 121317
    or total_orders != 31465