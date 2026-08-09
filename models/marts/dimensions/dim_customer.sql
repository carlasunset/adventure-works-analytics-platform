with customers as (

    select
        customer_id,
        full_name,
        person_type,
        store_name
    from {{ ref('int_customers__enriched') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
        customer_id,
        full_name,
        person_type,
        store_name
    from customers

)

select *
from final