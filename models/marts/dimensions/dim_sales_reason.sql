with sales_reasons as (

    select distinct
        sales_reason_id,
        sales_reason_name,
        sales_reason_type
    from {{ ref('int_sales__order_reasons_enriched') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['sales_reason_id']) }} as sales_reason_key,
        sales_reason_id,
        sales_reason_name,
        sales_reason_type
    from sales_reasons

)

select *
from final