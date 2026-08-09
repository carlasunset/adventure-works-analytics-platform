with intermediate_count as (

    select count(*) as total_rows
    from {{ ref('int_sales__order_reasons_enriched') }}

),

bridge_count as (

    select count(*) as total_rows
    from {{ ref('bridge_sales_order_reason') }}

)

select
    intermediate_count.total_rows as intermediate_total,
    bridge_count.total_rows as bridge_total
from intermediate_count
cross join bridge_count
where intermediate_count.total_rows <> bridge_count.total_rows